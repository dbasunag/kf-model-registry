#!/usr/bin/env bash

set -e

echo "Check if Data Science Cluster exists"
DSC_NAME="default-dsc"

if kubectl get datasciencecluster "$DSC_NAME" &> /dev/null; then
  echo "DataScienceCluster '$DSC_NAME' exists."
else
  echo "DataScienceCluster '$DSC_NAME' does NOT exist."
  exit 1
fi

echo "Delete modelregistry resource"
MR_NAMESPACE=$(kubectl get datasciencecluster "$DSC_NAME" -o jsonpath='{.spec.components.modelregistry.registriesNamespace}' 2>/dev/null)
kubectl delete modelregistry.modelregistry.opendatahub.io model-registry -n "$MR_NAMESPACE"
echo "Update Data Science Cluster"
kubectl patch datasciencecluster default-dsc -p '{"spec":{"components":{"modelregistry":{"managementState":"Removed"}}}}' --type=merge -o yaml

echo "Delete namespace '$MR_NAMESPACE'."
kubectl delete namespace "$MR_NAMESPACE" --wait=False
 kubectl wait --for=delete namespace/"$$MR_NAMESPACE" --timeout=10m

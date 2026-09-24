#!/usr/bin/env bash

set -e

SEAWEEDFS_NAMESPACE="seaweedfs"
unset KF_MR_TEST_ACCESS_KEY_ID KF_MR_TEST_SECRET_ACCESS_KEY KF_MR_TEST_S3_ENDPOINT KF_MR_TEST_BUCKET_NAME

echo 'Delete SeaweedFS namespace if exists'
kubectl delete namespace $SEAWEEDFS_NAMESPACE --wait=False

echo "Waiting for namespace $NAMESPACE_TO_DELETE to be deleted..."

kubectl wait --for=delete namespace/"$SEAWEEDFS_NAMESPACE" --timeout=300s

#!/usr/bin/env bash

set -e

# Backward-compatible entry point. Storage is now provided by SeaweedFS.
exec "$(dirname "$0")/deploy_seaweedfs_on_kind.sh" "$@"

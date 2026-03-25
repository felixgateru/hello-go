#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

if [ "${1-}" = "" ]; then
  echo "Usage: release/helm/build.sh <version>"
  exit 1
fi

VERSION="$1"

# Convert daily versions to semver-compatible prerelease format
# daily-20260325-abc123 -> 0.0.0-daily.20260325.abc123
if [[ "$VERSION" =~ ^daily- ]]; then
  VERSION="0.0.0-${VERSION//-/.}"
fi

echo "Building and pushing hello-go Helm chart (version: ${VERSION})"

# Package the Helm chart
helm package ./helm/hello-go --version "${VERSION}" --app-version "${VERSION}"

# Push to GHCR
helm push "hello-go-${VERSION}.tgz" oci://ghcr.io/felixgateru/charts

echo "Helm chart hello-go:${VERSION} pushed successfully"
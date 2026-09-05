#!/usr/bin/env bash
#
# Empties all object versions and delete markers from a versioned S3 bucket,
# so the (now empty) bucket can be deleted.
#
# Usage: ./empty-versioned-bucket.sh <bucket-name>

set -euo pipefail

usage() {
  echo "Usage: $0 <bucket-name>" >&2
  exit 1
}

[[ $# -eq 1 ]] || usage
BUCKET="$1"

for bin in aws jq; do
  if ! command -v "$bin" >/dev/null 2>&1; then
    echo "Error: '$bin' is required but not installed or not on PATH." >&2
    exit 1
  fi
done

echo "This will permanently delete ALL object versions and delete markers in bucket: $BUCKET"
echo "This action cannot be undone."
read -r -p "Type the bucket name to confirm: " confirmation

if [[ "$confirmation" != "$BUCKET" ]]; then
  echo "Confirmation did not match. Aborting." >&2
  exit 1
fi

echo "Emptying versioned bucket: $BUCKET"

while true; do
  raw=$(aws s3api list-object-versions \
    --bucket "$BUCKET" \
    --max-items 1000 \
    --output json \
    --query '{Objects: Versions[].{Key:Key,VersionId:VersionId}, Markers: DeleteMarkers[].{Key:Key,VersionId:VersionId}}')

  batch=$(jq -c '{Objects: ((.Objects // []) + (.Markers // []))}' <<<"$raw")
  count=$(jq '.Objects | length' <<<"$batch")

  if [[ "$count" -eq 0 ]]; then
    echo "Bucket is empty."
    break
  fi

  echo "Deleting $count object version(s)/delete marker(s)..."
  aws s3api delete-objects --bucket "$BUCKET" --delete "$batch" >/dev/null
done

echo "Done. Bucket '$BUCKET' is empty and can now be deleted."

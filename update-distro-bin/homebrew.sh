#!/bin/bash

set -o errexit	# set -e
set -o nounset	# set -u

SRC_DIR="$1"

pushd "$SRC_DIR"

TAG="$(git tag -l --sort='-authordate' 'neomutt-*' | head -1)"
HASH="$(git rev-parse "$TAG")"

popd

echo "Homebrew"
echo
echo "Tag:  $TAG"
echo "Hash: $HASH"
echo


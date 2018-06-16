#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SOURCE="${0%/*}"

YAML="$SOURCE/coverity.yml"
TRAVIS=".travis.yml"

cp -v "$YAML" "$TRAVIS"
git add "$TRAVIS"
git commit -m "travis: add coverity config"
git log --oneline -n1


#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SOURCE="${0%/*}"

YAML="$SOURCE/translate.yml"
TRAVIS=".travis.yml"

git checkout -b translate master

cp -v "$YAML" "$TRAVIS"
git add "$TRAVIS"
git commit -m "travis: add translate config" -m "[ci skip]"
git log --oneline -n1


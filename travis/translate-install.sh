#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SOURCE="${0%/*}"

YAML="$SOURCE/translate.yml"
TRANSDIR="$SOURCE/translate"
TRAVIS=".travis.yml"

git checkout -b translate master

mkdir .travis
cp -v "$YAML" "$TRAVIS"
cp -v "$TRANSDIR"/*.sh  .travis
cp -v "$TRANSDIR"/*.enc .travis

git add "$TRAVIS" .travis
git commit -m "travis: add translate config"
git log --oneline -n1


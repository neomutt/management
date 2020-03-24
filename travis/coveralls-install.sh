#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SOURCE="${0%/*}"

YAML="$SOURCE/coveralls.yml"
TRAVIS=".travis.yml"

git checkout -b coveralls master

cp -v "$YAML" "$TRAVIS"
git rm .cirrus.yml
git add "$TRAVIS"
git commit -m "travis: add coveralls config"
git log --oneline -n1


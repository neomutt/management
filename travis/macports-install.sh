#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SOURCE="${0%/*}"

YAML="$SOURCE/macports.yml"
PORTDIR="$SOURCE/macports"
TRAVIS=".travis.yml"

git checkout -b distro/macports master

mkdir macports
cp -v "$YAML" "$TRAVIS"
cp -v "$PORTDIR/bootstrap.sh" macports
cp -v "$PORTDIR/Portfile"     macports

git add "$TRAVIS" macports
git commit -m "travis: add macports config"
git log --oneline -n1


#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SOURCE="${0%/*}"

YAML="$SOURCE/release.yml"
RELDIR="$SOURCE/release"
TRAVIS=".travis.yml"

git checkout -b release master

mkdir .travis
cp -v "$YAML" "$TRAVIS"
cp -v "$RELDIR/gitignore"    .gitignore
cp -v "$RELDIR"/*.txt        .travis
cp -v "$RELDIR"/*.rc         .travis
cp -v "$RELDIR"/*.sh         .travis
cp -v "$RELDIR/README.md"    .
cp -v "$RELDIR/doxygen.conf" doxygen

git add "$TRAVIS" .travis .gitignore README.md doxygen
git commit -m "travis: add release config"
git log --oneline -n1


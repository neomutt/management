#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SOURCE="${0%/*}"

RELDIR="$SOURCE/fuzzer"

git checkout -b fuzzer master

cp -r "$RELDIR"/fuzz .

git apply "$RELDIR"/fuzzer.diff

git rm .cirrus.yml
git add .gitignore Makefile.autosetup auto.def main.c fuzz
git commit -m "travis: add fuzzer config"
git log --oneline -n1


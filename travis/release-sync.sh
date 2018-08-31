#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SCRIPT_DIR="${0%/*}"

source "$SCRIPT_DIR/sync-common.sh"

MGMT=(
	"release/gitignore"
	"release/travis.yml"
	"release/install-dirs.txt"
	"release/install-files.txt"
	"release/neomutt-d1.rc"
	"release/neomutt-d1.txt"
	"release/neomutt-d2.rc"
	"release/neomutt-d2.txt"
	"release/release-test.sh"
	"release/README.md"
	"release/doxygen.conf"
)

CODE=(
	".gitignore"
	".travis.yml"
	".travis/install-dirs.txt"
	".travis/install-files.txt"
	".travis/neomutt-d1.rc"
	".travis/neomutt-d1.txt"
	".travis/neomutt-d2.rc"
	".travis/neomutt-d2.txt"
	".travis/release-test.sh"
	"README.md"
	"doxygen/doxygen.conf"
)

sync_perform "$@"


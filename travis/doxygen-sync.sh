#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SCRIPT_DIR="${0%/*}"

source "$SCRIPT_DIR/sync-common.sh"

MGMT=(
	"doxygen/doxygen/doxygen.conf"
	"doxygen/doxygen/libemail.gv"
	"doxygen/doxygen/libemail.svg"
	"doxygen/doxygen/libmutt.gv"
	"doxygen/doxygen/libmutt.svg"
	"doxygen/gen-tables.sh"
	"doxygen/gitignore"
	"doxygen/main.inc"
	"doxygen/misc.inc"
	"doxygen/travis.yml"
)

CODE=(
	"doxygen/doxygen.conf"
	"doxygen/libemail.gv"
	"doxygen/libemail.svg"
	"doxygen/libmutt.gv"
	"doxygen/libmutt.svg"
	".travis/gen-tables.sh"
	".gitignore"
	"main.inc"
	"misc.inc"
	".travis.yml"
)

sync_perform "$@"


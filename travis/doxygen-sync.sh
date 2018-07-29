#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SCRIPT_DIR="${0%/*}"

source "$SCRIPT_DIR/sync-common.sh"

MGMT=(
	"doxygen/doxygen/config.svg"
	"doxygen/doxygen/doxygen.conf"
	"doxygen/doxygen/enums.svg"
	"doxygen/doxygen/functions.svg"
	"doxygen/doxygen/generate.sh"
	"doxygen/doxygen/globals.svg"
	"doxygen/doxygen/libemail.gv"
	"doxygen/doxygen/libemail.svg"
	"doxygen/doxygen/libmutt.gv"
	"doxygen/doxygen/libmutt.svg"
	"doxygen/doxygen/members.svg"
	"doxygen/doxygen/structs.svg"
	"doxygen/gitignore"
	"doxygen/main.inc"
	"doxygen/travis.yml"
)

CODE=(
	"doxygen/config.svg"
	"doxygen/doxygen.conf"
	"doxygen/enums.svg"
	"doxygen/functions.svg"
	"doxygen/generate.sh"
	"doxygen/globals.svg"
	"doxygen/libemail.gv"
	"doxygen/libemail.svg"
	"doxygen/libmutt.gv"
	"doxygen/libmutt.svg"
	"doxygen/members.svg"
	"doxygen/structs.svg"
	".gitignore"
	"main.inc"
	".travis.yml"
)

sync_perform "$@"


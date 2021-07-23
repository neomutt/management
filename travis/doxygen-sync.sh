#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SCRIPT_DIR="${0%/*}"

source "$SCRIPT_DIR/sync-common.sh"

MGMT=(
	"doxygen/doxygen/config.svg"
	"doxygen/doxygen/deploy.sh"
	"doxygen/doxygen/doxygen.conf"
	"doxygen/doxygen/enums.svg"
	"doxygen/doxygen/functions.svg"
	"doxygen/doxygen/generate.sh"
	"doxygen/doxygen/globals.svg"
	"doxygen/doxygen/layout.xml"
	"doxygen/doxygen/libemail.gv"
	"doxygen/doxygen/libemail.svg"
	"doxygen/doxygen/libmutt.gv"
	"doxygen/doxygen/libmutt.svg"
	"doxygen/doxygen/members.svg"
	"doxygen/doxygen/pages.svg"
	"doxygen/doxygen/structs.svg"
	"doxygen/doxygen/travis-deploy-doxygen.enc"
	"doxygen/gitignore"
	"doxygen/travis.yml"
)

CODE=(
	"doxygen/config.svg"
	"doxygen/deploy.sh"
	"doxygen/doxygen.conf"
	"doxygen/enums.svg"
	"doxygen/functions.svg"
	"doxygen/generate.sh"
	"doxygen/globals.svg"
	"doxygen/layout.xml"
	"doxygen/libemail.gv"
	"doxygen/libemail.svg"
	"doxygen/libmutt.gv"
	"doxygen/libmutt.svg"
	"doxygen/members.svg"
	"doxygen/pages.svg"
	"doxygen/structs.svg"
	"doxygen/travis-deploy-doxygen.enc"
	".gitignore"
	".travis.yml"
)

sync_perform "$@"


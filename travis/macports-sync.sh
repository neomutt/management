#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SCRIPT_DIR="${0%/*}"

source "$SCRIPT_DIR/sync-common.sh"

MGMT=(
	"macports/travis.yml"
	"macports/bootstrap.sh"
	"macports/Portfile"
)

CODE=(
	".travis.yml"
	"macports/bootstrap.sh"
	"macports/Portfile"
)

sync_perform "$@"


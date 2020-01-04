#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SCRIPT_DIR="${0%/*}"

source "$SCRIPT_DIR/sync-common.sh"

MGMT=(
	"coveralls.yml"
)

CODE=(
	".travis.yml"
)

sync_perform "$@"


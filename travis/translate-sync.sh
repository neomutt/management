#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SCRIPT_DIR="${0%/*}"

source "$SCRIPT_DIR/sync-common.sh"

MGMT=(
	"translate/travis.yml"
	"translate/deploy.sh"
	"translate/generate-webpage.sh"
	"translate/prep.sh"
	"translate/stats.sh"
	"translate/travis-deploy-github.enc"
)

CODE=(
	".travis.yml"
	".travis/deploy.sh"
	".travis/generate-webpage.sh"
	".travis/prep.sh"
	".travis/stats.sh"
	".travis/travis-deploy-github.enc"
)

sync_perform "$@"


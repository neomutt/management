#!/bin/bash

# parallel build-parallel.sh gcc {} :::: build-parallel.txt

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

function log_error()
{
	echo -e "\e[1;31m$@\e[m"
}

function log_success()
{
	echo -e "\e[1;32m$@\e[m"
}

function die()
{
	[ $? -ne 0 ] && log_error "Build failed"
}

trap die EXIT

COMPILER="${1:-gcc}"
OPTIONS="${2:-}"
DIR="build$PARALLEL_SEQ"

# ------------------------------------------------------------------------------

EXTRA_CFLAGS=()

EXTRA_CFLAGS+=("-ggdb3")
EXTRA_CFLAGS+=("-O0")
EXTRA_CFLAGS+=("-DDEBUG")
# EXTRA_CFLAGS+=("-std=c11")
# EXTRA_CFLAGS+=("-Wextra")
# EXTRA_CFLAGS+=("-Wunused-parameter")
EXTRA_CFLAGS+=("-Wpedantic")
EXTRA_CFLAGS+=("-Wformat-security")
# EXTRA_CFLAGS+=("-Wmacro-redefined")
EXTRA_CFLAGS+=("-Wshadow")
EXTRA_CFLAGS+=("-Wstrict-prototypes")
# EXTRA_CFLAGS+=("-Wsuggest-attribute=format")
EXTRA_CFLAGS+=("-Wundef")
EXTRA_CFLAGS+=("-Wunused-result")
EXTRA_CFLAGS+=("-Wimplicit-fallthrough")
EXTRA_CFLAGS+=("-Wformat-truncation=0")
# EXTRA_CFLAGS+=("-Werror")

# EXTRA_CFLAGS+=("-Wredundant-decls")
# EXTRA_CFLAGS+=("-Wstrict-prototypes")
# EXTRA_CFLAGS+=("-Wmissing-prototypes")

# EXTRA_CFLAGS+=("-fsanitize=address -fsanitize-recover=address")
# EXTRA_CFLAGS+=("-fsanitize=undefined -fno-sanitize-recover=undefined")
# EXTRA_CFLAGS+=("-fsanitize=undefined")
# EXTRA_CFLAGS+=("-fsanitize=address -fsanitize=bool -fsanitize=enum")

# ------------------------------------------------------------------------------

EXTRA_LDFLAGS=()
# EXTRA_LDFLAGS+=("-fprofile-arcs -ftest-coverage")
# EXTRA_LDFLAGS+=("-fsanitize=address -fsanitize-recover=address")
# EXTRA_LDFLAGS+=("-fsanitize=undefined")

# ------------------------------------------------------------------------------

echo "------------------------------------------------------------------------------"
date '+%F %R:%S'
echo -e "$COMPILER $DIR"
echo -e "\\e[1m../configure $OPTIONS\\e[m"

mkdir -p "$DIR"
cd "$DIR"
rm -fr *

../configure CC="$COMPILER" --asan --disable-doc $OPTIONS >> build.log 2>&1

make -j1 -s CC="$COMPILER" EXTRA_CFLAGS="${EXTRA_CFLAGS[*]}" EXTRA_LDFLAGS="${EXTRA_LDFLAGS[*]}" >> build.log 2>&1
echo make test
chronic make test

./neomutt -n -F /dev/null -v >> neomutt-v.log 2>&1

# echo doxygen
# chronic doxygen doxygen/doxygen.conf

log_success "Build succeeded"
date '+%F %R:%S'


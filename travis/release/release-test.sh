#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

function die()
{
	local ERROR=$?

	if [ "${#SOFT_FAIL[@]}" -gt 0 ]; then
		echo "Soft Failures:"
		for i in "${SOFT_FAIL[@]}"; do
			echo "    $i"
		done
		echo "--------------------------------------------------------------------------------"
		ERROR=1
	fi

	echo "--------------------------------------------------------------------------------"
	[ "$ERROR" = 0 ] && echo "SUCCESS" || echo "FAILED"
	echo "--------------------------------------------------------------------------------"

	exit $ERROR
}


trap die EXIT

export LANG=C

EXTRA_CFLAGS="-Wno-unused-result -Werror"

eval INSTALL_DIR="~/install"

BUILD_DEFAULT=""
BUILD_EVERYTHING="--everything"
BUILD_SLANG="--with-ui=slang --with-lock=flock --with-domain=example.com --fmemopen --homespool --locales-fix --mixmaster --ssl"
BUILD_CURSES="--with-ui=ncurses --with-lock=fcntl --gnutls --gpgme --gss --sasl --lua --notmuch --bdb --gdbm --kyotocabinet --lmdb --qdbm --tokyocabinet --full-doc --testing --coverage"

SOFT_FAIL=()

function header()
{
	echo
	echo "--------------------------------------------------------------------------------"
	echo "Release Tests"
	echo "--------------------------------------------------------------------------------"
	echo
}

function start_fold()
{
	travis_fold start "$2"
	travis_time_start
	echo "$1"
}

function end_fold()
{
	travis_time_finish
	travis_fold end "$1"
}

function clean_dir()
{
	git clean -xd --force --quiet
}

function test_build()
{
	local DIR="$1"
	local NAME="$2"
	local CONFIG="$3"

	start_fold "Configure" "configure.$NAME"

	clean_dir

	echo "-------------------------------------------------------------------------------"
	echo "BUILD:  $NAME"
	echo "COMMIT: https://github.com/neomutt/neomutt/commit/$(git rev-parse HEAD)"
	echo "CONFIG: $CONFIG"
	echo "-------------------------------------------------------------------------------"

	if ! $DIR/configure $CONFIG; then
		if [ -f config.log ]; then
			echo "-------------------------------------------------------------------------------"
			start_fold "Config Log" "config.log.$NAME"
			cat config.log
			end_fold "config.log.$NAME"
			exit 1
		fi
	fi
	end_fold "configure.$NAME"

	start_fold "Build" "make.$NAME"
	make -j2 EXTRA_CFLAGS="$EXTRA_CFLAGS" || exit 1
	echo

	end_fold "make.$NAME"
}

function test_install()
{
	local DIR="$1"
	local NAME="$2"

	start_fold "Install" "install.$NAME"

	rm -fr "$INSTALL_DIR"
	make DESTDIR="$INSTALL_DIR" install

	(cd "$INSTALL_DIR"; find . -type d) > install-dirs.txt
	(cd "$INSTALL_DIR"; find . -type f) > install-files.txt

	local IFAIL=0
	echo "Dirs diff"                                                      >  install-diff.txt
	diff <(sort $DIR/.travis/install-dirs.txt) <(sort install-dirs.txt)   >> install-diff.txt || IFAIL=1
	echo "Files diff"                                                     >> install-diff.txt
	diff <(sort $DIR/.travis/install-files.txt) <(sort install-files.txt) >> install-diff.txt || IFAIL=1

	if [ $IFAIL = 1 ]; then
		SOFT_FAIL+=("Install $NAME failed");
		echo "----------------------------------------"
		cat install-diff.txt
		echo "----------------------------------------"
	fi

	end_fold "install.$NAME"
}

function test_uninstall()
{
	local NAME="$1"

	start_fold "Uninstall" "install.$NAME"

	make DESTDIR="$INSTALL_DIR" uninstall

	(cd "$INSTALL_DIR"; find . -type f) | sort -f > install-files.txt

	if [ -s install-files.txt ]; then
		SOFT_FAIL+=("Uninstall $NAME failed");
		echo "----------------------------------------"
		echo "Files left behind"
		cat install-files.txt
		echo "----------------------------------------"
	fi

	end_fold "install.$NAME"
}

function test_docs()
{
	start_fold "Test docs" "docs"

	make validate-doc

	end_fold "docs"
}

function test_config()
{
	start_fold "NeoMutt defaults" "defaults"

	./neomutt -n -F .travis/neomutt-d1.rc -D > neomutt-d1.txt
	if ! diff <(sort .travis/neomutt-d1.txt) <(sort neomutt-d1.txt) > neomutt-d1-diff.txt; then
		SOFT_FAIL+=("NeoMutt defaults differ");
		echo "----------------------------------------"
		cat neomutt-d1-diff.txt
		echo "----------------------------------------"
	fi

	./neomutt -n -F .travis/neomutt-d2.rc -D | grep -v "^Debugging" > neomutt-d2.txt
	if ! diff <(sort .travis/neomutt-d2.txt) <(sort neomutt-d2.txt) > neomutt-d2-diff.txt; then
		SOFT_FAIL+=("NeoMutt alternates differ");
		echo "----------------------------------------"
		cat neomutt-d2-diff.txt
		echo "----------------------------------------"
	fi

	echo "----------------------------------------"
	cat neomutt-d1.txt
	echo "----------------------------------------"
	cat neomutt-d2.txt
	echo "----------------------------------------"

	end_fold "defaults"
}

function test_acutest()
{
	start_fold "Acutest Unit Tests" "acutest"

	make test

	end_fold "acutest"
}

function test_lua()
{
	start_fold "Lua Scripting" "lua"

	eval $(luarocks path --bin)
	./neomutt -B -F contrib/lua/test_lua-api_runner.neomuttrc

	end_fold "lua"
}

function test_whitespace()
{
	start_fold "Whitespace" "whitespace"

	TEST="Trailing whitespace"
	echo "$TEST"
	grep -lR --exclude-dir='.git' --exclude='acutest.h' --exclude='*.png' '[[:space:]]$' && SOFT_FAIL+=("$TEST") || true

	TEST="Tabs in code"
	echo "$TEST"
	grep -lR --exclude='*' --include='*.[ch]' --exclude='jimsh0.c' --exclude='queue.h' '	' && SOFT_FAIL+=("$TEST") || true

	TEST="Space-Tab"
	echo "$TEST"
	grep -lR --exclude-dir='.git' --exclude='*.png' --exclude='jimsh0.c' --exclude='queue.h' ' \	' && SOFT_FAIL+=("$TEST") || true

	end_fold "whitespace"
}

function test_potfiles()
{
	start_fold "Translation file list" "potfiles"

	(
		echo opcodes.h
		find . \( -name .git -o -path './test/*' -o -path './autosetup/*' -o -path './doc/*' -o -name 'conststrings.c' -o -name 'git_ver.c' \) -prune -o -type f -name '*.c' -print | cut -b3-
	) | sort > potfiles.txt

	if ! diff <(sort po/POTFILES.in) <(sort potfiles.txt) > potfiles-diff.txt; then
		SOFT_FAIL+=("Translation file lists differ");
		echo "----------------------------------------"
		cat potfiles-diff.txt
		echo "----------------------------------------"
	fi

	end_fold "potfiles"
}

function test_stats()
{
	local TMP_FILE="stats.txt"
	local BAD_LANG=()

	start_fold "Language Statistics" "stats"

	for i in po/*.po; do
		L="${i##*/}"
		L="${L%.po}"
		echo -ne "$L:\\t"
		msgfmt --statistics -c -o /dev/null "$i" 2>&1 || BAD_LANG+=("$L")
	done > "$TMP_FILE"

	sed 's/ \(message\|translation\)s*\.*//g' "$TMP_FILE" | sort -k1 | sort -s -nr -k2 -k4 -k6

	if [ "${#BAD_LANG[@]}" -gt 0 ]; then
		echo "----------------------------------------"
		echo "Bad languages: ${BAD_LANG[@]}"
		echo "----------------------------------------"
	fi

	end_fold "stats"
}

function test_update_po()
{
	start_fold "Update translations" "update_po"

	make update-po
	git checkout po/*.po

	end_fold "update_po"
}

function test_doxygen()
{
	start_fold "Doxygen Code Docs" "doxygen"

	(
		cat doxygen/doxygen.conf
		echo "WARN_AS_ERROR=yes"
	) | doxygen - || SOFT_FAIL+=("doxygen")

	end_fold "doxygen"
}


header

# Build
test_build     . default    "$BUILD_DEFAULT"
test_build     . everything "$BUILD_EVERYTHING"
test_build     . slang      "$BUILD_SLANG"
test_build     . curses     "$BUILD_CURSES"
test_install   . normal
test_uninstall   normal

# Translations
test_potfiles
test_stats
test_update_po

# Code
test_docs
test_config
test_acutest
# test_lua
clean_dir
test_whitespace
test_doxygen

# Out-of-tree build
clean_dir
mkdir p
pushd p
test_build     .. out_of_tree "$BUILD_CURSES"
test_install   .. out_of_tree
test_uninstall    out_of_tree
popd

exit 0


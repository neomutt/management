#!/bin/bash

BASE_DIR="${0%/*}"

for i in "$@"; do
	[ "$i" = "mutt_curses.h" ] && continue

	iwyu \
		-D_ALL_SOURCE=1 \
		-D_GNU_SOURCE=1 \
		-D__EXTENSIONS__ \
		-DNCURSES_WIDECHAR \
		-DDEBUG \
		-I . \
		-I progress \
		-I /usr/lib/gcc/x86_64-redhat-linux/11/include \
		-I /usr/include/qdbm \
		-Xiwyu --mapping_file="$BASE_DIR/progress.imp" \
		-Xiwyu --no_comments \
		-Xiwyu --pch_in_code \
		"$i"
done


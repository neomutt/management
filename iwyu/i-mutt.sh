#!/bin/bash

BASE_DIR="${0%/*}"

for i in "$@"; do
	iwyu \
		-D_ALL_SOURCE=1 \
		-D_GNU_SOURCE=1 \
		-D__EXTENSIONS__ \
		-DNCURSES_WIDECHAR \
		-DDEBUG \
		-I . \
		-I mutt \
    -I /usr/lib/gcc/x86_64-redhat-linux/9/include \
		-Xiwyu --pch_in_code \
		-Xiwyu --no_comments \
		-Xiwyu --mapping_file="$BASE_DIR/mutt.imp" \
		"$i"
done

		# -DLOFF_T=long \
		# -DSIG_ATOMIC_VOLATILE_T=volatile \

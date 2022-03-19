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
		-I compmbox \
		-I /usr/lib/gcc/x86_64-redhat-linux/11/include \
		-I /usr/include/qdbm \
		-Xiwyu --mapping_file="$BASE_DIR/compmbox.imp" \
		-Xiwyu --no_comments \
		-Xiwyu --pch_in_code \
		"$i"
done

		# -DPKGDATADIR="/usr/share/neomutt" \
		# -DSYSCONFDIR="/etc" \
		# -DSIG_ATOMIC_VOLATILE_T=volatile \
		# -DLOFF_T=long \

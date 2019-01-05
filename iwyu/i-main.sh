#!/bin/bash

iwyu \
	-D_ALL_SOURCE=1 \
	-D_GNU_SOURCE=1 \
	-D__EXTENSIONS__ \
	-DNCURSES_WIDECHAR \
	-DDEBUG \
	-I . \
	-I /usr/lib/gcc/x86_64-redhat-linux/8/include \
	-I /usr/include/qdbm \
	-Xiwyu --mapping_file=neomutt.imp \
	-Xiwyu --no_comments \
	-Xiwyu --pch_in_code \
	"$@"

	# -DPKGDATADIR="/usr/share/neomutt" \
	# -DSYSCONFDIR="/etc" \
	# -DSIG_ATOMIC_VOLATILE_T=volatile \
	# -DLOFF_T=long \

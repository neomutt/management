#!/bin/bash

iwyu \
	-D_ALL_SOURCE=1 \
	-D_GNU_SOURCE=1 \
	-D__EXTENSIONS__ \
	-DNCURSES_WIDECHAR \
	-DDEBUG \
	-DLOFF_T=long \
	-DSIG_ATOMIC_VOLATILE_T=volatile \
	-I . \
	-I /usr/lib/gcc/x86_64-redhat-linux/8/include \
	-Xiwyu --pch_in_code \
	-Xiwyu --no_comments \
	-Xiwyu --mapping_file=mutt.imp \
	"$@"


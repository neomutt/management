#!/bin/bash

iwyu \
	-D_ALL_SOURCE=1 \
	-D_GNU_SOURCE=1 \
	-D__EXTENSIONS__ \
	-DNCURSES_WIDECHAR \
	-DDEBUG \
	-DLOFF_T=long \
	-I . \
	-I /usr/lib/gcc/x86_64-redhat-linux/8/include \
	-Xiwyu --pch_in_code \
	-Xiwyu --mapping_file=email.imp \
	"$@"


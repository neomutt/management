#!/bin/bash
# Copyright (c) Richard Russon (FlatCap)
# Released under the GPLv3 (see LICENSE.md)

rm -fr contrib
rm -fr doc
rm -fr doxygen
rm -fr m4
rm -fr po
rm -fr .github

rm -f \
	.clang-format \
	.editorconfig \
	.gitattributes \
	.gitignore \
	.mailmap \
	.travis.yml

rm -f \
	ChangeLog.md \
	CODE_OF_CONDUCT.md \
	CONTRIBUTING.md \
	COPYRIGHT \
	flymake.am \
	hcache/Makefile.am \
	hcache/README.md \
	imap/Makefile.am \
	imap/README \
	INSTALL \
	lib/Makefile.am \
	LICENSE.md \
	Makefile.am \
	ncrypt/Makefile.am \
	README.md \
	README.SSL

rm -f \
	configure.ac \
	gen_defs \
	hcache/hcachever.sh \
	mime.types \
	prepare \
	tags \
	txt2c.sh

rm -f \
	hcache/mutt_md5.c \
	mutt_ssl.c \
	pgpewrap.c \
	pgppubring.c \
	txt2c.c \
	utf8.c \
	wcscasecmp.c \
	wcwidth.c

cat OPS.* >> OPS
rm -fr OPS.*

git add .
git commit -m "min-build: remove unnecessary files"

# read -p "Waiting 1..."

# pre-process a duplicate name
sed -i 's/"message.h"/"message2.h"/' lib/*.[ch]
git mv lib/message.h lib/message2.h
git mv lib/message.c lib/message2.c

# read -p "Waiting 2..."

DIRS="hcache imap lib ncrypt"
for i in $DIRS; do
	git mv $i/* .
	rm -fr $i
done

# read -p "Waiting 3..."

git add .
git commit -m "min-build: flatten ${DIRS// //} into current directory"

# read -p "Waiting 4..."

cp ${0%/*}/min-config.h  config.h
cp ${0%/*}/min-gitignore .gitignore
cp ${0%/*}/min-Makefile  Makefile

git add -f .
git commit -m "min-build: add config.h, gitignore and Makefile"


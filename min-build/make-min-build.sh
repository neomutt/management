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
	hcache/Makefile.am \
	hcache/README.md \
	imap/Makefile.am \
	imap/README \
	INSTALL \
	LICENSE.md \
	Makefile.am \
	ncrypt/Makefile.am \
	README.md \
	README.SSL

rm -f \
	configure.ac \
	flymake.am \
	gen_defs \
	hcache/hcachever.sh \
	mime.types \
	prepare \
	smime_keys.pl \
	tags \
	txt2c.sh

rm -f \
	extlib.c \
	mutt_ssl.c \
	pgpewrap.c \
	pgppubring.c \
	sha1.c \
	sha1.h \
	snprintf.c \
	txt2c.c \
	utf8.c \
	wcscasecmp.c \
	wcwidth.c

cat OPS.* >> OPS
rm -fr OPS.*

git add .
git commit -m "min-build: remove unnecessary files"

for i in imap hcache ncrypt; do
	git mv $i/* .
	rm -fr $i
done

git add .
git commit -m "min-build: flatten imap/hcache/ncrypt into current directory"

cp ${0%/*}/min-config.h  config.h
cp ${0%/*}/min-gitignore .gitignore
cp ${0%/*}/min-Makefile  Makefile

git add -f .
git commit -m "min-build: add config.h, gitignore and Makefile"


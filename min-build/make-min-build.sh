#!/bin/bash
# Copyright (c) Richard Russon (FlatCap)
# Released under the GPLv3 (see LICENSE.md)

rm -fr .hg*
rm -fr contrib
rm -fr doc
rm -fr intl
rm -fr m4
rm -fr po

rm -f \
	ABOUT-NLS \
	BEWARE \
	ChangeLog* \
	COPYRIGHT \
	GPL \
	imap/Makefile.am \
	imap/README \
	imap/TODO \
	INSTALL \
	LICENSE* \
	Makefile.am \
	NEWS \
	PATCHES \
	README* \
	TODO \
	UPDATING* \
	VERSION*

rm -f \
	build-release \
	check_sec.sh \
	configure.ac \
	flymake.am \
	gen_defs \
	git-version-gen \
	hcachever.sh.in \
	hg-changelog-map \
	hg-commit \
	mime.types \
	mkchangelog.sh \
	muttbug \
	muttbug.sh.in \
	patchlist.sh \
	prepare \
	smime_keys.pl \
	stamp-h.in \
	txt2c.sh \
	version.sh

rm -f \
	_regex.h \
	dotlock.c \
	dotlock.h \
	extlib.c \
	mkdtemp.c \
	mutt_ssl.c \
	pgpewrap.c \
	pgppubring.c \
	regex.c \
	setenv.c \
	sha1.c \
	sha1.h \
	snprintf.c \
	strcasecmp.c \
	strcasestr.c \
	strdup.c \
	strndup.c \
	strnlen.c \
	strsep.c \
	strtok_r.c \
	txt2c.c \
	utf8.c \
	wcscasecmp.c \
	wcwidth.c

cat OPS.* >> OPS
rm -fr OPS.*

git add .
git commit -m "min-build: removed unneeded files"

mv imap/* .
rm -fr imap

git add .
git commit -m "min-build: flatten imap into current directory"

cp ${0%/*}/min-config.h  config.h
cp ${0%/*}/min-gitignore .gitignore
cp ${0%/*}/min-Makefile  Makefile

git add -f .
git commit -m "min-build: add config.h, gitignore and Makefile"


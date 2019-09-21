#!/bin/bash

if [ ! -f config.h ]; then
	echo "config.h is missing"
	exit 
fi

if [ ! -f hcache/hcversion.h ]; then
	echo "hcache/hcversion.h is missing"
	exit 
fi

i-address.sh address/*.[ch]
i-config.sh  config/*.[ch]
i-conn.sh    conn/*.[ch]
i-core.sh    core/*.[ch]
i-email.sh   email/*.[ch]
i-mutt.sh    mutt/*.[ch]

i-main.sh \
	*.[ch] \
	autocrypt/*.[ch] \
	hcache/*.[ch] \
	imap/*.[ch] \
	maildir/*.[ch] \
	mbox/*.[ch] \
	ncrypt/*.[ch] \
	nntp/*.[ch] \
	notmuch/*.[ch] \
	pop/*.[ch] \


#!/bin/bash

set -o nounset	# set -u

if [ ! -f config.h ]; then
	echo "config.h is missing"
	exit 1
fi

if [ ! -f hcache/hcversion.h ]; then
	echo "hcache/hcversion.h is missing"
	exit 1
fi

i-address.sh   address/*.[ch]
i-alias.sh     alias/*.[ch]
i-attach.sh    attach/*.[ch]
i-autocrypt.sh autocrypt/*.[ch]
i-bcache.sh    bcache/*.[ch]
i-color.sh     color/*.[ch]
i-compmbox.sh  compmbox/*.[ch]
i-compose.sh   compose/*.[ch]
i-compress.sh  compress/*.[ch]
i-config.sh    config/*.[ch]
i-conn.sh      conn/*.[ch]
i-core.sh      core/*.[ch]
i-debug.sh     debug/*.[ch]
i-email.sh     email/*.[ch]
i-gui.sh       gui/*.[ch]
i-hcache.sh    hcache/*.[ch]
i-helpbar.sh   helpbar/*.[ch]
i-history.sh   history/*.[ch]
i-imap.sh      imap/*.[ch]
i-index.sh     index/*.[ch]
i-maildir.sh   maildir/*.[ch]
i-mbox.sh      mbox/*.[ch]
i-menu.sh      menu/*.[ch]
i-mutt.sh      mutt/*.[ch]
i-ncrypt.sh    ncrypt/*.[ch]
i-nntp.sh      nntp/*.[ch]
i-notmuch.sh   notmuch/*.[ch]
i-pager.sh     pager/*.[ch]
i-pattern.sh   pattern/*.[ch]
i-pop.sh       pop/*.[ch]
i-progress.sh  progress/*.[ch]
i-question.sh  question/*.[ch]
i-send.sh      send/*.[ch]
i-sidebar.sh   sidebar/*.[ch]
i-store.sh     store/*.[ch]

i-main.sh *.[ch]


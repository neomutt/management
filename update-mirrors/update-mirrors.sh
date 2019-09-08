#!/bin/sh
#===============================================================================
## SYNOPSIS
##    update-mirrors
##
## DESCRIPTION
##    This script will pull all of neomutt's mirrored repositories to /tmp,
##    update the repository with it's upstream's latest commits, and push the
##    updates to the mirror.
TMP_DIR=$(mktemp -d -t update-mirror-XXXXXXXX)

# USAGE
#  update_mirror $REPO_NAME $MIRROR_GIT_URL $UPSTREAM_GIT_URL
update_mirror() {
	cd $TMP_DIR
	git clone --mirror $3 $1
	cd $1
	git remote add --mirror=fetch secondary $2
	git fetch origin
	git push secondary --all
}

update_mirror acutest \
	git@github.com:neomutt/acutest.git \
	https://github.com/mity/acutest.git

update_mirror aur-docker \
	git@github.com:neomutt/aur-docker.git \
	https://github.com/WhyNotHugo/docker-makepkg.git

update_mirror autosetup \
	git@github.com:neomutt/autosetup.git \
	https://github.com/msteveb/autosetup.git

update_mirror homebrew-core \
	git@github.com:neomutt/homebrew-core.git \
	https://github.com/Homebrew/homebrew-core.git

update_mirror vim \
	git@github.com:neomutt/vim.git \
	https://github.com/vim/vim.git


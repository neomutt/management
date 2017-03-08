#!/bin/bash

set -o errexit	# set -e
set -o nounset	# set -u

eval HG_DIR="~/hg"
eval NEO_DIR="~/neomutt.git"

NEO_REMOTES="origin github"
NEO_DEFAULT_BRANCH="mutt/default"
NEO_DEFAULT_CLEAN_BRANCH="mutt/default-clean"
NEO_STABLE_BRANCH="mutt/stable"
NEO_STABLE_CLEAN_BRANCH="mutt/stable-clean"
UPSTREAM_DEFAULT_BRANCH="upstream/default"
UPSTREAM_DEFAULT_CLEAN_BRANCH="upstream/default-clean"
UPSTREAM_STABLE_BRANCH="upstream/stable"

TMP_DIR=""

ERROR=0

if [ ! -d "$HG_DIR" ]; then
	echo "Repo doesn't exist: $HG_DIR"
	ERROR=1
fi

if [ ! -d "$NEO_DIR" ]; then
	echo "Repo doesn't exist: $NEO_DIR"
	ERROR=1
fi

[ $ERROR = 1 ] && exit 1

pushd "$HG_DIR"
	hg pull
	hg update
popd

function die()
{
	[ -n "$TMP_DIR" ] && rm --force --recursive "$TMP_DIR"
}


trap die EXIT

cd
TMP_DIR=$(mktemp -u -p $(pwd))

git clone --shared "$NEO_DIR" "$TMP_DIR"

pushd "$TMP_DIR"
	git remote add hg hg::"$HG_DIR"
	git fetch hg

	git checkout -b $UPSTREAM_DEFAULT_BRANCH hg/branches/default
	git push origin $UPSTREAM_DEFAULT_BRANCH:$NEO_DEFAULT_CLEAN_BRANCH
	git checkout -b $NEO_DEFAULT_BRANCH origin/mutt/default
	git merge $UPSTREAM_DEFAULT_BRANCH -m "merge upstream fixes" --no-edit

	git checkout -b $UPSTREAM_STABLE_BRANCH hg/branches/stable
	git push origin $UPSTREAM_STABLE_BRANCH:$NEO_STABLE_CLEAN_BRANCH
	git checkout -b $NEO_STABLE_BRANCH origin/mutt/stable
	git merge $UPSTREAM_STABLE_BRANCH -m "merge upstream fixes" --no-edit

	git push origin $NEO_DEFAULT_BRANCH
	git push origin $NEO_STABLE_BRANCH
popd

pushd "$NEO_DIR"
	git branch --verbose --verbose | grep ahead

	for b in $NEO_DEFAULT_BRANCH $NEO_STABLE_BRANCH; do
		git log -n 1 --format="%C(204)%h%Creset %s %C(47)(%ad)%Creset" $b
		for r in $NEO_REMOTES; do
			git push $r $b
		done
	done
popd

exit 0


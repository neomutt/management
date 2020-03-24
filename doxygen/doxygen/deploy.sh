#!/bin/bash

# exit early if any command fails
set -e

function git_version()
{
	git describe --abbrev=6 --match "20*" $(git merge-base master HEAD)
}

function prep()
{
	pushd ~
	git config --global user.email "rich@flatcap.org"
	git config --global user.name "Richard Russon (DEPLOY)"

	mkdir -p ~/.ssh
	echo "Host github.com" >> ~/.ssh/config
	echo "        StrictHostKeyChecking no" >> ~/.ssh/config
	chmod 600 ~/.ssh/config
	popd
}

prep

openssl aes-256-cbc -K $encrypted_f2191814662f_key -iv $encrypted_f2191814662f_iv -in doxygen/travis-deploy-doxygen.enc -out travis-deploy-doxygen -d
chmod 0400 travis-deploy-doxygen

eval "$(ssh-agent -s)"

ssh-add travis-deploy-doxygen

git clone git@github.com:neomutt/code.git

VERSION=$(git_version)
pushd code

# Remove the old docs
git rm -r --quiet ./*

# Add the newly generated docs
rsync -a ../html/ .

git add .
git commit -m "[AUTO] NeoMutt $VERSION"
git push origin master

popd


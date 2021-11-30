# NeoMutt Management

This repo is a collection of scripts and notes that help to automate the
day-to-day running of the [NeoMutt Project](https://neomutt.org).

## Developer Build Scripts

Two scripts to [automate the building of NeoMutt](build/README.md).

| Script                                   | Description                                        |
| :--------------------------------------- | :------------------------------------------------- |
| [build.sh](build/build.sh)               | Build NeoMutt with your favourite options          |
| [test-configs.sh](build/test-configs.sh) | Build NeoMutt with a wide set of configure options |

## Feature Templates

It's important for new features to be
[well-documented](https://github.com/neomutt/management/tree/master/feature-templates).
To help new users, each NeoMutt feature comes with a **Chapter in the Manual**,
a **sample muttrc** and for Vim users a **vim syntax file** for config-file
highlighting.

## Release Templates

When [making a release](https://neomutt.org/run/release), these templates
save time preparing the accompanying notes.

| File                                         | Description                      |
|----------------------------------------------|----------------------------------|
| [changelog](release-templates/changelog.md)  | ChangeLog                        |
| [dev-ml](release-templates/dev-ml.txt)       | NeoMutt Devel Mailing List       |
| [emojis](release-templates/emojis.md)        | Emojis for website/GitHub        |
| [github](release-templates/github.md)        | GitHub Release Announcement      |
| [rpm](release-templates/rpm.txt)             | RPM Spec changelog               |
| [user-ml](release-templates/user-ml.txt)     | NeoMutt Users Mailing List       |
| [website](release-templates/website.md)      | Website News Article             |

### Release Automation

Make manual work semi-automatic.

| File                                 | Description                                                                      |
|--------------------------------------|----------------------------------------------------------------------------------|
| [get_summary.sh](git/get_summary.sh) | Print summary for new release message to maillists, updates list of contributors |
| [generate.sh](git/generate.sh)       | Regenerates mailmaps and credits                                                 |

* `get_summary.sh </path/to/neomutt/repo> [<since ref>] [<to ref>]`
  * Execute after merging branchces into master before neomutt release,
  * Prints summary of contributions to repository since last release
  (or `<since ref>` if specified) to HEAD (or `<to ref>` if specified).
  * Adds new contributors to neomutt.txt, so they will be present in
  mailmap files (mailmap files are created by `generate.sh`)
  * It's a good idea to revisit neomutt.txt diff after running the script.
  
* `generate.sh`
  * regenerates *mailmap*, *mailmap-name-nick*, *mailmap-nick* and *credits*

## Update Distro Bin

After a release, NeoMutt provides automatic updates for several distros.
There's an update script and a git repo for each.

| Distro           | Script                                       | GitHub Repo                                                                                |
| :--------------- | :------------------------------------------- | :----------------------------------------------------------------------------------------- |
| Arch (AUR)       | [aur.sh](update-distro-bin/aur.sh)           | [https://github.com/neomutt/aur-build](https://github.com/neomutt/aur-build)               |
| Fedora (COPR)    | [copr.sh](update-distro-bin/copr.sh)         | [https://github.com/neomutt/copr-neomutt](https://github.com/neomutt/copr-neomutt)         |
| Gentoo           | [gentoo.sh](update-distro-bin/gentoo.sh)     | [https://github.com/neomutt/gentoo-neomutt](https://github.com/neomutt/gentoo-neomutt)     |
| Homebrew (MacOS) | [homebrew.sh](update-distro-bin/homebrew.sh) | [https://github.com/neomutt/homebrew-neomutt](https://github.com/neomutt/homebrew-neomutt) |

## Misc Bin

Various useful scripts.
**Warning**: Don't use unless you know what you're doing.

| Script                                          | Description                                    |
| :---------------------------------------------- | :--------------------------------------------- |
| [update-from-hg.sh](misc-bin/update-from-hg.sh) | Pull upstream commits into our NeoMutt repo    |
| [webhook-bridge.py](misc-bin/webhook-bridge.py) | Notify poeditor.com of changes to translations |

## List of Standard Functions

A list of the [minimum requirements to build NeoMutt](standard-functions/README.md).

| File                                     | Headers                                    | Standard                                                          | Permitted   |
| :--------------------------------------- | :----------------------------------------- | :---------------------------------------------------------------- | :---------- |
| [c99.txt](standard-functions/c99.txt)    | [c99h.txt](standard-functions/c99h.txt)    | [C99](http://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf)  | Yes         |
| [2001.txt](standard-functions/2001.txt)  | [2001h.txt](standard-functions/2001h.txt)  | [POSIX:2001](http://pubs.opengroup.org/onlinepubs/009695399/)     | Yes         |
| [2008.txt](standard-functions/2008.txt)  | [2008h.txt](standard-functions/2008h.txt)  | [POSIX:2008](http://pubs.opengroup.org/onlinepubs/9699919799/)    | No          |

## Travis YAML Files

These are copies of our Travis control files.

| File                                    | Branch                                                                                                             |
| :-------------------------------------- | :----------------------------------------------------------------------------------------------------------------- |
| [aur.yml](travis/aur.yml)               | [https://github.com/neomutt/aur-buildll](https://github.com/neomutt/aur-build)                                     |
| [macports.yml](travis/macports.yml)     | [https://github.com/neomutt/neomutt/tree/distro/macports](https://github.com/neomutt/neomutt/tree/distro/macports) |
| [master.yml](travis/master.yml)         | [https://github.com/neomutt/neomutt/tree/master](https://github.com/neomutt/neomutt/tree/master)                   |

## Min-Build

This script minimises a NeoMutt git repo.
For those times that you just want to look at the **code**.

| File                                             | Description                     |
| :----------------------------------------------- | :------------------------------ |
| [make-min-build.sh](min-build/make-min-build.sh) | Script to remove non-code files |
| [min-config.h](min-build/min-config.h)           | Minimal config.h                |
| [min-gitignore](min-build/min-gitignore)         | Minimal .gitignore              |
| [min-Makefile](min-build/min-Makefile)           | Minimal Makefile                |

## Universal Ctags

These files configure [Universal Ctags](https://ctags.io/) to parse some of
NeoMutt's pre-processor macros.

The `ctags` directory can be symlinked from your home dir as `.ctags.d`

| File                             | Description                                 |
| :------------------------------- | :------------------------------------------ |
| [queue.ctags](ctags/queue.ctags) | Expand macros to reveal the struct within   |

## Doc Bin

A couple of tools for processing DocBook into HTML.

| File                                                  | Description              |
| :---------------------------------------------------- | :----------------------- |
| [fix-feature-since.sh](docs-bin/fix-feature-since.sh) | Restore the 'since' date |
| [transform-links.vim](docs-bin/transform-links.vim)   | Fix the html links       |
| [fix-links.sed](docs-bin/fix-links.sed)               | Fix some internal links  |


# Developer Build Scripts

These build scripts are aimed at developers.

The script style makes it very easy to enable/disable or add/remove compilation options.

The have a dependency on 'chronic' from the 'moreutils' package.
If removed, it will cause the builds to be slightly more verbose.

## [build.sh](build.sh)

Build NeoMutt with your favourite options.

The defaults are:
- Enable most configure options
- Set up for gcc
- Include a lot of warning options
- Enable optimum debugging

## [build-parallel.sh](build-parallel.sh)

Build NeoMutt more quickly with your favourite options.
This is a stripped down `build.sh` designed to be used with Gnu Parallel.

It performs several builds at once.
Each build is performed in a separate directory (out-of-tree) called `buildNUM`.

**Note**: If you use environment variable `$MAKEFLAGS`, remove any parallel
      build options, e.g. `-j4`, before using this script (or your load average
      will get rather large).

First create a list of configure options, `clist.txt`, that you'd like to test, e.g.

**Note**: The blank line at the begining is a build with zero configure options

```

--disable-nls
--disable-idn
--disable-pgp
--disable-smime
--disable-nls --disable-idn --disable-pgp --disable-smime
--lua
--with-lock=flock
--locales-fix
--homespool
--with-domain=example.com
--notmuch
--gpgme
--with-lock=flock --lua --locales-fix --homespool --with-domain=example.com --notmuch --gpgme
--tokyocabinet --qdbm --gdbm --bdb --lmdb --kyotocabinet
--gss
--ssl
--gnutls
--sasl
```

Then run parallel:

```
parallel build-parallel.sh gcc {} :::: clist.txt
```

## [test-configs.sh](test-configs.sh)

Perform a wide spread of compilations.

**WARNING**:
- This script runs `git clean -xdfq` to clear the directory before each build.
  All non-git files will be removed.

This script has a **set** of configure options.
By default it performs 21 builds: 1 compiler \* 21 configure settings.


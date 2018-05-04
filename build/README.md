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

## [test-configs.sh](test-configs.sh)

Perform a wide spread of compilations.

**WARNING**:
- This script runs `git clean -xdfq` to clear the directory before each build.
  All non-git files will be removed.

This script has a **set** of configure options.
By default it performs 21 builds: 1 compiler \* 21 configure settings.


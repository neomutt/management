# Release Test Branch

## Description

Making a release is time-consuming.  It involves a **lot** of testing to make
sure that simple things haven't been forgotten.  Checklists are good, but
automation is better.

This branch is used by [Travis CI](https://travis-ci.org/neomutt/neomutt) to
perform lots of tests on the source.  Specifically, all the tests that should be
run before making a release.

The scripts in this branch live in the [management repo](https://github.com/neomutt/management).

## Tests

**Builds**

- Four builds, covering a selection of `configure` options
- Install: Check that nothing is missed
- Uninstall: Check that nothing is left behind

**Translations**

- Check `POTFILES.in` (files listed here are scanned for translations)
- Check that all translation files `*.po` are valid
- Run a re-sync of the translation files (`make update-po`)

**Code and Docs**

- Check that the Guide's DocBook is valid
- Check that NeoMutt has the correct config defaults and reads files correctly
- Run some unit tests on the libary code
- Run some tests on the Lua scripting (temporarily disabled)
- Check the code for whitespace errors

**Out-of-tree Build**

- Run an out-of-tree build
- Install: Check that nothing is missed
- Uninstall: Check that nothing is left behind


/**
 * @mainpage NeoMutt Code Docs
 *
 * ## State of Play
 *
 * This is a Work in Progress.  All the existing comments have been converted
 * to doxygen format and now appear in these pages.
 *
 * Furthermore, all the files, structs, enums and unions have had descriptions
 * written.  Some descriptions are a bit vague, due to ignorance, or poor
 * design decisions.
 *
 * ## Libraries
 *
 * Each library helps to untangle the code by grouping similar functions and
 * reducing dependencies.
 *
 * The goal is that each library is:
 * - Self-contained (it may rely on other libraries)
 * - Independently testable (i.e. without using NeoMutt)
 * - Fully documented
 * - Robust
 *
 * Libraries:
 * - libmutt - @ref mutt
 * - libhcache - @ref hc_hcache
 * - libimap - @ref imap_imap
 * - libconn - @ref conn
 * - libncrypt - @ref ncrypt
 *
 * ## Building these Docs
 *
 * The config for building the docs is in the main source repo.
 *
 * Everything possible is turned on in the config file, so you'll need to
 * install a few dependencies like `dot` from the graphviz package.
 *
 * Simply: `doxygen doxygen/doxygen.conf` in the main directory.
 *
 * ## Installing the Docs
 *
 * These docs aren't in the main website repo -- they weigh in at 100M
 * Instead, they're stored in the [doxygen repo](https://github.com/neomutt/doxygen)
 * They are included in the website as a "git submodule"
 */

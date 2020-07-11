/**
 * @mainpage Code Docs
 *
 * <img style="float: left; padding-right: 0.5em;" src="structs.svg">
 * <img style="float: left; padding-right: 0.5em;" src="pages.svg">
 * <img style="float: left; padding-right: 0.5em;" src="globals.svg">
 * <img style="float: left; padding-right: 0.5em;" src="functions.svg">
 * <img style="float: left; padding-right: 0.5em;" src="enums.svg">
 * <img style="float: left; padding-right: 0.5em;" src="config.svg">
 * <img style="float: left; padding-right: 0.5em;" src="members.svg">
 * <img style="float: left; padding-right: 0.5em;" src="defines.svg">
 * <br>
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
 * | Library        |
 * | :------------- |
 * | @ref address   |
 * | @ref alias     |
 * | @ref autocrypt |
 * | @ref bcache    |
 * | @ref compmbox  |
 * | @ref compress  |
 * | @ref config    |
 * | @ref conn      |
 * | @ref core      |
 * | @ref debug     |
 * | @ref email     |
 * | @ref gui       |
 * | @ref hcache    |
 * | @ref history   |
 * | @ref imap      |
 * | @ref maildir   |
 * | @ref mbox      |
 * | @ref mutt      |
 * | @ref ncrypt    |
 * | @ref nntp      |
 * | @ref notmuch   |
 * | @ref pop       |
 * | @ref send      |
 * | @ref sidebar   |
 * | @ref store     |
 *
 * ## Config Variables
 *
 * NeoMutt has a lot of configuration options.
 * @ref config_vars 
 *
 * ## Miscellaneous files
 *
 * These file form the main body of NeoMutt.
 *
 * | File            | Description            |
 * | :-------------- | :--------------------- |
 * | browser.c       | @subpage browser       |
 * | commands.c      | @subpage commands      |
 * | command_parse.c | @subpage command_parse |
 * | complete.c      | @subpage complete      |
 * | compose.c       | @subpage compose       |
 * | context.c       | @subpage ctx           |
 * | copy.c          | @subpage copy          |
 * | editmsg.c       | @subpage editmsg       |
 * | enriched.c      | @subpage enriched      |
 * | enter.c         | @subpage enter         |
 * | flags.c         | @subpage flags         |
 * | functions.c     | @subpage functions     |
 * | handler.c       | @subpage handler       |
 * | hdrline.c       | @subpage hdrline       |
 * | help.c          | @subpage help          |
 * | hook.c          | @subpage hook          |
 * | icommands.c     | @subpage icommands     |
 * | index.c         | @subpage index2        |
 * | init.c          | @subpage init          |
 * | keymap.c        | @subpage keymap        |
 * | mailcap.c       | @subpage mailcap       |
 * | maillist.c      | @subpage maillist      |
 * | main.c          | @subpage main          |
 * | menu.c          | @subpage menu          |
 * | monitor.c       | @subpage monitor       |
 * | muttlib.c       | @subpage muttlib       |
 * | mutt_account.c  | @subpage mutt_account  |
 * | mutt_attach.c   | @subpage mutt_attach   |
 * | mutt_body.c     | @subpage mutt_body     |
 * | mutt_commands.c | @subpage mutt_commands |
 * | mutt_config.c   | @subpage mutt_config   |
 * | mutt_header.c   | @subpage mutt_header   |
 * | mutt_history.c  | @subpage mutt_history  |
 * | mutt_logging.c  | @subpage mutt_logging  |
 * | mutt_lua.c      | @subpage mutt_lua      |
 * | mutt_mailbox.c  | @subpage mailbox       |
 * | mutt_parse.c    | @subpage mutt_parse    |
 * | mutt_signal.c   | @subpage mutt_signal   |
 * | mutt_socket.c   | @subpage mutt_socket   |
 * | mutt_thread.c   | @subpage mutt_thread   |
 * | mx.c            | @subpage mx            |
 * | myvar.c         | @subpage myvar         |
 * | pager.c         | @subpage pager         |
 * | pattern.c       | @subpage pattern       |
 * | postpone.c      | @subpage postpone      |
 * | progress.c      | @subpage progress      |
 * | recvattach.c    | @subpage recvattach    |
 * | recvcmd.c       | @subpage recvcmd       |
 * | remailer.c      | @subpage remailer      |
 * | resize.c        | @subpage resize        |
 * | rfc3676.c       | @subpage rfc3676       |
 * | score.c         | @subpage score         |
 * | sort.c          | @subpage sort          |
 * | state.c         | @subpage state         |
 * | status.c        | @subpage status        |
 * | system.c        | @subpage system        |
 * | version.c       | @subpage version       |
 * | wcscasecmp.c    | @subpage wcscasecmp    |
 *
 * ## Building these Docs
 *
 * The config for building the docs is in the main source repo.
 *
 * Everything possible is turned on in the config file, so you'll need to
 * install a few dependencies like `dot` from the graphviz package.
 *
 * Simply run: `doxygen doxygen/doxygen.conf` in the main directory.
 *
 * ## Installing the Docs
 *
 * These docs aren't in the main website repo -- they weigh in at 100Mb.
 * Instead, they're stored in the [code repo](https://github.com/neomutt/code)
 */

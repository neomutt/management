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
 * | Library             |
 * | :------------------ |
 * | @ref lib_address   |
 * | @ref lib_alias     |
 * | @ref lib_autocrypt |
 * | @ref lib_bcache    |
 * | @ref lib_compmbox  |
 * | @ref lib_compose   |
 * | @ref lib_compress  |
 * | @ref lib_config    |
 * | @ref lib_conn      |
 * | @ref lib_core      |
 * | @ref lib_debug     |
 * | @ref lib_email     |
 * | @ref lib_gui       |
 * | @ref lib_hcache    |
 * | @ref lib_helpbar   |
 * | @ref lib_history   |
 * | @ref lib_imap      |
 * | @ref lib_maildir   |
 * | @ref lib_mbox      |
 * | @ref lib_mutt      |
 * | @ref lib_ncrypt    |
 * | @ref lib_nntp      |
 * | @ref lib_notmuch   |
 * | @ref lib_pattern   |
 * | @ref lib_pop       |
 * | @ref lib_send      |
 * | @ref lib_sidebar   |
 * | @ref lib_store     |
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
 * | File            | Description                |
 * | :-------------- | :------------------------- |
 * | browser.c       | @subpage neo_browser       |
 * | commands.c      | @subpage neo_commands      |
 * | command_parse.c | @subpage neo_command_parse |
 * | complete.c      | @subpage neo_complete      |
 * | context.c       | @subpage neo_ctx           |
 * | copy.c          | @subpage neo_copy          |
 * | editmsg.c       | @subpage neo_editmsg       |
 * | enriched.c      | @subpage neo_enriched      |
 * | enter.c         | @subpage neo_enter         |
 * | flags.c         | @subpage neo_flags         |
 * | functions.c     | @subpage neo_functions     |
 * | handler.c       | @subpage neo_handler       |
 * | hdrline.c       | @subpage neo_hdrline       |
 * | help.c          | @subpage neo_help          |
 * | hook.c          | @subpage neo_hook          |
 * | icommands.c     | @subpage neo_icommands     |
 * | index.c         | @subpage neo_index         |
 * | init.c          | @subpage neo_init          |
 * | keymap.c        | @subpage neo_keymap        |
 * | mailcap.c       | @subpage neo_mailcap       |
 * | maillist.c      | @subpage neo_maillist      |
 * | main.c          | @subpage neo_main          |
 * | menu.c          | @subpage neo_menu          |
 * | monitor.c       | @subpage neo_monitor       |
 * | muttlib.c       | @subpage neo_muttlib       |
 * | mutt_account.c  | @subpage neo_mutt_account  |
 * | mutt_attach.c   | @subpage neo_mutt_attach   |
 * | mutt_body.c     | @subpage neo_mutt_body     |
 * | mutt_commands.c | @subpage neo_mutt_commands |
 * | mutt_config.c   | @subpage neo_mutt_config   |
 * | mutt_header.c   | @subpage neo_mutt_header   |
 * | mutt_history.c  | @subpage neo_mutt_history  |
 * | mutt_logging.c  | @subpage neo_mutt_logging  |
 * | mutt_lua.c      | @subpage neo_mutt_lua      |
 * | mutt_mailbox.c  | @subpage neo_mutt_mailbox  |
 * | mutt_parse.c    | @subpage neo_mutt_parse    |
 * | mutt_signal.c   | @subpage neo_mutt_signal   |
 * | mutt_socket.c   | @subpage neo_mutt_socket   |
 * | mutt_thread.c   | @subpage neo_mutt_thread   |
 * | mx.c            | @subpage neo_mx            |
 * | myvar.c         | @subpage neo_myvar         |
 * | pager.c         | @subpage neo_pager         |
 * | postpone.c      | @subpage neo_postpone      |
 * | progress.c      | @subpage neo_progress      |
 * | recvattach.c    | @subpage neo_recvattach    |
 * | recvcmd.c       | @subpage neo_recvcmd       |
 * | remailer.c      | @subpage neo_remailer      |
 * | resize.c        | @subpage neo_resize        |
 * | rfc3676.c       | @subpage neo_rfc3676       |
 * | score.c         | @subpage neo_score         |
 * | sort.c          | @subpage neo_sort          |
 * | state.c         | @subpage neo_state         |
 * | status.c        | @subpage neo_status        |
 * | system.c        | @subpage neo_system        |
 * | version.c       | @subpage neo_version       |
 * | wcscasecmp.c    | @subpage neo_wcscasecmp    |
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

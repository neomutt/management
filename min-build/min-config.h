#define CRYPT_BACKEND_CLASSIC_PGP 1
#define CRYPT_BACKEND_CLASSIC_SMIME 1
#define CRYPT_BACKEND_GPGME 1
#define DEBUG 1
#define ENABLE_NLS 1
#define HAVE_BDB 1
#define HAVE_BKGDSET 1
#define HAVE_COLOR 1
#define HAVE_CURS_SET 1
#define HAVE_DCGETTEXT 1
#define HAVE_DECL_GNUTLS_VERIFY_DISABLE_TIME_CHECKS 1
#define HAVE_DECL_SYS_SIGLIST 1
#define HAVE_FGETC_UNLOCKED 1
#define HAVE_FGETS_UNLOCKED 1
#define HAVE_FMEMOPEN 1
#define HAVE_FUTIMENS 1
#define HAVE_GDBM 1
#define HAVE_GDBM_H 1
#define HAVE_GETADDRINFO 1
#define HAVE_GETADDRINFO_A 1
#define HAVE_GETTEXT 1
#define HAVE_GNUTLS_CERTIFICATE_CREDENTIALS_T 1
#define HAVE_GNUTLS_CERTIFICATE_STATUS_T 1
#define HAVE_GNUTLS_DATUM_T 1
#define HAVE_GNUTLS_DIGEST_ALGORITHM_T 1
#define HAVE_GNUTLS_PRIORITY_SET_DIRECT 1
#define HAVE_GNUTLS_SESSION_T 1
#define HAVE_GNUTLS_TRANSPORT_PTR_T 1
#define HAVE_GNUTLS_X509_CRT_T 1
#define HAVE_ICONV 1
#define HAVE_IDNA_H 1
#define HAVE_IDNA_TO_ASCII_8Z 1
#define HAVE_IDNA_TO_ASCII_LZ 1
#define HAVE_IDNA_TO_UNICODE_8Z8Z 1
#define HAVE_INTTYPES_H 1
#define HAVE_KC 1
#define HAVE_LAUXLIB_H 1
#define HAVE_LIBIDN 1
#define HAVE_LMDB 1
#define HAVE_LMDB_H 1
#define HAVE_LUACONF_H 1
#define HAVE_LUALIB_H 1
#define HAVE_LUA_H 1
#define HAVE_MEMORY_H 1
#define HAVE_META 1
#define HAVE_MKDTEMP 1
#define HAVE_NCURSESW_NCURSES_H 1
#define HAVE_OPEN_MEMSTREAM 1
#define HAVE_QDBM 1
#define HAVE_RESIZETERM 1
#define HAVE_START_COLOR 1
#define HAVE_STDINT_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRINGPREP_H 1
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
#define HAVE_STRSEP 1
#define HAVE_SYSEXITS_H 1
#define HAVE_SYS_IOCTL_H 1
#define HAVE_SYS_STAT_H 1
#define HAVE_SYS_SYSCALL_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_TC 1
#define HAVE_TYPEAHEAD 1
#define HAVE_UNISTD_H 1
#define HAVE_USE_DEFAULT_COLORS 1
#define HAVE_USE_EXTENDED_NAMES 1
#define HAVE_VILLA_H 1
#define HAVE_WCSCASECMP 1
#define HAVE_WC_FUNCS 1
#define ICONV_CONST 
#define ISPELL "/usr/bin/ispell"
#define MAILPATH "/var/mail"
#define MAKEDOC_FULL 1
#define MIXMASTER "mixmaster"
#define MUTT_VERSION "1.8.3"
#define NOTMUCH_API_3 1
#define PACKAGE "mutt"
#define PACKAGE_BUGREPORT "neomutt-devel@neomutt.org"
#define PACKAGE_NAME "NeoMutt"
#define PACKAGE_STRING "NeoMutt 20170609"
#define PACKAGE_TARNAME "mutt"
#define PACKAGE_URL "https://www.neomutt.org"
#define PACKAGE_VERSION "20170609"
#define SENDMAIL "/usr/sbin/sendmail"
#define SIG_ATOMIC_VOLATILE_T volatile sig_atomic_t
#define SIZEOF_OFF_T 8
#define STDC_HEADERS 1
#define SUN_ATTACHMENT 1
#define USE_COMPRESSED 1
#define USE_FCNTL 1
#define USE_GSS 1
#define USE_HCACHE 1
#define USE_IMAP 1
#define USE_LUA 1
#define USE_NNTP 1
#define USE_NOTMUCH 1
#define USE_POP 1
#define USE_SASL 1
#define USE_SIDEBAR 1
#define USE_SMTP 1
#define USE_SOCKET 1
#define USE_SSL 1
#define USE_SSL_GNUTLS 1

#ifndef _ALL_SOURCE
# define _ALL_SOURCE 1
#endif
#ifndef _GNU_SOURCE
# define _GNU_SOURCE 1
#endif
#ifndef _POSIX_PTHREAD_SEMANTICS
# define _POSIX_PTHREAD_SEMANTICS 1
#endif
#ifndef _TANDEM_SOURCE
# define _TANDEM_SOURCE 1
#endif
#ifndef __EXTENSIONS__
# define __EXTENSIONS__ 1
#endif
#define VERSION "20170609"
#define LOFF_T off_t
#if SIZEOF_OFF_T == 8
# define OFF_T_FMT "%" PRId64
#else
# define OFF_T_FMT "%" PRId32
#endif

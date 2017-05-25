# named structs and their typedefs
s/\<\(struct account\|ACCOUNT\)\>/struct Account/g
s/\<\(struct address_t\|ADDRESS\)\>/struct Address/g
s/\<\(struct alias\|ALIAS\)\>/struct Alias/g
s/\<\(struct attachptr\|ATTACHPTR\)\>/struct AttachPtr/g
s/\<\(struct body\|BODY\)\>/struct Body/g
s/\<\(struct body_cache\|body_cache_t\)\>/struct BodyCache/g
s/\<\(struct buffer\|BUFFER\)\>/struct Buffer/g
s/\<\(struct buffy_t\|BUFFY\)\>/struct Buffy/g
s/\<\(struct ciss_url\|ciss_url_t\)\>/struct CissUrl/g
s/\<\(struct _connection\|CONNECTION\)\>/struct Connection/g
s/\<\(struct content\|CONTENT\)\>/struct Content/g
s/\<\(struct _context\|CONTEXT\)\>/struct Context/g
s/\<\(struct enter_state\|ENTER_STATE\)\>/struct EnterState/g
s/\<\(struct envelope\|ENVELOPE\)\>/struct Envelope/g
s/\<\(struct group_t\|group_t\)\>/struct Group/g
s/\<\(struct hash\|HASH\)\>/struct Hash/g
s/\<\(struct header\|HEADER\)\>/struct Header/g
s/\<\(struct list_t\|LIST\)\>/struct List/g
s/\<\(struct _mbchar_table\|mbchar_table\)\>/struct MbCharTable/g
s/\<\(struct menu_t\|MUTTMENU\)\>/struct Menu/g
s/\<\(struct _message\|MESSAGE\)\>/struct Message/g
s/\<\(struct mutt_thread\|THREAD\)\>/struct MuttThread/g
s/\<\(struct mutt_window\|mutt_window_t\)\>/struct MuttWindow/g
s/\<\(struct parameter\|PARAMETER\)\>/struct Parameter/g
s/\<\(struct pattern_t\|pattern_t\)\>/struct Pattern/g
s/\<\(struct pgp_keyinfo\|pgp_key_t\)\>/struct PgpKeyInfo */g
s/\<\(struct progress\|progress_t\)\>/struct Progress/g
s/\<\(struct regexp\|REGEXP\)\>/struct Regex/g
s/\<\(struct replace_list_t\|REPLACE_LIST\)\>/struct ReplaceList/g
s/\<\(struct rx_list_t\|RX_LIST\)\>/struct RxList/g
s/\<\(struct state\|STATE\)\>/struct State/g
s/\<\(struct _ansi_attr\|ansi_attr\)\>/struct AnsiAttr/g
s/\<\(struct color_line\|COLOR_LINE\)\>/struct ColorLine/g
s/\<\(struct color_list\|COLOR_LIST\)\>/struct ColorList/g
s/\<\(struct crypt_entry\|crypt_entry_t\)\>/struct CryptEntry/g
s/\<\(struct crypt_keyinfo\|crypt_key_t\)\>/struct CryptKeyinfo/g
s/\<\(struct crypt_module\|crypt_module_t\)\>/struct CryptModule */g
s/\<\(struct entry\|ENTRY\)\>/struct Entry/g
s/\<\(struct flowed_state\|flowed_state_t\)\>/struct FlowedState/g
s/\<\(struct folder_t\|FOLDER\)\>/struct Folder/g
s/\<\(struct group_context_t\|group_context_t\)\>/struct GroupContext/g
s/\<\(struct hook\|HOOK\)\>/struct Hook/g
s/\<\(struct imap_header_data\|IMAP_HEADER_DATA\)\>/struct ImapHeaderData/g
s/\<\(struct mixchain\|MIXCHAIN\)\>/struct MixChain/g
s/\<\(struct myvar\|myvar_t\)\>/struct MyVar/g
s/\<\(struct pgp_entry\|pgp_entry_t\)\>/struct PgpEntry/g
s/\<\(struct pgp_signature\|pgp_sig_t\)\>/struct PgpSignature/g
s/\<\(struct pgp_uid\|pgp_uid_t\)\>/struct PgpUid/g
s/\<\(struct query\|QUERY\)\>/struct Query/g
s/\<\(struct type2\|REMAILER\)\>/struct Remailer/g
s/\<\(struct rfc1524_mailcap_entry\|rfc1524_entry\)\>/struct Rfc1524MailcapEntry/g
s/\<\(struct score_t\|SCORE\)\>/struct Score/g
s/\<\(struct sidebar_entry\|SBENTRY\)\>/struct SbEntry/g
s/\<\(struct smime_key\|smime_key_t\)\>/struct SmimeKey/g

# unnamed structs and their typedefs
s/\<struct _tlssockdata\>/struct TlsSockData/g
s/\<struct b64_context\>/struct B64Context/g
s/\<struct binding_t\>/struct Binding/g
s/\<struct browser_state\>/struct BrowserState/g
s/\<struct command_t\>/struct Command/g
s/\<struct compile_options\>/struct CompileOptions/g
s/\<struct coord\>/struct Coord/g
s/\<struct crypt_cache\>/struct CryptCache/g
s/\<struct crypt_module_functions\>/struct CryptModuleFunctions/g
s/\<struct crypt_module_specs\>/struct CryptModuleSpecs/g
s/\<struct dn_array_s\>/struct DnArrayS/g
s/\<struct enriched_state\>/struct EnrichedState/g
s/\<struct extkey\>/struct Extkey/g
s/\<struct fgetconv_not\>/struct FgetConvNot/g
s/\<struct fgetconv_s\>/struct FgetConvS/g
s/\<struct folder_file\>/struct FolderFile/g
s/\<struct hash_elem\>/struct HashElem/g
s/\<struct hash_walk_state\>/struct HashWalkState/g
s/\<struct hdr_format_info\>/struct HdrFormatInfo/g
s/\<struct header_cache\>/struct HeaderCache/g
s/\<struct history\>/struct History/g
s/\<struct keymap_t\>/struct Keymap/g
s/\<struct line_t\>/struct Line/g
s/\<struct m_update_t\>/struct MUpdate/g
s/\<struct maildir\>/struct Maildir/g
s/\<struct mapping_t\>/struct Mapping/g
s/\<struct md5_ctx\>/struct Md5Ctx/g
s/\<struct mh_data\>/struct MhData/g
s/\<struct mh_sequences\>/struct MhSequences/g
s/\<struct mx_ops\>/struct MxOps/g
s/\<struct nm_ctxdata\>/struct NmCtxdata/g
s/\<struct nm_hdrdata\>/struct NmHdrdata/g
s/\<struct nm_hdrtag\>/struct NmHdrtag/g
s/\<struct option_t\>/struct Option/g
s/\<struct pattern_flags\>/struct PatternFlags/g
s/\<struct pgp_cache\>/struct PgpCache/g
s/\<struct pgp_command_context\>/struct PgpCommandContext/g
s/\<struct q_class_t\>/struct QClass/g
s/\<struct range_regexp\>/struct RangeRegex/g
s/\<struct resize\>/struct Resize/g
s/\<struct rfc2231_parameter\>/struct Rfc2231Parameter/g
s/\<struct smime_command_context\>/struct SmimeCommandContext/g
s/\<struct syntax_t\>/struct Syntax/g
s/\<struct sysexits\>/struct Sysexits/g
s/\<struct tz_t\>/struct Tz/g
s/\<struct uri_tag\>/struct UriTag/g

# plain structs
s/\<ATTACH_MATCH\>/struct AttachMatch/g
s/\<CHILD_CTX\>/struct ChildCtx/g
s/\<compose_redraw_data_t\>/struct ComposeRedrawData/g
s/\<COMPRESS_INFO\>/struct CompressInfo/g
s/\<CONTENT_STATE\>/struct ContentState/g
s/\<event_t\>/struct Event/g
s/\<FETCH_CTX\>/struct FetchCtx/g
s/\<hcache_db_ctx_t\>/struct HcacheDbCtx/g
s/\<hcache_lmdb_ctx_t\>/struct HcacheLmdbCtx/g
s/\<imap_auth_t\>/struct ImapAuth/g
s/\<IMAP_CACHE\>/struct ImapCache/g
s/\<IMAP_COMMAND\>/struct ImapCommand/g
s/\<IMAP_DATA\>/struct ImapData/g
s/\<IMAP_HEADER\>/struct ImapHeader/g
s/\<IMAP_LIST\>/struct ImapList/g
s/\<IMAP_MBOX\>/struct ImapMbox/g
s/\<IMAP_STATUS\>/struct ImapStatus/g
s/\<NEWSRC_ENTRY\>/struct NewsrcEntry/g
s/\<NNTP_ACACHE\>/struct NntpAcache/g
s/\<NNTP_DATA\>/struct NntpData/g
s/\<NNTP_HEADER_DATA\>/struct NntpHeaderData/g
s/\<NNTP_SERVER\>/struct NntpServer/g
s/\<pager_t\>/struct Pager/g
s/\<pager_redraw_data_t\>/struct PagerRedrawData/g
s/\<pattern_cache_t\>/struct PatternCache/g
s/\<pop_auth_t\>/struct PopAuth/g
s/\<POP_CACHE\>/struct PopCache/g
s/\<POP_DATA\>/struct PopData/g
s/\<SASL_DATA\>/struct SaslData/g
s/\<SHA1_CTX\>/struct Sha1Ctx/g
s/\<sslsockdata\>/struct SslSockData/g
s/\<TUNNEL_DATA\>/struct TunnelData/g


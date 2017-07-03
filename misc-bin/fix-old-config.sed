# Sed script to replace obsolete Mutt variables with the correct names

s/\<edit_hdrs\>/edit_headers/g
s/\<envelope_from\>/use_envelope_from/g
s/\<forw_decode\>/forward_decode/g
s/\<forw_decrypt\>/forward_decrypt/g
s/\<forw_format\>/forward_format/g
s/\<forw_quote\>/forward_quote/g
s/\<hdr_format\>/index_format/g
s/\<indent_str\>/indent_string/g
s/\<mime_fwd\>/mime_forward/g
s/\<msg_format\>/message_format/g
s/\<pgp_autoencrypt\>/crypt_autoencrypt/g
s/\<pgp_autosign\>/crypt_autosign/g
s/\<pgp_auto_traditional\>/pgp_replyinline/g
s/\<pgp_create_traditional\>/pgp_autoinline/g
s/\<pgp_replyencrypt\>/crypt_replyencrypt/g
s/\<pgp_replysign\>/crypt_replysign/g
s/\<pgp_replysignencrypted\>/crypt_replysignencrypted/g
s/\<pgp_verify_sig\>/crypt_verify_sig/g
s/\<post_indent_str\>/post_indent_string/g
s/\<print_cmd\>/print_command/g
s/\<smime_sign_as\>/smime_default_key/g
s/\<xterm_icon\>/ts_icon_format/g
s/\<xterm_set_titles\>/ts_enabled/g
s/\<xterm_title\>/ts_status_format/g


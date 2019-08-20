#include <stdlib.h>
#include <stdint.h>

#include "options.h"
#include <signal.h>
#include <stdbool.h>
#include <sys/stat.h>

#include "email/envelope.h"
#include "email/body.h"
#include "email/parse.h"
#include "email/mime.h"
#include "email/email.h"

int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
	OptNoCurses = 1;
	char file[] = "/tmp/mutt-fuzz";
	FILE *fp = fopen(file, "wb");
	if (fp != NULL) {
		fwrite(data, 1, size, fp);
		fclose(fp);
	}
	fp = fopen(file, "rb");
	struct Email *e = email_new();
	struct Envelope *env = mutt_rfc822_read_header(fp, e, 0, 0);
	mutt_parse_part(fp, e->content);
	email_free(&e);
	mutt_env_free(&env);
	fclose(fp);
	return 0;
}

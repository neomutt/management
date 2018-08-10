# Sample Email Generator

This script generates a maildir mailbox containing a selection of emails with
different dates, subjects, senders and content.

**Files**:
- [`animals.txt`](animals.txt) - Email subjects
- [`fruit.txt`](fruit.txt) - Email senders
- [`generate-dated-emails.sh`](generate-dated-emails.sh) - Generator script
- [`folders.txt`](folders.txt) - Sample folder layout

## Running the Generator

```sh
MDIR=~/management/misc-bin/sample-emails
for i in $(cat $MDIR/folders.txt); do mkdir -p $i; pushd $i; $MDIR/generate-dated-emails.sh ; popd; done
```

## Dependencies

The script has two dependencies: **`shuf`** to randomised the order of the
lists and **`lorem-ipsum-generator`** to generate the random content of the
emails.

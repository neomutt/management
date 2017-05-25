# Merge Upstream Changes into NeoMutt

## Description

NeoMutt tracks the changes added to upstream Mutt.
Since they split, NeoMutt has had a **LOT** of tidying done to it.

To make merging simpler, these scripts create a tree of branches which it
manipulates.  Patches can be generated from these branches.

A rough description is given on the devel mailing list:
[here](http://mailman.neomutt.org/pipermail/neomutt-devel-neomutt.org/2017-April/000362.html)
and
[here](http://mailman.neomutt.org/pipermail/neomutt-devel-neomutt.org/2017-April/000375.html)

## Scripts

| File                                                   | Script Type | Description                                             |
| :----------------------------------------------------- | :---------- | :------------------------------------------------------ |
| [common](common.sh)                                    | Shell       | Shared functions                                        |
| [merge-upstream](merge-upstream.sh)                    | Shell       | Branch/patch generator                                  |
| [remove-checked-comments](remove-checked-comments.sed) | Sed         | Remove unused code markers                              |
| [rename-functions](rename-functions.sed)               | Sed         | Rename some functions                                   |
| [rename-structs](rename-structs.sed)                   | Sed         | Rename **many** structs                                 |
| [dprint](dprint.cocci)                                 | Coccinelle  | Replace Mutt's `dprint()` with NeoMutt's `mutt_debug()` |
| [set-pointer-null](set-pointer-null.cocci)             | Coccinelle  | Initialise all pointers to NULL                         |
| [strcmp](strcmp.cocci)                                 | Coccinelle  | Test strcmp-like functions against 0                    |
| [tidy-return](tidy-return.cocci)                       | Coccinelle  | Simplify return statements                              |


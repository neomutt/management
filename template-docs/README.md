# Template Documentation

It's important for new features to be well-documented.  To help new users, each
NeoMutt feature comes with a [Chapter in the Manual](#manual.xml.head), a
[sample muttrc](#muttrc) and for Vim users a [vim syntax file](#vimrc) for
config-file highlighting.

## manual.xml.head

Each NeoMutt Feature has a chapter in the manual.
The chapters may include these sections:

- **Patch**
    How to check if the Feature is compiled in and enabled
- **Intro**
    A simple explanation of the Feature
- **Variables**
    New variables that the Feature has added
- **Functions**
    New functions that the Feature has added
- **Commands**
    New commands that the Feature has added
- **Colors**
    New objects that can be colored, that the Feature has added
- **Sort**
    New sort methods that the Feature has added
- **Muttrc**
    A sample `muttrc` file describing the use of **all** the new config of the Feature
- **See Also**
    Other sources of relevant documentation
- **Known Bugs**
    Known limitations of this Feature
- **Credits**
    An inclusive list of everyone who has contributed to this Feature

## muttrc

This file should give examples of all the new configuration that the Feature has
added.

- **Variables** - shown with their default values
- **Commands** - shown with an example arguments
- **Functions** - shown with an example mapping
- **Colors** - some unpleasant examples are given
- **Sort** - sorting options

## vimrc

This file is only useful to Vim users.

This syntax file teaches Vim about the new variables, functions or commands that
the NeoMutt Feature has added.  Without it Vim will highlight the new symbols
as errors.

- muttrcVarBool
- muttrcVarNum
- muttrcVarStr
- muttrcCommand
- muttrcFunction
- muttrcColorField


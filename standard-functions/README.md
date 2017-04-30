WORK IN PROGRESS

# Requirements for Building NeoMutt

The minimum requirements to build NeoMutt are:

- A C99-compliant compiler
- POSIX:2001 headers/libraries

# Definitions

## C99 - ISO/IEC 9899:1999

[http://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf](http://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf)

This International Standard specifies the form and establishes the
interpretation of programs written in the C programming language.

It defines all the headers, functions, macros, etc that a compiler needs to
understand to be C99-compliant.

See also: [https://en.wikipedia.org/wiki/C99](https://en.wikipedia.org/wiki/C99)

## POSIX:2001 - IEEE Std 1003.1-2001

[http://pubs.opengroup.org/onlinepubs/009695399/](http://pubs.opengroup.org/onlinepubs/009695399/)

Also known as the "Single UNIX Specification version 3, POSIX:2001", or "SUSv3".

This defines a set of C headers/libraries for working with UNIX-like systems.

See also: [https://en.wikipedia.org/wiki/Single_UNIX_Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)

## POSIX:2008 - IEEE Std 1003.1-2008

[http://pubs.opengroup.org/onlinepubs/9699919799/](http://pubs.opengroup.org/onlinepubs/9699919799/)

Also known as the "Single UNIX Specification version 4, POSIX:2008", or "SUSv4".

This defines a newer set of C headers/libraries for working with UNIX-like systems.

**Note**: These functions may not be used in NeoMutt.

See also: [https://en.wikipedia.org/wiki/Single_UNIX_Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification)

# Function Lists

List of functions/headers in each specification:

- [c99.txt](c99.txt)   - [headers](c99h.txt)  - All the functions defined by C99
- [2001.txt](2001.txt) - [headers](2001h.txt) - Functions in POSIX:2001, but not C99
- [2008.txt](2008.txt) - [headers](2008h.txt) - Functions in POSIX:2008, but not POSIX:2001


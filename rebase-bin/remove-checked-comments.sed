# Remove unused code markers
s/[ \t]*\<__\(FOPEN_CHECKED\|FREE_CHECKED\|MEM_CHECKED\|SAFE_FREE_CHECKED\|SPRINTF_CHECKED\|STRCAT_CHECKED\|STRCPY_CHECKED\|STRNCAT_CHECKED\)__\>[ \t]*//g
s:[ \t]*/\*[ \t]*\*/::g

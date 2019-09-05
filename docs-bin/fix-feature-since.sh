#!/bin/bash

for i in *.html; do
	S=$(git show master:_feature/$i | grep "^since:")
	sed -i "s/^since:.*/$S/" $i
done


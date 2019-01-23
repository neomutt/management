#!/bin/bash

sort -nr -k2 percentages.txt | while read NAME NUM; do
	if [ $NUM -gt 49 ]; then
		COLOUR=green
	elif [ $NUM -gt 24 ]; then
		COLOUR=yellow
	else
		COLOUR=red
	fi
	wget --quiet -O $NAME.svg https://img.shields.io/badge/${NAME}-${NUM}%-${COLOUR}.svg
	echo ' * <img style="float: left; padding-right: 0.5em;" src="'$NAME'.svg">'
done


#!/bin/bash
for i in "$@"; do
	SIZE=$(wc -c < "$i")
	COMPRESSED=$(bzip2 -9 < "$i" | wc -c)
	RATIO=$(echo "scale=4;(8*${COMPRESSED})/${SIZE}" | bc)
	printf "%10i %10i %s " ${SIZE} ${COMPRESSED} ${RATIO}
	echo "$i"
done

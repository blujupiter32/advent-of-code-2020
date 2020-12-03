#!/usr/bin/bash

read line1 < input.txt
width=${#line1}

count=0
y=0

while read line; do
    x=$(((y*3)%width))
    current=${line:x:1}
    if [ "$current" = '#' ]; then
        count=$((count+1))
    fi
    y=$((y+1))
done < input.txt

echo $count

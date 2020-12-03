#!/usr/bin/bash

check() {
    dx=$1
    dy=$2

    read line1 < input.txt
    width=${#line1}

    count=0
    i=-1
    x=0
    y=0

    while read line; do
        i=$((i+1))
        if [ $i -ne $y ]; then
            continue
        fi
        current=${line:x:1}
        if [ "$current" = '#' ]; then
            count=$((count+1))
        fi
        x=$(((x+dx)%width))
        y=$((y+dy))
    done < input.txt

    echo $count
}

r1d1=$(check 1 1)
r3d1=$(check 3 1)
r5d1=$(check 5 1)
r7d1=$(check 7 1)
r1d2=$(check 1 2)
product=$((r1d1*r3d1*r5d1*r7d1*r1d2))
echo "$product"

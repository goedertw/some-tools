#!/bin/bash

excludelist="/\.DS_Store$ \.zip$ \.swp$ \.bak$ \.jpg$ \.pdf$ \.png$ \.PNG$ \.gif \.sav$ \.xlsx \.ods \.gz /\.git/"

echo find $@ -type f

find $@ -type f >check-encoding.tmpfile

wc check-encoding.tmpfile

for excl in $excludelist; do
    grep -v -e $excl check-encoding.tmpfile >check-encoding.tmpfile2
    mv check-encoding.tmpfile2 check-encoding.tmpfile
done

wc check-encoding.tmpfile

while read i; do
    #echo === testing $i
    iconv -f utf-8 -t utf-16 "$i" >/dev/null
done < check-encoding.tmpfile

rm -f check-encoding.tmpfile check-encoding.tmpfile2


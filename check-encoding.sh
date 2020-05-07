#!/bin/bash

excludelist="/\.DS_Store$ \.zip$ \.swp$ \.bak$ \.jpg$ \.pdf$ \.png$ \.gif \.sav$ \.xlsx \.ods \.gz /\.git/ \.jar \.docx \.jpeg \.eps \.otf"

echo find $@ -type f

find $@ -type f >check-encoding.tmpfile

wc check-encoding.tmpfile

for excl in $excludelist; do
    grep -v -i -e $excl check-encoding.tmpfile >check-encoding.tmpfile2
    mv check-encoding.tmpfile2 check-encoding.tmpfile
done
rm -f check-encoding.tmpfile2

wc check-encoding.tmpfile
#exit
while read i; do
    #echo === testing $i
    iconv -f utf-8 -t utf-16 "$i" >/dev/null
    #file "$i"
done < check-encoding.tmpfile

rm -f check-encoding.tmpfile


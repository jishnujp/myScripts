#!/bin/bash

screenshots_dir="/home/$(whoami)/Pictures/Screenshots"
downloads_dir="/home/$(whoami)/Downloads"

## Remove 1 month old screenshots
olds=$(find $screenshots_dir -type f -mtime +30)
rm $olds

## Remove 3 month old downloads
olds=$(find $downloads_dir -type f -mtime +90)
rm $olds

## Remove duplicate downloads
declare -A arr
for file in "$downloads_dir"/*; do
    hash=$(sha1sum "$file" | awk '{print $1}')
    if [[ -n "${arr[$hash]}" ]]; then
        if [[ "$file" -nt "${arr[$hash]}" ]]; then
            rm "${arr[$hash]}"
            arr[$hash]=$file
        else
            rm "$file"
        fi
    else
        arr[$hash]=$file
    fi
done
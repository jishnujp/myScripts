#!/bin/bash

downloads_dir="/home/bruce/Downloads"

declare -A arr

for file in "$downloads_dir"/*; do
    hash=$(sha1sum "$file" | awk '{print $1}')
    if [[ -n "${arr[$hash]}" ]]; then
        if [[ "$file" -nt "${arr[$hash]}" ]]; then
            echo "Removing ${arr[$hash]}"
            # rm "${arr[$hash]}"
            arr[$hash]=$file
        else
            echo "Removing $file"
            # rm "$file"
        fi
    else
        arr[$hash]=$file
    fi
done



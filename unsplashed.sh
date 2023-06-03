#!/bin/bash

keys_file="$(dirname $0)/keys.json"
if [[ ! -f $keys_file ]]; then
    echo "File $keys_file does not exist"
    exit 1
fi

path=/home/$(whoami)/Pictures/Background
if [[ ! -d $path ]]; then
    echo "Directory $path does not exist"
    exit 1
fi

access_key=$(jq -r ".unsplashed_access" $keys_file)
keywords=("city" "space" "classic" "car" "Mountain" "tech" "cyberpunk" "innovation" "vintage")
len=${#keywords[@]}
topics="wallpapers"
for keyword in "${keywords[@]}"; do
    url="https://api.unsplash.com/photos/random?topics=$topics&query=$keyword&orientation=landscape&content_filter=high&client_id=$access_key"
    url=$(curl $url | jq -r ".urls.full")
    curl -o "$path/$(date +%s%N)_$keyword.jpg" $url
done

url="https://api.unsplash.com/photos/random?&orientation=landscape&content_filter=high&client_id=$access_key"
url=$(curl $url | jq -r ".urls.full")
curl -o "$path/$(date +%s%N)_random.jpg" $url


olds=$(find $path -type f -mtime +3)
if [[ -n $olds ]]; then
    rm $olds
fi

#!/bin/bash

folder_to_compress="$1"

current_date_time=$(date +"%Y-%m-%d_%H-%M-%S")

backup_folder="/home/bruce/backup"
if [ ! -d "$backup_folder" ]; then
  mkdir "$backup_folder"
fi

tar -czvf "${backup_folder}/$(basename "$folder_to_compress")_${current_date_time}.tar.gz"  "$folder_to_compress"

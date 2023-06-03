#!/usr/bin/bash
practice()
{
	path="/home/$(whoami)/Desktop/practice/$1_practice"
	if [ ! -d $path ]
	then
		mkdir "$path"
		mkdir "$path/venv_$1"
		python3 -m venv "$path/venv_$1/"
		echo "created repo: $path"
	fi
	cd "$path"
	source "venv_$1/bin/activate"
	code .
}

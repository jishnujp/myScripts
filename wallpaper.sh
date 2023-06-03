path=/home/bruce/Pictures/Background/
file="$path$(ls $path | sort -R | tail -1)"

gsettings set org.gnome.desktop.background picture-uri-dark $file
gsettings set org.gnome.desktop.background picture-uri $file

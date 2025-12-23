#!/bin/bash
# Set random wallpaper from Background folder
# Works with GNOME desktop

wallpaper_dir="$HOME/Pictures/Background"

# Check if directory exists
if [ ! -d "$wallpaper_dir" ]; then
    echo "Error: Wallpaper directory not found: $wallpaper_dir"
    exit 1
fi

# Get random wallpaper
wallpaper=$(find "$wallpaper_dir" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)

if [ -z "$wallpaper" ]; then
    echo "Error: No wallpapers found in $wallpaper_dir"
    exit 1
fi

# Convert to file:// URI format
wallpaper_uri="file://${wallpaper}"

# Set wallpaper for GNOME
if command -v gsettings &> /dev/null; then
    gsettings set org.gnome.desktop.background picture-uri-dark "$wallpaper_uri"
    gsettings set org.gnome.desktop.background picture-uri "$wallpaper_uri"
    echo "Wallpaper changed to: $(basename "$wallpaper")"
else
    echo "Error: gsettings not found (GNOME required)"
    exit 1
fi
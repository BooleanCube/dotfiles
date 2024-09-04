#!/usr/bin/env bash

# initializing a wallpaper daemon
swww init &
# setting wallpaper
swww img ~/.config/wallpaper.png &

nm-applet --indicator &

waybar &

mako

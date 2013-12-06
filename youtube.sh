#!/bin/bash
umask 000
youtube-dl -x $1 --audio-format mp3 --restrict-filenames -w -c -o "/home/youtube/mp3/%(title)s.%(ext)s"
NEW=$(youtube-dl --get-filename $1 --restrict-filenames -w -c -o "%(title)s.mp3")
mpc update --wait youtube
mpc add youtube/mp3/"$NEW"

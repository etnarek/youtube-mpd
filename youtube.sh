#!/bin/bash

# Be nice and reduce self-priority; avconv can take a lot of ressources and slow other process otherwise
renice -n 10 $$ >> /dev/null

#Youtube's mpd relative path
MPD_YOUTUBE="youtube/mp3"

#Absolute path to the youtube library (physical location)
DESTINATION="/home/$MPD_YOUTUBE"

umask 000
youtube-dl -x $1 --audio-format mp3 --restrict-filenames -w -c -o "$DESTINATION/%(title)s.%(ext)s"
for downloaded in $(youtube-dl --get-filename $1 --restrict-filenames -w -c -o "%(title)s.mp3"); do
  mpc update --wait $MPD_YOUTUBE/$downloaded
  mpc insert $MPD_YOUTUBE/$downloaded
done

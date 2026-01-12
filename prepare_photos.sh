#!/usr/bin/env bash

# Sync with gdrive
/home/dje/photo_frame/sync_pics.sh

# process pics
/home/dje/photo_frame/preprocessing.sh
rm /home/dje/gdrive_pics/*

# Notify slideshow
sudo pkill -HUP -f diaporama.py
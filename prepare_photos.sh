#!/usr/bin/env bash

# Sync with gdrive
/usr/bin/rclone sync gdrive_pics:cadre_photo/ /home/dje/gdrive_pics/

# process pics
/home/dje/photo_frame/preprocessing.sh

# Notify slideshow
sudo pkill -HUP -f diaporama.py
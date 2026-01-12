#!/usr/bin/env bash

REMOTE_NAME="gdrive_pics:cadre_photo"
LOCAL_GDRIVE="/home/dje/gdrive_pics/"
LOCAL_PROCESSED="/home/dje/processed_pics"

# 1. List files from GDrive
rclone lsf "$REMOTE_NAME" > /tmp/remote_files.txt

# 2. List local files
ls "$LOCAL_PROCESSED" > /tmp/local_files.txt


# --- LOGIC 1 : NEW FILES ---
comm -23 <(sort /tmp/remote_files.txt) <(sort /tmp/local_files.txt) > /tmp/to_download.txt

while read -r filename; do
    if [ -n "$filename" ]; then
        # echo "--> New file: $filename"
        rclone copyto "$REMOTE_NAME/$filename" "$LOCAL_GDRIVE/$filename"
    fi
done < /tmp/to_download.txt

# --- LOGIC 2 : REMOVED FILES ---
comm -13 <(sort /tmp/remote_files.txt) <(sort /tmp/local_files.txt) > /tmp/to_delete.txt

while read -r filename; do
    if [ -n "$filename" ]; then
        echo "--> Removed file: $filename"
        rm "$LOCAL_PROCESSED/$filename"
    fi
done < /tmp/to_delete.txt

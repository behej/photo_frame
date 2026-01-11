#!/usr/bin/env bash

SOURCE="/home/dje/gdrive_pics"
DEST="/home/dje/processed_pics"
RES="1024x600"

# Créer le dossier de destination s'il n'existe pas
mkdir -p "$DEST"


for img in "$SOURCE"/*.{jpg,jpeg,png,JPG,JPEG,PNG}; do
    [ -e "$img" ] || continue
    
    filename=$(basename "$img")
    echo "Processing file: $filename"    
    convert "$img" -resize "$RES" -quality 80 -strip "$DEST/$filename"
done

sudo pkill -HUP -f diaporama.py
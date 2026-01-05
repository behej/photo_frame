#!/usr/bin/env python3
import os
import time
import subprocess


# --- CONFIGURATION ---
PICS_PATH = "/home/dje/gdrive_pics/"


def clear_pic():
    subprocess.run(["sudo", "pkill", "-QUIT", "fbi"], stderr=subprocess.DEVNULL)


def display_pic(filepath):
    clear_pic()
    cmd = ["sudo", "fbi", "-d", "/dev/fb0", "-T", "1", "-a", "--noverbose", "-1", filepath]
    subprocess.Popen(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


def main():
    pictures = [f for f in os.listdir(PICS_PATH) if f.lower().endswith(('.jpg', '.jpeg', '.png'))]

    while True:
        for pic in pictures:
            display_pic(os.path.join(PICS_PATH, pic))
            time.sleep(5)



if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        pass

    clear_pic()
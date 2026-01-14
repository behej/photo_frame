#!/usr/bin/env python3
import os
import time
import subprocess
import signal

# --- CONFIGURATION ---
PICS_PATH = "/home/dje/processed_pics/"
DELAY = 5
PICTURES = []


def clear_pic():
    subprocess.run(["sudo", "pkill", "-QUIT", "fbi"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


def display_pic(filepath):
    clear_pic()
    cmd = ["sudo", "fbi", "-d", "/dev/fb0", "-T", "1", "-a", "--noverbose", "-1", filepath]
    subprocess.Popen(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def load_pictures_list():
    global PICTURES
    PICTURES = [f for f in os.listdir(PICS_PATH) if f.lower().endswith(('.jpg', '.jpeg', '.png'))]

def handler_signal(signum, frame):
    load_pictures_list()


def main():
    load_pictures_list()

    while True:
        for pic in PICTURES:
            display_pic(os.path.join(PICS_PATH, pic))
            time.sleep(DELAY)




signal.signal(signal.SIGHUP, handler_signal)

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        pass

    clear_pic()

import os
import subprocess
import re
import logging
from datetime import datetime

#Made for SoM Plex HTPC MPV, Plex does not send filenames to the client so you must tag
#the video stream with the proper tag so the conditional profile will activate.

#add as many keywords as you want following formatting.
KEYWORDS = ["web-dl", "webdl", "web-rip", "webrip", "subsplease", "erai-raws", "tsundere-raws", "-varyg", "horriblesubs", "subsplus+", "yameii"]
LOG_FILE = "tagging_history.log"

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(LOG_FILE, encoding='utf-8'),
        logging.StreamHandler()
    ]
)

def prompt_for_directory():
    while True:
        raw = input("Enter the directory to process (all subfolders will be included): ").strip()
        path = os.path.normpath(raw.strip('"').strip("'"))
        if raw and os.path.isdir(path):
            return path
        print(f"Not a valid directory: {raw or '(empty)'}\nTry again.\n")

def update_mkv_title(file_path, tag):
    cmd = ['mkvpropedit', file_path, '--edit', 'track:v1', '--set', f'name={tag}']
    try:
        subprocess.check_call(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        return True
    except subprocess.CalledProcessError:
        return False

def scan_and_tag(target_dir):
    keyword_regex = re.compile('|'.join(re.escape(k) for k in KEYWORDS), re.IGNORECASE)

    logging.info(f"starting scan in: {target_dir}")
    for root, _, files in os.walk(target_dir):
        for file in files:
            if file.lower().endswith(".mkv"):
                full_path = os.path.join(root, file)

                match = keyword_regex.search(file)
                if match:
                    tag = match.group()
                    success = update_mkv_title(full_path, tag)

                    status = f"SUCCESS: title updated to {tag}" if success else "FAILURE: could not update"
                    logging.info(f"{status} | path: {full_path}")

if __name__ == "__main__":
    target = prompt_for_directory()
    scan_and_tag(target)
    logging.info("Process Complete.")

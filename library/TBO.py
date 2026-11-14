import os
import json
import subprocess
import re

MKVMERGE_PATH = r"C:\Program Files\MKVToolNix\mkvmerge.exe"

G_GREEN = "\033[92m"
B_MAGENTA = "\033[95m"
B_CYAN = "\033[96m"
B_YELLOW = "\033[93m"
RED = "\033[31m"
BOLD = "\033[1m"
RESET = "\033[0m"

def get_media_info(file_path):
    try:
        result = subprocess.run(
            [MKVMERGE_PATH, "-J", file_path],
            capture_output=True,
            text=True,
            check=True,
            encoding='utf-8'
        )
        return json.loads(result.stdout)
    except Exception as e:
        print(f"{RED}Error reading metadata for {file_path}: {e}{RESET}")
        return None

def clean_track_name(name):
    if not name:
        return ""

    cleaned = re.sub(r'\[.*?\]', '', name)
    cleaned = re.sub(r'\b(19|20)\d{2}\b', '', cleaned)
    cleaned = re.sub(r'/?\s*\d+\s*(kbps|Mbps)\b', '', cleaned, flags=re.IGNORECASE)
    cleaned = re.sub(r'/?\s*\d+(\.\d+)?\s*(kHz|Hz)\b', '', cleaned, flags=re.IGNORECASE)
    cleaned = re.sub(r'/?\s*\d+\s*-?bits?\b', '', cleaned, flags=re.IGNORECASE)
    cleaned = re.sub(r'\s*/\s*', ' / ', cleaned)
    cleaned = re.sub(r'\s+', ' ', cleaned).strip(' / -')

    return cleaned

def make_track_signature(track):
    track_type = track.get('type')
    properties = track.get('properties', {})
    lang = properties.get('language', 'und').lower()
    codec = track.get('codec', '')
    is_commentary = properties.get('flag_commentary', False)

    raw_name = properties.get('track_name', '')
    cleaned_name = clean_track_name(raw_name)

    if 'commentary' in raw_name.lower():
        is_commentary = True

    return (track_type, lang, codec, cleaned_name, is_commentary)

def format_signature(sig, max_codec_len=0):
    t_type, lang, codec, name, is_commentary = sig
    
    lang_raw = f"[{lang.upper()}]".ljust(6)
    codec_raw = codec.ljust(max_codec_len) if max_codec_len else codec
    name_raw = f'"{name}"' if name else ""

    lang_colored = f"{G_GREEN}{lang_raw}{RESET}"
    codec_colored = f"{B_MAGENTA}{codec_raw}{RESET}"
    name_colored = f"{B_CYAN}{name_raw}{RESET}"
    
    commentary_colored = ""
    if is_commentary and "COMMENTARY" not in name.upper():
        commentary_colored = f" {RED}[COMMENTARY]{RESET}"

    return f"{lang_colored} {codec_colored}  {name_colored}{commentary_colored}"

def scan_directory_for_tracks(input_dir, mkv_files):
    audio_signatures = set()
    sub_signatures = set()

    print(f"\n{B_CYAN}Scanning{RESET} {len(mkv_files)} files for tracks to obliterate...")

    for file in mkv_files:
        full_path = os.path.join(input_dir, file)
        media_info = get_media_info(full_path)
        if not media_info:
            continue

        for track in media_info.get('tracks', []):
            t_type = track.get('type')
            sig = make_track_signature(track)

            if t_type == 'audio':
                audio_signatures.add(sig)
            elif t_type == 'subtitles':
                sub_signatures.add(sig)

    return sorted(list(audio_signatures)), sorted(list(sub_signatures))

def select_tracks(sig_list, track_type_label):
    if not sig_list:
        print(f"\n{RED}No {track_type_label.lower()} tracks found in any files dummy.{RESET}\n")
        return []

    max_codec_len = max(len(sig[2]) for sig in sig_list) if sig_list else 0

    print(f"\n{B_YELLOW}--- Unique {track_type_label.lower()} tracks found ---{RESET}")
    sig_map = {}
    for idx, sig in enumerate(sig_list, 1):
        sig_map[idx] = sig
        print(f"  {BOLD}{B_YELLOW}[{idx}]{RESET} {format_signature(sig, max_codec_len)}")

    user_input = input(f"\n{BOLD}Select {track_type_label.lower()} tracks to {B_YELLOW}KEEP{RESET} (e.g. '2,1,4' to keep & reorder, or Enter to drop ALL): ")
    if not user_input.strip():
        return []

    selected_sigs = []
    for choice in user_input.split(','):
        choice = choice.strip()
        if choice.isdigit() and int(choice) in sig_map:
            sig = sig_map[int(choice)]
            if sig not in selected_sigs:
                selected_sigs.append(sig)
        else:
            print(f"{RED}Warning: invalid selection '{choice}' skipped.{RESET}")

    return selected_sigs

def process_file(file_path, output_dir, keep_audio_sigs, keep_sub_sigs, drop_attachments, drop_chapters):
    print(f"{B_CYAN}Processing:{RESET} {os.path.basename(file_path)}")

    media_info = get_media_info(file_path)
    if not media_info:
        print(f"  └─ {RED}Error reading file info.{RESET}")
        return

    video_ids = []
    audio_sig_to_id = {}
    sub_sig_to_id = {}

    for track in media_info.get('tracks', []):
        track_id = str(track.get('id'))
        t_type = track.get('type')
        sig = make_track_signature(track)

        if t_type == 'video':
            video_ids.append(track_id)
        elif t_type == 'audio':
            audio_sig_to_id[sig] = track_id
        elif t_type == 'subtitles':
            sub_sig_to_id[sig] = track_id

    audio_ids_to_keep = [audio_sig_to_id[sig] for sig in keep_audio_sigs if sig in audio_sig_to_id]
    sub_ids_to_keep = [sub_sig_to_id[sig] for sig in keep_sub_sigs if sig in sub_sig_to_id]

    output_file = os.path.join(output_dir, os.path.basename(file_path))
    cmd = [MKVMERGE_PATH, "-o", output_file]

    if video_ids:
        cmd += ["-d", ",".join(video_ids)]
    else:
        cmd += ["-D"]

    if audio_ids_to_keep:
        cmd += ["-a", ",".join(audio_ids_to_keep)]
    else:
        cmd += ["-A"]

    if sub_ids_to_keep:
        cmd += ["-s", ",".join(sub_ids_to_keep)]
    else:
        cmd += ["-S"]

    if drop_attachments:
        cmd.append("--no-attachments")

    if drop_chapters:
        cmd.append("--no-chapters")

    ordered_track_specs = [f"0:{tid}" for tid in video_ids + audio_ids_to_keep + sub_ids_to_keep]
    if ordered_track_specs:
        cmd += ["--track-order", ",".join(ordered_track_specs)]

    for i, aid in enumerate(audio_ids_to_keep):
        flag = "yes" if i == 0 else "no"
        cmd += ["--default-track-flag", f"{aid}:{flag}"]

    for i, sid in enumerate(sub_ids_to_keep):
        flag = "yes" if i == 0 else "no"
        cmd += ["--default-track-flag", f"{sid}:{flag}"]

    cmd.append(file_path)

    try:
        result = subprocess.run(cmd)

        if result.returncode in [0, 1]:
            print(f"  └─ {G_GREEN}Done!{RESET}")
        else:
            print(f"  └─ {RED}Error! Failed to remux {os.path.basename(file_path)}{RESET}")

    except Exception as e:
        print(f"  └─ {RED}Error running process: {e}{RESET}")

def main():
    os.system('')
    
    input_dir = input(f"\n{BOLD}{B_CYAN}Enter the directory path to scan:{RESET} ").strip().strip('"')
    if not os.path.isdir(input_dir):
        print(f"{RED}Error! The specified directory does not exist.{RESET}")
        return

    output_dir = os.path.join(input_dir, "debloat_output")

    mkv_files = [f for f in os.listdir(input_dir) if f.lower().endswith('.mkv')]
    if not mkv_files:
        print(f"{RED}Error! No MKV files found in the directory.{RESET}")
        return

    audio_sigs, sub_sigs = scan_directory_for_tracks(input_dir, mkv_files)

    keep_audio_sigs = select_tracks(audio_sigs, "Audio")
    keep_sub_sigs = select_tracks(sub_sigs, "Subtitle")

    print()
    drop_attachments = input(f"{BOLD}Do you want to {RED}DROP{RESET}{BOLD} attachments (fonts, images, etc.)?{RESET} ({B_YELLOW}y/n, default: no{RESET}): ").strip().lower() in ['y', 'yes']
    drop_chapters = input(f"{BOLD}Do you want to {RED}DROP{RESET}{BOLD} chapters?{RESET} ({B_YELLOW}y/n, default: no{RESET}): ").strip().lower() in ['y', 'yes']

    max_audio_codec_len = max(len(sig[2]) for sig in keep_audio_sigs) if keep_audio_sigs else 0
    max_sub_codec_len = max(len(sig[2]) for sig in keep_sub_sigs) if keep_sub_sigs else 0

    print(f"\n{RED}=========================================================={RESET}")
    print(f"{BOLD}{B_YELLOW}                Total Bloat Obliteration                  {RESET}")
    print(f"{RED}=========================================================={RESET}")
    
    print(f" - {BOLD}{B_YELLOW}Audio tracks to keep (in order):{RESET}")
    if keep_audio_sigs:
        for sig in keep_audio_sigs:
            print(f"    • {format_signature(sig, max_audio_codec_len)}")
    else:
        print(f"    {RED}• NONE (Stripping all audio){RESET}")

    print(f" - {BOLD}{B_YELLOW}Subtitle tracks to keep (in order):{RESET}")
    if keep_sub_sigs:
        for sig in keep_sub_sigs:
            print(f"    • {format_signature(sig, max_sub_codec_len)}")
    else:
        print(f"    {RED}• NONE (Stripping all subtitles){RESET}")

    print(f" - {BOLD}{B_YELLOW}Drop attachments:{RESET}                 {RED if drop_attachments else G_GREEN}{drop_attachments}{RESET}")
    print(f" - {BOLD}{B_YELLOW}Drop chapters:{RESET}                    {RED if drop_chapters else G_GREEN}{drop_chapters}{RESET}")
    print(f" - {BOLD}{B_YELLOW}Output folder:{RESET}                    {B_CYAN}{output_dir}{RESET}")

    confirm = input(f"\n{BOLD}{B_CYAN}Remuxing dis shit?{RESET} ({B_YELLOW}y/n, default: yes{RESET}): ").strip().lower()
    if confirm in ['n', 'no']:
        print(f"\n{RED}Aborted, what you should have been.{RESET}\n")
        return

    print()
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    for file in mkv_files:
        full_path = os.path.join(input_dir, file)
        process_file(full_path, output_dir, keep_audio_sigs, keep_sub_sigs, drop_attachments, drop_chapters)

    print(f"\n{BOLD}{G_GREEN}===================== BLOAT OBLITERATED ====================={RESET}\n")

if __name__ == "__main__":
    main()

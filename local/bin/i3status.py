#!/usr/bin/env python3

import datetime
import json
import os
import psutil
import shutil
import subprocess
import time


class CPU:
    def __init__(self):
        self.prev_total = 0
        self.prev_idle = 0
        self._read_proc_stat()

    def _read_proc_stat(self):
        with open("/proc/stat", "r") as f:
            user, nice, system, idle = map(int, f.readline().split()[1:5])
            return idle, user + nice + system + idle

    def get_usage(self):
        idle, total = self._read_proc_stat()

        delta_idle = idle - self.prev_idle
        delta_total = total - self.prev_total

        self.prev_idle = idle
        self.prev_total = total

        if delta_total == 0:
            return "🖥️ 0%"

        return f"🖥️ {(delta_total - delta_idle) * 100 // delta_total}%"


def get_temp():
    temps = psutil.sensors_temperatures()
    for name, entries in temps.items():
        for entry in entries:
            if "Core 0" in entry.label:
                return f"🌡️ {entry.current:.1f}°C"
    return "🌡️ N/A"


def get_ram():
    mem = psutil.virtual_memory()
    used = mem.total - mem.available
    used_gb = used / (1024**3)
    return f"🧠 {used_gb:.1f}GiB"


def get_disk():
    usage = shutil.disk_usage("/")
    percent = int(usage.used / usage.total * 100)
    return f"💿 {percent}%"


def get_updates():
    cache = os.path.join(os.environ.get("XDG_CACHE_HOME", "/tmp"), "xbps_updates_count")
    if not os.path.isfile(cache) or (time.time() - os.path.getmtime(cache) > 300):
        try:
            count = os.popen("xbps-install -Mun 2>/dev/null | wc -l").read().strip()
            with open(cache, "w") as f:
                f.write(count)
        except Exception:
            with open(cache, "w") as f:
                f.write("0")
    with open(cache) as f:
        return f"📦 {f.read().strip()}"


def run(cmd):
    return subprocess.run(
        cmd, shell=True, capture_output=True, text=True
    ).stdout.strip()


def get_volume():
    muted = run("pactl get-sink-mute @DEFAULT_SINK@").split()[-1]
    vol = run("pactl get-sink-volume @DEFAULT_SINK@").split()[+4]
    return f"🔇 {vol}" if muted == "yes" else f"🔊 {vol}"


def get_battery():
    battery = psutil.sensors_battery()
    if battery is None:
        return "🔋 N/A"
    percent = int(battery.percent)
    if battery.power_plugged:
        return f"⚡ {percent}%"
    else:
        return f"🔋 {percent}%"


def get_uptime():
    seconds = time.clock_gettime(time.CLOCK_MONOTONIC)
    return f"⌛ {str(datetime.timedelta(seconds=int(seconds)))}"


def get_date():
    return datetime.datetime.now().strftime("📆 %A, %B %d")


def get_time():
    return datetime.datetime.now().strftime("⏰ %-I:%M %p")


def main():
    print('{ "version": 1, "click_events": false }')
    print("[")
    print("[],")

    cpu_tracker = CPU()

    while True:
        blocks = [
            {"name": "cpu", "full_text": f" {cpu_tracker.get_usage()} "},
            {"name": "temp", "full_text": f" {get_temp()} "},
            {"name": "ram", "full_text": f" {get_ram()} "},
            {"name": "disk", "full_text": f" {get_disk()} "},
            {"name": "updates", "full_text": f" {get_updates()} "},
            {"name": "volume", "full_text": f" {get_volume()} "},
            {"name": "battery", "full_text": f" {get_battery()} "},
            {"name": "uptime", "full_text": f" {get_uptime()} "},
            {"name": "date", "full_text": f" {get_date()} "},
            {"name": "time", "full_text": f" {get_time()} "},
        ]
        print(json.dumps(blocks) + ",", flush=True)
        time.sleep(1)


if __name__ == "__main__":
    main()

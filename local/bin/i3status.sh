#!/bin/sh

# --- Helpers ---
get_cpu() {
  read -r cpu user nice system idle rest </proc/stat
  total=$((user + nice + system + idle))
  [ -z "$delta_total" ] && echo "🖥️ 0%" && return
  delta_idle=$((idle - prev_idle))
  prev_idle=$idle
  delta_total=$((total - prev_total))
  prev_total=$total
  delta_active=$(((delta_total - delta_idle) * 100))
  echo "🖥️ $(($delta_active / delta_total))%"
}

get_temp() {
  sensors | awk '/^Core 0:/ { printf "🌡️ %s", $3 }'
}

get_ram() {
  free -h | awk '/^Mem:/ { printf "🧠 %sB", $3 }'
}

get_disk() {
  df -h / | awk 'NR==2 { printf "💿 %s", $5 }'
}

get_updates() {
  cache=${XDG_CACHE_HOME:-/tmp}/xbps_updates_count
  if [ ! -f "$cache" ] || [ $(($(date +%s) - $(stat -c %Y "$cache"))) -ge 300 ]; then
    echo "$(xbps-install -Mun 2>/dev/null | wc -l)" >"$cache"
  fi
  echo "📦 $(cat "$cache")"
}

get_volume() {
  muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
  vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1 { print $5 }')
  [ "$muted" = "yes" ] && echo "🔇 $vol" || echo "🔊 $vol"
}

get_battery() {
  bat=$(find /sys/class/power_supply/ -name 'BAT*' | head -1)
  [ -z "$bat" ] && echo "🔋 N/A" && return
  if [ "$(cat "$bat/status")" = 'Charging' ]; then
    echo "⚡ $(cat "$bat/capacity")% "
  else
    echo "🔋 $(cat "$bat/capacity")% "
  fi
}

get_uptime() {
  echo "⌛ $(
    python3 - <<__EOF__
import datetime; import time
now = int(time.clock_gettime(time.CLOCK_MONOTONIC))
print(datetime.timedelta(seconds=now))
__EOF__
  )"
}

get_date() {
  date '+📆 %A, %B %d'
}

get_time() {
  date '+⏰ %-I:%M %p'
}

# --- Setup ---
echo '{ "version": 1, "click_events": false }'
echo '['
echo '[],'

# --- Main loop ---
while :; do
  echo "["
  printf '  { "name": "cpu",        "full_text": "%s" },\n' "$(get_cpu)"
  printf '  { "name": "temp",       "full_text": "%s" },\n' "$(get_temp)"
  printf '  { "name": "ram",        "full_text": "%s" },\n' "$(get_ram)"
  printf '  { "name": "disk",       "full_text": "%s" },\n' "$(get_disk)"
  printf '  { "name": "updates",    "full_text": "%s" },\n' "$(get_updates)"
  printf '  { "name": "volume",     "full_text": "%s" },\n' "$(get_volume)"
  printf '  { "name": "battery",    "full_text": "%s" },\n' "$(get_battery)"
  printf '  { "name": "uptime",     "full_text": "%s" },\n' "$(get_uptime)"
  printf '  { "name": "date",       "full_text": "%s" },\n' "$(get_date)"
  printf '  { "name": "time",       "full_text": "%s" } \n' "$(get_time)"
  echo "],"
  sleep 1
done

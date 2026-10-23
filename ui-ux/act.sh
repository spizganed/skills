# Record the phone while one UI action runs, then print a frame sheet of just that action.
# Usage: act.sh "<adb shell command>" [fps=30] [secs=1.2] [out=act.png]
# Example: act.sh "input tap 500 120"   or   act.sh "input keyevent 4"
# Needs adb connected (adb -s $ADB_DEVICE, default 127.0.0.1:5555).
set -eu
cmd=${1:?adb shell command}; fps=${2:-30}; secs=${3:-1.2}; out=${4:-act.png}
a="adb -s ${ADB_DEVICE:-127.0.0.1:5555}"; here=$(dirname "$0"); v=$(mktemp -u).mp4
$a shell screenrecord --time-limit $(awk "BEGIN{printf \"%d\", $secs+3}") --size 540x1200 /sdcard/Download/act.mp4 &
rec=$!; sleep 1.2
$a shell "$cmd"
sleep "$secs"
wait $rec || true
$a pull -q /sdcard/Download/act.mp4 "$v"
SS=1.0 LEN=$(awk "BEGIN{print $secs+0.5}") bash "$here/frames.sh" "$v" "$fps" 6 "$out"
rm -f "$v"

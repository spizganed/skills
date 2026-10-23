# Needs bash, ffmpeg, imagemagick.
# Turn a screen recording into one contact sheet so Claude can read an animation.
# Usage: frames.sh video [fps=15] [cols=6] [out=sheet.png]
set -eu
v=${1:?video}; fps=${2:-15}; cols=${3:-6}; out=${4:-sheet.png}
d=$(mktemp -d); trap 'rm -rf "$d"' EXIT
ffmpeg -loglevel error -i "$v" -vf "fps=$fps,scale=240:-1" "$d/%04d.png"
i=0
for f in "$d"/*.png; do
  magick "$f" -gravity NorthWest -pointsize 14 -fill yellow -undercolor '#0008' \
    -annotate +2+2 " $(awk "BEGIN{printf \"%d\", $i*1000/$fps}") ms " "$f"
  i=$((i+1))
done
montage "$d"/*.png -tile "${cols}x" -geometry +2+2 -background '#222' "$out"
echo "$out: $i frames at $fps fps"

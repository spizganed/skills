#!/usr/bin/env python3
"""Measure UI facts from pixels. Needs Python 3 and Pillow. `flash` also needs ffmpeg.

  measure.py contrast IMG X1,Y1 X2,Y2      contrast ratio of two pixels
  measure.py text IMG X,Y,W,H              contrast of text in a box (background = most common color)
  measure.py target IMG X,Y,W,H SCALE      box size in pt or dp (SCALE = pixels per pt or dp)
  measure.py corners IMG X,Y,W,H [GAP]     square background behind a rounded shape
  measure.py sharp IMG X,Y,W,H             edge sharpness score (compare siblings, low = blurry)
  measure.py flash VIDEO [FPS] [THRESHOLD] pause between two changes in a recording
"""
import subprocess, sys, tempfile, os, glob
from collections import Counter
from PIL import Image, ImageFilter, ImageChops, ImageStat


def box(s):
    x, y, w, h = (int(v) for v in s.split(","))
    return x, y, x + w, y + h


def lum(c):
    def f(v):
        v /= 255
        return v / 12.92 if v <= 0.03928 else ((v + 0.055) / 1.055) ** 2.4
    r, g, b = c[:3]
    return 0.2126 * f(r) + 0.7152 * f(g) + 0.0722 * f(b)


def ratio(a, b):
    la, lb = sorted((lum(a), lum(b)), reverse=True)
    return (la + 0.05) / (lb + 0.05)


def hexc(c):
    return "#%02x%02x%02x" % tuple(c[:3])


def contrast(img, p1, p2):
    im = Image.open(img).convert("RGB")
    a, b = (im.getpixel(tuple(int(v) for v in p.split(","))) for p in (p1, p2))
    print(f"{hexc(a)} on {hexc(b)}: {ratio(a, b):.2f}:1")


def text(img, region):
    px = Image.open(img).convert("RGB").crop(box(region))
    cnt = Counter(px.get_flattened_data() if hasattr(px, "get_flattened_data") else px.getdata())
    bg = cnt.most_common(1)[0][0]
    fg = max(cnt, key=lambda c: abs(lum(c) - lum(bg)))
    print(f"text {hexc(fg)} on {hexc(bg)}: {ratio(fg, bg):.2f}:1 (4.5:1 for text up to 17 pt, 3:1 above)")


def target(img, region, scale):
    x0, y0, x1, y1 = box(region)
    w, h = (x1 - x0) / float(scale), (y1 - y0) / float(scale)
    print(f"{w:.1f} x {h:.1f} pt or dp (iOS 44, Android 48)")


def corners(img, region, gap="2"):
    im = Image.open(img).convert("RGB")
    x0, y0, x1, y1 = box(region)
    g = int(gap)
    bad = 0
    for name, (cx, cy), (ox, oy) in (
        ("top-left", (x0, y0), (x0 - g, y0 - g)),
        ("top-right", (x1 - 1, y0), (x1 - 1 + g, y0 - g)),
        ("bottom-left", (x0, y1 - 1), (x0 - g, y1 - 1 + g)),
        ("bottom-right", (x1 - 1, y1 - 1), (x1 - 1 + g, y1 - 1 + g)),
    ):
        inner, outer = im.getpixel((cx, cy)), im.getpixel((ox, oy))
        diff = max(abs(a - b) for a, b in zip(inner, outer))
        flag = "ok" if diff <= 8 else "SQUARE BACKGROUND"
        bad += flag != "ok"
        print(f"{name}: corner {hexc(inner)} outside {hexc(outer)} -> {flag}")
    print("result:", "square corners show behind the rounded shape" if bad else "clean corners")


def sharp(img, region):
    px = Image.open(img).convert("L").crop(box(region)).filter(ImageFilter.FIND_EDGES)
    s = ImageStat.Stat(px)
    print(f"edge strength {s.mean[0]:.1f}, spread {s.stddev[0]:.1f} (compare with a sibling asset)")


def flash(video, fps="30", thr="1.5"):
    d = tempfile.mkdtemp()
    subprocess.run(["ffmpeg", "-v", "error", "-i", video, "-vf", f"fps={fps},scale=360:-1",
                    os.path.join(d, "%05d.png")], check=True)
    files = sorted(glob.glob(os.path.join(d, "*.png")))
    diffs = []
    prev = Image.open(files[0]).convert("L")
    for f in files[1:]:
        cur = Image.open(f).convert("L")
        diffs.append(ImageStat.Stat(ImageChops.difference(prev, cur)).mean[0])
        prev = cur
    moving = [v > float(thr) for v in diffs]
    runs, i = [], 0
    while i < len(moving):
        if moving[i]:
            j = i
            while j < len(moving) and moving[j]:
                j += 1
            runs.append((i, j))
            i = j
        else:
            i += 1
    print(f"frames: {len(files)} at {fps} fps, frames in {d}")
    for k, (a, b) in enumerate(runs):
        print(f"change {k + 1}: frames {a + 1}-{b} ({a / float(fps):.2f}-{b / float(fps):.2f} s)")
    for (a, b), (c, e) in zip(runs, runs[1:]):
        if c - b <= int(float(fps) * 0.25):
            print(f"FLASH CANDIDATE: still gap of {c - b} frames after frame {b}, then a second change at frame {c + 1}."
                  " Read frames to confirm a refresh before the animation.")


CMDS = {"contrast": contrast, "text": text, "target": target, "corners": corners, "sharp": sharp, "flash": flash}
if __name__ == "__main__" and len(sys.argv) > 2 and sys.argv[1] in CMDS:
    CMDS[sys.argv[1]](*sys.argv[2:])
else:
    sys.exit(__doc__)

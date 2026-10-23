# Capture guide

How to get the images and recordings for `/audit-ui`. Use the real size of the screen. Do not scale an image down.

## Android phone or emulator

- Screenshot: `adb exec-out screencap -p > screen.png`
- Recording: `adb shell screenrecord --time-limit 20 /sdcard/rec.mp4`, then `adb pull /sdcard/rec.mp4`. For a smooth recording, add `--bit-rate 16000000`.
- Dark mode: `adb shell cmd uimode night yes`. Light mode: `night no`.
- Text size 200 percent: `adb shell settings put system font_scale 2.0`. Reset with `1.0`.
- Smallest size: `adb shell wm size 720x1280`. Reset with `adb shell wm size reset`.
- Density: `adb shell wm density 480`. Reset with `adb shell wm density reset`.
- Slow animations, to see a flash: `adb shell settings put global animator_duration_scale 5`. Reset with `1`.
- Taps: `adb shell input tap X Y`. Swipes: `adb shell input swipe X1 Y1 X2 Y2 DURATION_MS`.
- Layout bounds and view tree: `adb shell uiautomator dump /sdcard/ui.xml`. Use it to read control sizes and labels.
- Frame timing: `adb shell dumpsys gfxinfo PACKAGE framestats`.

## iOS simulator

- Screenshot: `xcrun simctl io booted screenshot screen.png`
- Recording: `xcrun simctl io booted recordVideo rec.mp4`
- Dark mode: `xcrun simctl ui booted appearance dark`
- Text size: `xcrun simctl ui booted content_size accessibility-extra-extra-extra-large`
- Increase Contrast: `xcrun simctl ui booted increase_contrast enabled`

## Desktop app

- Linux X11: `import -window root screen.png` or `scrot`. Wayland: `grim screen.png`.
- Recording: `wf-recorder -f rec.mp4` (Wayland) or `ffmpeg -f x11grab -framerate 60 -i :0 rec.mp4` (X11).
- Run an egui or similar app on a virtual display with `xvfb-run` for a repeatable size.

## Web page

- Screenshot at two sizes: `firefox --headless --screenshot out.png --window-size=390,844 URL`, then `1440,900`.
- Dark mode: add `?theme=dark` if the page supports it, or set `prefers-color-scheme` in the browser.

## Recording to frames

- Run `python3 audit-ui/measure.py flash rec.mp4 60`. Record at 60 fps if the device allows it.
- Extract frames by hand: `ffmpeg -i rec.mp4 -vf fps=60 frames/%05d.png`. Read the frames around each change.
- A flash is one frame where the old screen refreshes or the content jumps, and then the animation starts.

## Test states

- Empty and error: turn off the network, clear the data, or use a test account.
- Long text: type 200 characters in each input. Use a long device name.
- Many items: add 1,000 items, or use a debug build.
- Keyboard over input: focus the lowest input on the screen and capture.

---
name: ui-ux
description: Use only when you design, build, or change a user interface, screen, layout, or interaction. Skip for logic, backend, and build work.
---

# UI/UX

## Before you build
- Name the one job of the screen. Put that action first and make it the most visible.
- Reuse existing components, tokens, and patterns. Read them first. Do not add a style that has no match in the app.
- Follow the platform: Material on Android, native feel on desktop. Do not copy a web pattern.

## Consistency
- Before you add a screen, read 2 sibling screens. List their paddings, type sizes, colors, radii, and components.
- Copy those values. Do not invent new ones. If a new value is needed, add it to the shared tokens first.
- When you change a shared value, check every screen that uses it.

## Layout
- Use one spacing scale (4 or 8 units). Align to a grid.
- Group related items. Add space between groups, not lines.
- Limit to 2 type sizes per area and 1 accent color. Use color to show state, not to decorate.
- Touch targets: 48 dp or more. Click targets: 32 px or more.

## States
- Build every state: default, hover, pressed, focus, disabled, loading, empty, error.
- Show progress for any action over 300 ms.
- An error says what failed and what to do. Never show a raw code alone.
- Disable or hide an action that cannot work. Say why.

## Access
- Text contrast 4.5:1 or more. Do not use color as the only signal.
- Support keyboard focus and a visible focus ring.
- Every icon button has a text label or tooltip.
- Respect system dark mode, font scale, and reduced motion.

## Motion
- Every state change and screen change gets a transition. A snap is a bug.
- Durations: press 100 ms, small change 150-200 ms, panel or screen 250-300 ms. Exit is shorter than enter.
- Easing: ease-out for enter, ease-in for exit. Never linear except for spinners.
- Move or fade only what changed. Keep one motion style across the app. Reuse existing duration and easing values.
- Respect reduced motion.

## Words
- Use verbs on buttons: "Save", not "OK". Keep labels short.
- One name for one thing, across the whole app.

## Check
Run the UI. Look at it at the smallest and largest size. Report what you saw, not what you intended.

To check motion, record the screen and read the frames:
1. Record 3-5 s. Android: `adb shell screenrecord --time-limit 5 /sdcard/a.mp4`, then `adb pull`. Desktop: `ffmpeg -f x11grab -t 5 -i :0 a.mp4`.
2. Run `bash ~/.claude/skills/ui-ux/frames.sh a.mp4 20`. Read the sheet.
3. Check for jumps, flicker, wrong direction, and a wrong duration. Fix, then record again.

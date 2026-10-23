---
name: audit-ui
description: Deep UI/UX audit of screenshots, recordings, or a running app against the ui-ux rules. Run only when the user types /audit-ui.
disable-model-invocation: true
---

# Audit UI

Check the real UI against the `ui-ux` rules. Report findings. Propose fixes. Do not edit any file until the user approves a fix.

## Input

- Use the argument as the target: an image path, a video path, a URL, or a screen name.
- With no argument, ask with AskUserQuestion what to audit. Offer: "Screenshots I give you", "A URL", "The app on a device or emulator".
- Read `ui-ux/SKILL.md` and `ui-ux/references/hig.md` first. They hold the rules and values.
- Read `capture.md` in this folder for how to capture screens, recordings and states.
- Do not judge a screen you have not seen. Read every image with the Read tool.
- Capture each screen in the matrix below. List the cells you could not capture.

## Matrix

Capture every screen in these cells. Skip a cell only when the platform lacks it.

- Appearance: light, dark, Increase Contrast.
- Text size: default and 200 percent.
- Window: smallest and largest size. On a phone, portrait and landscape.
- Content: normal, empty, one item, very long text, many items, missing image, error, loading.
- Screen edges: notch or cutout, home indicator, keyboard open over an input.

## Measure

Use `measure.py` in this folder. Measure from pixels. Do not guess by eye.

- `text` and `contrast`: contrast ratio of text, icons and borders.
- `target`: size of each control in pt or dp.
- `corners`: square background behind a rounded shape.
- `sharp`: edge strength of an image or icon. Compare it with a sibling.
- `flash`: change runs in a recording. A short still gap between two changes is a refresh flash candidate. Read the frames to confirm.

## Interact

Look is not enough. Operate the UI and record what happens.

- Tap every control. Toggle every switch both ways. Drag every slider to both ends and the middle.
- Check the result of each action: state, value, feedback, and the time it took.
- Flag a dead tap, a wrong state, a slider that jumps, a thumb that ends off the track, and a state that does not persist.
- Check haptics and sound for toggles and errors. Feedback must not be the only signal.

## Checks

Check each rule of `ui-ux`. Zoom in on every control.

- Job: one main action per screen, and it is the most visible item.
- Consistency: spacing, type sizes, colors and radii match sibling screens. List each value you measure.
- Layout: one spacing scale, aligned grid, grouped items, at most 2 type sizes and 1 accent color per area. No cropped or overlapping text.
- Targets: 44 pt or 48 dp touch, 32 px click.
- States: default, hover, pressed, focus, disabled, loading, empty, error. List each state you saw and each one that is missing.
- Access: contrast, color is not the only signal, labels on icon buttons, focus ring, reading order, screen reader labels.
- Content: errors say what failed and what to do. No raw codes. No truncated text. Spelling, tone, one term for one thing.
- Rendering: zoom to 400 percent on every rounded shape. Look for a square or pixelated background behind a rounded button, row, card or chip. Look for blurry, low-resolution or stretched images and icons. Look for a hard edge, a halo, a clipped shadow or a seam.
- Icons: one style, one stroke weight, one size per role. Alignment to the label and sharpness on the pixel grid. Flag a mixed set, a missing icon and a wrong meaning.
- Controls: compare every switch, slider, checkbox and segmented control with its siblings. Size, thumb, track, state colors and thumb position in each state.
- Transition flash: split each screen change into frames. Flag a frame where the content refreshes, redraws or jumps, and then the animation starts. The screen must render its final content first, then animate once.
- Animation conflict: flag two animations on one change, for example a system transition and a custom one. Flag a different duration or easing for the same role.
- Performance: dropped frames, slow first paint, scroll jank. Slow rendering often causes the refresh flash.
- Anything else that looks inconsistent or odd. Do not limit the audit to this list.

## Baseline

- Look for `.audit-ui-baseline.md` in the repo root. It lists known findings the user accepted.
- Do not report a finding that is in the baseline. Report it as "known" in the count only.
- When the user accepts findings, offer to add them to the baseline: one line each, `screen - problem`.

## Report

- One finding per line: `screen` - problem - severity (high, medium, low).
- Give evidence for each finding: a cropped image or a frame number, and the measured value, for example `contrast 2.4:1, needs 4.5:1`.
- Severity: high = a user cannot finish the task or cannot read or operate a control. Medium = a visible flaw or an inconsistency users notice. Low = a small polish issue.
- Sort by severity, high first.
- After each finding, give one proposed fix with the exact value.
- Mark each fix as safe or risky.
- List the matrix cells you could not capture.
- End with a count per severity. If you find nothing, say so.

## After the report

- Ask which fixes to apply.
- Apply only the fixes the user approves.
- Then capture the same screens again and measure again. Report which findings are fixed and which remain.

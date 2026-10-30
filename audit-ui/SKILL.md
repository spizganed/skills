---
name: audit-ui
description: Audit a UI against the ui-ux rules from screenshots or a running app. Quick by default, full on request. Run only when the user types /audit-ui.
disable-model-invocation: true
---

# Audit UI

Find real UI flaws. Report them with evidence. Edit nothing until the user approves a fix.

## Input
- The argument is a screen name, image path, URL or app. Add `full` for the full matrix. With no argument, ask what to audit.
- Read the `ui-ux` skill first.
- Judge only what you saw. Read each image once.

## Capture
Quick (default): at most 6 images of one screen.
1. Default state, light.
2. Dark.
3. Text at 200 percent.
4. Empty state.
5. Error or very long text.
6. Keyboard open, if the screen has an input.

Full: add the smallest and largest window, landscape, loading, many items, missing image, and Increase Contrast.

Name each cell you could not capture.

## Tools
Use the cheap checks first. Images cost the most.
- Android with litterboxADB: `pp audit` lists targets under 48 dp and controls without a label. `pp states` makes one contact sheet of the states. `pp compare a.png b.png` shows only what changed.
- Other platforms: use the accessibility tree or the browser dev tools. Zoom into an image only to confirm a finding.

## Check
- Job: one main action, the most visible item.
- Consistency: spacing, type, colors and radii match sibling screens. Name the value you measured.
- Targets, contrast, labels, color-only signals, text that crops at 200 percent.
- States: name each one you saw and each one that is missing.
- Rendering: a square background behind a rounded shape, a blurry or stretched icon, a seam or halo.
- Motion: a screen that refreshes before it animates, two animations on one change.
- Words: raw error codes, truncated text, two names for one thing.

## Baseline
Look for `.audit-ui-baseline.md` in the repo root. It lists accepted findings, one per line: `screen - problem`. Count them as "known". Do not report them. Offer to add newly accepted findings.

## Report
One line per finding, high severity first: `screen - problem - severity - evidence - fix`.
- Evidence: a measured value (`contrast 2.4:1, needs 4.5:1`) or a cropped image.
- Severity: high = a user cannot finish the task or operate a control. Medium = a flaw users notice. Low = polish.
- Fix: the exact value, marked safe or risky.
End with a count per severity and the cells you skipped. If you find nothing, say so.

Then ask which fixes to apply. Apply only those. Capture the same cells again and report what is fixed.

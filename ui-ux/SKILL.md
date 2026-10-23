---
name: ui-ux
description: If you start work on UI/UX (screen, layout, animation, interaction), load this skill first. Never load it for other work.
---

# UI/UX

## Before you build
- Name the one job of the screen. Put that action first and make it the most visible.
- Reuse existing components, tokens, and patterns. Read them first. Do not add a style that has no match in the app.
- Base the design on the Apple Human Interface Guidelines (developer.apple.com/design/human-interface-guidelines). Where the platform differs, follow the platform: Material on Android, native feel on desktop (egui in QuickBuds). Do not copy a web pattern.
- Read the HIG page for the component you build. Use its names and behavior. Exact values are in `references/hig.md`.

## Consistency
- Before you add a screen, read 2 sibling screens. List their paddings, type sizes, colors, radii, and components.
- Copy those values. Do not invent new ones. If a new value is needed, add it to the shared tokens first.
- When you change a shared value, check every screen that uses it.

## Layout
- Put the most important item near the top and leading side. Use progressive disclosure: hide secondary choices in menus or nested views.
- Align related items. Indent to show that an item belongs to the item above.
- Respect safe areas and system margins. Keep functionality the same at every window size.
- Use one spacing scale (4 or 8 units). Align to a grid.
- Group related items. Add space between groups, not lines.
- Limit to 2 type sizes per area and 1 accent color. Use color to show state, not to decorate.
- Touch targets: 44 pt (iOS) or 48 dp (Android) or more. Click targets: 32 px or more.
- Show the main action with a prominent style. Distinguish choices by style, not by size.

## States
- Build every state: default, hover, pressed, focus, disabled, loading, empty, error.
- Show progress for any action over 300 ms.
- Give every custom button a press state.
- An error says what failed and what to do. Never show a raw code alone.
- Disable or hide an action that cannot work. Say why.

## Rendering
- Clip a rounded shape with its own radius, so no square background shows behind it.
- Use vector icons or assets at 2x and 3x. Never stretch a low-resolution image.
- Use one icon style and one stroke weight.

## Access
- Text contrast 4.5:1 for text up to 17 pt, 3:1 for larger text and icons. Check light and dark. Do not use color as the only signal: add a shape, icon or label.
- Support text enlargement of 200 percent. Stack adjacent views and grow rows so text does not crop.
- Keep text at 11 pt or more on iOS (default 17 pt). Use system text styles.
- Support keyboard focus and a visible focus ring.
- Every icon button has a text label or tooltip.
- Respect system dark mode, font scale, and reduced motion.

## Motion
- Define each animation once, as a shared value or helper: duration, easing, and effect. Name it by role: press, toggle, screen enter, screen exit, list item, dialog.
- Before you animate, search the app for that role. Reuse the shared animation. Do not write a new one.
- Same kind of control, same animation, on every screen. All buttons press alike. All screen changes slide alike.
- On a screen change, load and lay out the final content first. Then run one animation. Do not let the screen redraw or refresh while the animation runs, and do not stack two transitions on one change.
- Add motion for a purpose. Do not use motion as the only signal: pair it with text or haptics. Make it follow the gesture. Reduce Motion replaces slides with fades.
- Add a new animation only when no role fits. Add it to the shared set, then use it.
- When you change a shared animation, check every screen that uses it.
- Every state change and screen change has a transition. A snap is a bug.
- Defaults if the app has none: press 100 ms, small change 150-200 ms, screen 250-300 ms. Use ease-out for entering motion. Use ease-in for exiting motion. Exit is shorter than enter.

## Words
- Use verbs on buttons: "Save", not "OK". Keep labels short.
- One name for one thing, across the whole app.

## Check
Run the UI. Look at it at the smallest and largest size. Report what you saw, not what you intended.

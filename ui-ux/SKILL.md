---
name: ui-ux
description: Use when you write or change UI code or look: screens, layouts, Jetpack Compose or XML views, themes, colors, type, spacing, icons, animations, dialogs, or any request about how an app looks or feels. Android first, also web and desktop.
---

# UI/UX

Follow the platform: Material 3 on Android, the native style on iOS and desktop. Do not copy a web pattern into an app. Values are in `references/platforms.md`.

## Before you build
- Name the one job of the screen. Make that action the most visible item.
- Find the shared tokens (theme, colors, type, spacing, shapes, motion) and the shared components. Read them first.
- Read 2 sibling screens. Copy their spacing, type, colors, radii and components.
- If a value is missing, add it to the shared tokens first. Then use it. Do not write a literal color, size or duration in a screen.
- When you change a shared value, check every screen that uses it.

## Layout
- Put the main item at the top and leading side. Hide secondary choices in menus or nested views.
- Use one spacing scale (4 dp steps). Group related items with space, not lines.
- Use at most 2 type sizes per area and 1 accent color. Color shows state, not decoration.
- Respect safe areas, the keyboard and system bars. Keep the same functions at every window size.
- Touch target: 48 dp or more. Pointer target: 32 px or more.

## States
- Build all states: default, pressed, focus, disabled, loading, empty, error.
- Show progress for any action over 300 ms.
- An error says what failed and what to do. Never show a raw code alone.
- Disable or hide an action that cannot work. Say why.

## Access
- Contrast 4.5:1 for text, 3:1 for large text, icons and borders. Check light and dark.
- Color is never the only signal: add an icon, shape or label.
- Every icon button has a label or content description.
- Text grows to 200 percent without cropping. Use sp units and let rows grow.
- Respect dark mode, font scale and reduced motion.

## Motion
- Define each animation once, by role: press, toggle, screen enter, screen exit, list item, dialog. Search for the role and reuse it.
- On a screen change, lay out the final content first. Then run one animation. Do not refresh during it. Do not stack two transitions.
- Every state change has a transition. A snap is a bug.
- Do not use motion as the only signal. Reduce Motion replaces slides with fades.

## Rendering and words
- Clip a rounded shape with its own radius. No square background behind it.
- Use vector icons in one style. Never stretch a low-resolution image.
- Use a verb on a button: "Save", not "OK". One name for one thing.

## Check
Run the UI at the smallest and largest size. Report what you saw, not what you intended. For a full audit, the user types `/audit-ui`.

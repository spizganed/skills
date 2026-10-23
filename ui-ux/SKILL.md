---
name: ui-ux
description: Use only when you design, build, or change a user interface, screen, layout, or interaction. Skip for logic, backend, and build work.
---

# UI/UX

## Before you build
- Name the one job of the screen. Put that action first and make it the most visible.
- Reuse existing components, tokens, and patterns. Read them first. Do not add a style that has no match in the app.
- Follow the platform: Material on Android, native feel on desktop. Do not copy a web pattern.

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

## Words
- Use verbs on buttons: "Save", not "OK". Keep labels short.
- One name for one thing, across the whole app.

## Check
Run the UI. Look at it at the smallest and largest size. Report what you saw, not what you intended.

# Platform values

Open the official page of the component you build for more detail.

## Android (Material 3)

Source: m3.material.io, developer.android.com/design.

- Touch target: 48 x 48 dp. Space between targets: 8 dp or more.
- Text: use `sp`. Body 14-16 sp. Do not go under 12 sp. Support 200 percent font scale.
- Spacing scale: 4, 8, 12, 16, 24, 32, 48 dp. Screen edge padding 16 dp on a phone.
- Window size classes: compact under 600 dp, medium 600-839 dp, expanded 840 dp or more. Change the layout, not the features.
- Shape scale: extra small 4, small 8, medium 12, large 16, extra large 28 dp.
- Color: use roles (`primary`, `onPrimary`, `surface`, `onSurface`, `error`) from one color scheme. Give the app a light and a dark scheme. Offer dynamic color on Android 12 and up.
- Elevation: use tonal surface colors (`surfaceContainer*`) before shadows.
- Motion: short changes 100-200 ms, screen changes 250-400 ms. Enter slower than exit. Use ease-out to enter and ease-in to exit.
- System: edge-to-edge with insets, predictive back, a visible focus ring for keyboard users.

## iOS (HIG)

Source: developer.apple.com/design/human-interface-guidelines.

- Touch target: 44 x 44 pt. Default text 17 pt, minimum 11 pt. Use system text styles.
- Prefer system colors: they adapt to dark mode and Increase Contrast.
- Safe areas and layout margins: respect them at every size.

## Desktop and web

- Pointer target: 32 px or more. Show a visible focus ring. Support the keyboard for every action.
- Web: layouts reflow at 320 px wide and at 200 percent zoom.

## Contrast (WCAG AA)

- Text under 18 pt (or 14 pt bold): 4.5:1.
- Large text, icons, control borders: 3:1.

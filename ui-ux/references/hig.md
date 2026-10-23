# Apple HIG values

Source: developer.apple.com/design/human-interface-guidelines (Accessibility, Layout, Motion, Buttons). Open the page of the component you build for more detail.

## Text size (default / minimum, pt)

| Platform | Default | Minimum |
|---|---|---|
| iOS, iPadOS | 17 | 11 |
| macOS | 13 | 10 |
| tvOS | 29 | 23 |
| visionOS | 17 | 12 |
| watchOS | 16 | 12 |

- Support text enlargement of at least 200 percent (140 percent on watchOS).
- Use system text styles. Custom type follows the defaults above.

## Control size (default / minimum, pt)

| Platform | Default | Minimum |
|---|---|---|
| iOS, iPadOS | 44 x 44 | 28 x 28 |
| macOS | 28 x 28 | 20 x 20 |
| visionOS | 60 x 60 | 28 x 28 |
| tvOS | 66 x 66 | 56 x 56 |
| watchOS | 44 x 44 | 28 x 28 |

- A button has a hit region of 44 x 44 pt or more. On visionOS, 60 x 60 pt.
- Give a button enough space around it to tell it from other controls.
- Android: 48 dp.

## Contrast (WCAG AA)

- Text up to 17 pt: 4.5:1.
- Text of 18 pt: 3:1. Bold text: 3:1.
- Icons and control borders: 3:1.
- Check light and dark. Offer a higher contrast scheme when the base colors fail.

## Rules

- Convey information with more than color: a shape, an icon or a label.
- Prefer system colors. They adapt to dark mode and Increase Contrast.
- Pair audio cues with haptics and visual cues.
- Layout: most important content at the top and leading side. Use progressive disclosure. Align related items, indent subordinate ones.
- Respect safe areas, margins and layout guides. Keep functionality the same at every window size. Show more or less, not different features.
- Under larger text, stack adjacent views and grow rows so text does not crop.
- Buttons: use a prominent style for the most likely action. Use style, not size, to mark the preferred choice. Give every custom button a press state.
- Motion: add it with a purpose. Make it optional: never the only signal. Make it follow the gesture. Reverse the path to dismiss. Respect Reduce Motion.
- tvOS safe area: 60 pt top and bottom, 80 pt on the sides.

# Example: /audit-ui report

Screen: "Noise cancel", left side of the mockup. Image: [audit-ui-annotated.png](audit-ui-annotated.png).
Matrix: dark, default text size, one window size. Not captured: light, 200 percent text, empty, error, landscape.

| # | Screen | Problem | Severity | Fix | Fix risk |
|---|---|---|---|---|---|
| 1 | Noise cancel, mode buttons | Targets 31 x 21 pt and 49 x 21 pt. Needs 44 pt or more. Five accent colors for one set of choices. | high | Make each option a 56 pt row with a switch. Use one accent color. | risky |
| 2 | Noise cancel, error line | `Err 0x1F` is a raw code. Text contrast 2.36:1, needs 4.5:1. 11 px text is at the iOS minimum. | high | Write "Buds not connected. Open the case and tap Retry." in 14 pt. Use `#ff8a8a` (7.59:1). | safe |
| 3 | Noise cancel, title | Title uses the error red. Red means error in this app. | medium | Use the primary text color. | safe |

Count: 2 high, 1 medium, 0 low.

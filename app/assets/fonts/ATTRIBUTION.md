# Font credits

The Flutter app ships no custom fonts (Material default Roboto). These are
the DNP design system's typeface choices — bundled as static, offline
assets so the app has no runtime dependency on Google Fonts' CDN.

| Family | Weights used | License | Source |
|---|---|---|---|
| Archivo | 400, 500, 600, 700 | SIL Open Font License 1.1 | https://fonts.google.com/specimen/Archivo |
| Instrument Sans | 400, 500, 600 | SIL Open Font License 1.1 | https://fonts.google.com/specimen/Instrument+Sans |
| JetBrains Mono | 400, 500 | SIL Open Font License 1.1 | https://fonts.google.com/specimen/JetBrains+Mono |

Each family ships upstream as a variable font (weight axis). The `.ttf`
files here are static instances pinned at the weights above (via
`fonttools varLib.instancer`), so no variable-font support is required at
runtime and each file only carries the one weight it's named for.

Full OFL 1.1 license text: https://openfontlicense.org

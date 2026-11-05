## 2.2.0

- Migrate to [material_ui](https://pub.dev/packages/material_ui) package
- Bump [censor_it](https://pub.dev/packages/censor_it) to ^2.2.0
- Require Dart 3.13+ / Flutter 3.47+
- Add `build/**` to analyzer excludes

## 2.1.2

- Add [pavluke_lints](https://pub.dev/packages/pavluke_lints)
- Bump [censor_it](https://pub.dev/packages/censor_it) to ^2.1.2

## 2.1.1

- Downgrade min requirement Dart SDK to 3.6.0
- Bump [censor_it](https://pub.dev/packages/censor_it) to ^2.1.1

## 2.0.0

### Breaking Changes

- Removed direct constructor - use factory constructors instead
- `CensorPattern` renamed to `LanguagePattern`
- Removed `chars` parameter
- Removed `censoredWordBuilder` - replaced with strategy-specific builders

### New Features

- Three censoring strategies: `textBuilder`, `widgetBuilder`, `overlayBuilder`
- `censoredStyle` parameter for styling censored text
- `onTap` callback for interactive reveal in overlay builder
- Widget alignment control with `PlaceholderAlignment` and `TextBaseline`

## 1.0.3

- Update README.md

## 1.0.2

- Update README.md
- Update LICENSE

## 1.0.1

- Update README.md.

## 1.0.0

- Initial release.

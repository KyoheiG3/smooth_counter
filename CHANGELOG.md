## 1.0.0

### Breaking Changes

- **BREAKING**: Removed `hasSeparator` parameter. Use `format` or `formatString` parameters instead for more flexible number formatting control.

  Migration guide:
  ```dart
  // Before
  SmoothCounter(count: 1234, hasSeparator: false)

  // After
  SmoothCounter(count: 1234, formatString: '0')
  ```

### Features

- **feat**: Added `format` parameter to accept `NumberFormat` instances for custom number formatting
- **feat**: Added `formatString` parameter to specify number format patterns (e.g., `'#,##0.00'`, `'0'`)
- **feat**: Support both `int` and `double` types for the `count` parameter

### Improvements

- **refactor**: Replaced internal `Formatter` class with direct `NumberFormat` integration from `intl` package
- **refactor**: Removed unnecessary library declaration

### Documentation

- **docs**: Updated README with comprehensive number formatting examples
- **docs**: Added documentation for `format` parameter in `SmoothCounter` and `SmoothCounterRow`
- **docs**: Updated requirements to Dart 3.8.0+ and Flutter 3.32.0+
- **docs**: Added prefix/suffix feature documentation
- **docs**: Changed examples to use `double` type to demonstrate decimal support

## 0.3.0

### Dependencies

- **deps**: Updated Dart SDK constraint to `^3.8.0`
- **deps**: Updated Flutter SDK minimum version to `>=3.32.0`
- **deps**: Updated `intl` package from `^0.19.0` to `^0.20.0`
- **deps**: Updated `flutter_lints` from `^2.0.2` to `^6.0.0`

### Infrastructure

- **ci**: Updated iOS deployment target from 11.0 to 12.0
- **ci**: Updated Xcode project settings to Xcode 15.1.0
- **ci**: Updated Swift's `@UIApplicationMain` to `@main` annotation
- **ci**: Added `.build/` and `.swiftpm/` to `.gitignore` for Swift Package Manager support
- **ci**: Added custom LLDB init file configuration for better debugging support
- **ci**: Enabled GPU validation mode in debug scheme

## 0.2.0

- **CHORE**: Upgrade intl package to 0.19.0.

## 0.1.0

- **FEAT**: Add prefix and suffix ([#1](https://github.com/KyoheiG3/smooth_counter/pull/1))

## 0.0.1+1

- **CHORE**: Fix README images.

## 0.0.1

- Initial release.

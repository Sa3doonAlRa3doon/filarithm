# Contributing

Thank you for improving Filarithm. Keep changes offline-first and add regression fixtures for every new slicer metadata variant.

Before opening a pull request, run:

```bash
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
```

Never commit customer files, signing keys, printer addresses, or unredacted G-code. Parser fixtures must be generated or anonymized and small enough for source control.

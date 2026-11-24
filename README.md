# Filarithm by AVEONEX

Filarithm is an offline-first 3D-print pricing, inventory, quoting, OCR, and model-inspection app for Android and Ubuntu. It turns slicer output into a defensible AED selling price without sending workshop or customer data to a server.

Architecture and user journeys: [Filarithm — Architecture & User Flows](https://www.tldraw.com/f/LYFP9xgRyESMRUKMgwul1)

## What works

- Android camera/image OCR with the bundled Google ML Kit Latin model.
- Ubuntu image OCR through local `tesseract-ocr` with grayscale and contrast normalization.
- Bounded `.gcode`, `.3mf`, and `.gcode.3mf` parsing for Creality Print, OrcaSlicer, Bambu Studio, PrusaSlicer, and Cura metadata.
- Multi-plate time and multi-tool material estimates, Cura length-to-weight conversion, and explicit partial-format warnings.
- Integer-only money, mass, duration, percentage, VAT, marketplace fee, minimum-order, and target-margin calculations.
- Unlimited material colours, physical spools, FIFO split allocation, jobs, quotes, and immutable JSON snapshots in local SQLite.
- Arabic/English RTL UI and bilingual PDF quotations with embedded IBM Plex Arabic fonts and HarfBuzz shaping.
- PDF and WhatsApp-style share-sheet workflow, schema-versioned SHA-256 backup/restore, and CSV export.
- User-triggered signed updates from GitHub Releases: exact-ABI APK selection on Android, exact-Ubuntu `.deb` selection, SHA-256 verification, Android package/signing-certificate/version verification, and data-preserving system installation.
- Interactive 3D workspace for STL, OBJ, 3MF, GLTF, GLB, and STEP control-point previews, including component selection, move/rotate/scale, axis controls, snapping, locking, reset, duplicate/delete, view presets, scene save, and undo/redo.
- Android ARCore surface placement with generated offline GLB models, tap-to-place at real millimetre scale, drag/twist/pinch controls, placement locking, and reset.
- Phone-headset stereo VR with gyroscope head tracking, configurable eye separation/FOV/distance, touch rotation and scaling, and object locking. External motion controllers are intentionally reported as unavailable in phone-headset mode.

## Privacy

Filarithm has no account, cloud backend, analytics, advertising, or telemetry. Camera captures created by the scanner are deleted after OCR. Ubuntu OCR normalization files are created only in the system temporary directory and deleted immediately. The app contacts the public GitHub Releases API only after the user taps **Check for updates**; update checks never upload workshop or customer data.

## Data-preserving updates

Settings → **App updates** checks the public `Sa3doonAlRa3doon/filarithm` GitHub release. Filarithm selects the device ABI or Ubuntu version, requires a published SHA-256 digest, downloads to a temporary/private location, and verifies the file before handing it to the operating-system installer.

On Android, the native bridge additionally rejects an APK unless its package ID is `ae.aveonex.filarithm`, its signing certificate exactly matches the installed app, and its version code is newer. Android may ask the user once to allow installs from Filarithm. Installing the verified upgrade keeps the app-private Drift/SQLite database. No second Android app, local service, PC, or companion server is required.

On Ubuntu, the selected `.deb` is opened in the desktop package installer. Package upgrades do not remove the per-user database under the user data directory. A verified JSON backup remains recommended before any operating-system migration.

## Build

Flutter 3.50.1 or newer, Dart 3.14, JDK 21 for Android builds, and Android SDK 37 are recommended. The Android bytecode target remains Java 17.

```bash
flutter pub get
dart run build_runner build
flutter test
flutter build apk --release
flutter build appbundle --release
flutter build linux --release
```

Android release signing reads `android/key.properties`; if it is absent, local release builds use the Android debug key for development only. Tagged GitHub releases require the signing secrets documented in the workflow. The release workflow derives `versionName` from the Git tag, assigns a monotonically increasing workflow run number as `versionCode`, and publishes `SHA256SUMS.txt` beside the APK/AAB artifacts so the in-app updater can reject unverified files.

AR requires an ARCore-capable Android device. VR requires a gyroscope-equipped Android phone and a phone headset. Both features expose an explicit unsupported-device result rather than presenting a simulated success state.

Ubuntu runtime OCR requires:

```bash
sudo apt install tesseract-ocr tesseract-ocr-eng
```

Create `.deb` and `.tar.gz` artifacts after the Linux build:

```bash
./scripts/package_linux.sh 1.0.0
```

The packaging script runs Debian `dpkg-shlibdeps` against the compiled Flutter binary and adds `tesseract-ocr` and `tesseract-ocr-eng` explicitly.

## Precision model

- currency: micros (`1 AED = 1,000,000`)
- mass: milligrams
- time: seconds
- percentages: basis points (`100% = 10,000`)

The protected pre-tax price is:

```text
(total cost + fixed platform fee) / (1 - platform fee % - target margin %)
```

UAE VAT is applied after the optional minimum-order floor. VAT and the minimum-order floor are both disabled until the user explicitly enables and configures them.

## License

MIT. IBM Plex fonts retain their bundled SIL Open Font License in `assets/fonts/LICENSE-IBM-PLEX.txt`.

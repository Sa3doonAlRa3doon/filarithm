#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-1.0.0}"
ARCH="amd64"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUNDLE_DIR="$ROOT_DIR/build/linux/x64/release/bundle"
OUTPUT_DIR="$ROOT_DIR/dist"
PACKAGE_ROOT="$OUTPUT_DIR/deb-root"
DPKG_WORK="$OUTPUT_DIR/dpkg-work"

if [[ ! -x "$BUNDLE_DIR/filarithm" ]]; then
  echo "Linux release bundle not found. Run: flutter build linux --release" >&2
  exit 1
fi

rm -rf "$PACKAGE_ROOT" "$DPKG_WORK"
mkdir -p "$PACKAGE_ROOT/DEBIAN" "$PACKAGE_ROOT/opt/filarithm" "$PACKAGE_ROOT/usr/bin" "$PACKAGE_ROOT/usr/share/applications" "$OUTPUT_DIR" "$DPKG_WORK/debian"
cp -a "$BUNDLE_DIR/." "$PACKAGE_ROOT/opt/filarithm/"
ln -s /opt/filarithm/filarithm "$PACKAGE_ROOT/usr/bin/filarithm"

cat > "$PACKAGE_ROOT/usr/share/applications/ae.aveonex.filarithm.desktop" <<'DESKTOP'
[Desktop Entry]
Name=Filarithm
Comment=Offline 3D print pricing and quoting by AVEONEX
Exec=/opt/filarithm/filarithm
Icon=applications-engineering
Terminal=false
Type=Application
Categories=Graphics;Engineering;Office;
MimeType=application/octet-stream;
DESKTOP

cat > "$DPKG_WORK/debian/control" <<'SOURCE_CONTROL'
Source: filarithm
Section: graphics
Priority: optional
Maintainer: AVEONEX <support@aveonex.ae>
Standards-Version: 4.6.2

Package: filarithm
Architecture: any
Description: Offline 3D print pricing
SOURCE_CONTROL

SHLIBS="$(cd "$DPKG_WORK" && dpkg-shlibdeps -O -e"$PACKAGE_ROOT/opt/filarithm/filarithm" -l"$PACKAGE_ROOT/opt/filarithm/lib" 2>/dev/null | sed -n 's/^shlibs:Depends=//p')"
DEPENDS="${SHLIBS:+$SHLIBS, }tesseract-ocr, tesseract-ocr-eng"

cat > "$PACKAGE_ROOT/DEBIAN/control" <<CONTROL
Package: filarithm
Version: $VERSION
Section: graphics
Priority: optional
Architecture: $ARCH
Maintainer: AVEONEX <support@aveonex.ae>
Depends: $DEPENDS
Description: Offline 3D print pricing, inventory, OCR and quotations
 Filarithm imports slicer statistics, prices jobs in AED, tracks filament,
 and creates bilingual customer quotations without a cloud account.
CONTROL

chmod 0755 "$PACKAGE_ROOT/DEBIAN" "$PACKAGE_ROOT/usr/bin" "$PACKAGE_ROOT/opt/filarithm/filarithm"
dpkg-deb --build --root-owner-group "$PACKAGE_ROOT" "$OUTPUT_DIR/filarithm_${VERSION}_${ARCH}.deb"
tar -C "$BUNDLE_DIR" -czf "$OUTPUT_DIR/filarithm_${VERSION}_linux_${ARCH}.tar.gz" .
rm -rf "$PACKAGE_ROOT" "$DPKG_WORK"

echo "Created $OUTPUT_DIR/filarithm_${VERSION}_${ARCH}.deb"
echo "Created $OUTPUT_DIR/filarithm_${VERSION}_linux_${ARCH}.tar.gz"

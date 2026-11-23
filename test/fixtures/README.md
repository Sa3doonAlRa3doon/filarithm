# Slicer fixtures

Fixtures in this directory preserve the metadata produced by a real slicer
export while removing customer data, local paths, UUIDs, printer identifiers,
dates, object names, geometry, and toolpaths. Each fixture has a deterministic
expected JSON result and is parsed from disk in CI.

The Creality Print fixture was derived from a locally generated 7.3 export.
The OrcaSlicer fixture was derived from a locally generated 2.4.1 CLI export
using a 20 mm calibration cube and a Creality Ender-3 V3 KE profile.
Equivalent permission-cleared exports for Bambu Studio, PrusaSlicer, and Cura
remain tracked in GitHub issue #1; inline unit samples do not claim to be real
exports.

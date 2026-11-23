# Slicer fixtures

Fixtures in this directory preserve the metadata produced by a real slicer
export while removing customer data, local paths, UUIDs, printer identifiers,
dates, object names, geometry, and toolpaths. Each fixture has a deterministic
expected JSON result and is parsed from disk in CI.

The Creality Print fixture was derived from a locally generated 7.3 export.
The OrcaSlicer fixture was derived from a locally generated 2.4.1 CLI export
using a 20 mm calibration cube and a Creality Ender-3 V3 KE profile.
The PrusaSlicer fixture is an anonymized metadata excerpt of the real
`resources/test_data/test_vase.gcode` export published by the official
PrusaSlicer repository at commit `e6c85c50dcc56f9968a61dfdd7a3b695e1004037`.
Equivalent permission-cleared exports for Bambu Studio and Cura remain tracked
in GitHub issue #1; inline unit samples do not claim to be real exports.

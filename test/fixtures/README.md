# Slicer fixtures

Fixtures in this directory preserve the metadata produced by a real slicer
export while removing customer data, local paths, UUIDs, printer identifiers,
dates, object names, geometry, and toolpaths. Each fixture has a deterministic
expected JSON result and is parsed from disk in CI.

The Creality Print fixture was derived from a locally generated 7.3 export.
The OrcaSlicer fixture was derived from a locally generated 2.4.1 CLI export
using a 20 mm calibration cube and a Creality Ender-3 V3 KE profile.
`orca/filarithm_cube_orcaslicer_2_4_1.gcode.3mf` is the complete, unmodified
OrcaSlicer 2.4.1 CLI output for the repository-owned calibration cube in
`source/filarithm_calibration_cube.stl`. It retains the real ZIP container,
model, project settings, slice statistics, and embedded plate G-code. Its
SHA-256 is
`D0086536D94BDDA4330ADA7FCB5BD00ACA44E5B2E8A7A13A5E2D0234A2738180`.
`orca/filarithm_multiplate_multicolor_purge_orcaslicer_2_4_1.gcode.3mf`
is another complete OrcaSlicer 2.4.1 CLI output made only from that cube. It
contains two plates; plate 2 assigns pink and black PLA to separate objects and
emits real material-switch flushing G-code. Orca reports consumed totals rather
than a model/purge split, so the expected normalization deliberately retains
those values as reported totals without inventing a split. Its SHA-256 is
`53417CD7A02FAE2DFF726347A0B832C3C79115763AB3AB1F387E79DCECB4F57A`.
The PrusaSlicer fixture is an anonymized metadata excerpt of the real
`resources/test_data/test_vase.gcode` export published by the official
PrusaSlicer repository at commit `e6c85c50dcc56f9968a61dfdd7a3b695e1004037`.
The Cura fixture is an anonymized metadata excerpt of a real Cura 5.3.1 export
published as `slicer scripts/cura/SimpleCuraTest.gcode` in the public
`mriscoc/Ender3V2S1` repository at commit
`05903a80d6e15cc91b0bc690b35e08fd440a21e9`.
The Bambu Studio fixture is an anonymized metadata excerpt of the real
`runtime/uploads_8080/Cube.gcode` export in the MIT-licensed public
`JohnMO2/BambuToElegooService` repository at commit
`91b45fb67f28f0b06d374ce4c95749c6c9e2869e`.

Together these fixtures provide real-export coverage for all five required
slicer families. Inline samples cover focused edge cases but do not replace
these provenance-backed files.

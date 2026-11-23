# Slicer fixtures

Fixtures in this directory preserve the metadata produced by a real slicer
export while removing customer data, local paths, UUIDs, printer identifiers,
dates, object names, geometry, and toolpaths. Each fixture has a deterministic
expected JSON result and is parsed from disk in CI.

The Creality Print fixture was derived from a locally generated 7.3 export.
Equivalent permission-cleared exports for OrcaSlicer, Bambu Studio,
PrusaSlicer, and Cura remain tracked in GitHub issue #1; inline unit samples do
not claim to be real exports.

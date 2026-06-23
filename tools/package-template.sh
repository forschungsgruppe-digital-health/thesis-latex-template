#!/usr/bin/env bash
# Assemble the FLATTENED, Overleaf-ready template project from the repo sources.
#
# In the repo, the fgdh-thesis class lives under latex/ and the DIN 1505 .bst under
# bst/, so the per-folder template/latexmkrc puts them on the search path with a
# recursive parent search (TEXINPUTS='..//:'). That is correct for in-repo builds, but
# MUST NOT ship in the distributed ZIP: when the project's parent directory is a large
# tree (as on Overleaf), the recursive '..//' search makes kpathsea scan an enormous
# filesystem on every file lookup and the compile never finishes.
#
# The distributed project is therefore FLAT — class, styles, and .bst sit beside
# thesis.tex — so no search-path setup is needed at all. This script produces that
# layout and replaces the latexmkrc with a minimal pdfLaTeX-only one.
#
# Used by both .github/workflows/release-please.yml (to build template.zip) and
# .github/workflows/ci.yml (to verify the flat project compiles standalone).
#
# Usage: tools/package-template.sh <output-dir>
set -euo pipefail

out="${1:?usage: package-template.sh <output-dir>}"
root="$(cd "$(dirname "$0")/.." && pwd)"

mkdir -p "$out"

# Starter sources (thesis.tex, references.bib, figures/, README.md, …).
cp -r "$root"/template/. "$out"/

# Drop build artifacts and the repo-relative latexmkrc (its recursive '..//' search
# path hangs compilers when the project parent is a large tree — see header).
rm -f "$out"/thesis.pdf "$out"/*.aux "$out"/*.log "$out"/*.fls "$out"/*.fdb_latexmk \
      "$out"/*.bbl "$out"/*.blg "$out"/*.toc "$out"/*.lof "$out"/*.lot \
      "$out"/*.out "$out"/*.synctex.gz "$out"/latexmkrc 2>/dev/null || true

# A flat project needs NO search-path setup; just select pdfLaTeX for local latexmk.
# (On Overleaf the engine is chosen in the project menu; this only affects local builds.)
cat > "$out"/latexmkrc <<'RC'
# Flattened template project: the fgdh-thesis class, its styles, and the DIN 1505
# .bst all sit beside thesis.tex, so no TeX search-path setup is needed. This file
# only selects pdfLaTeX for local `latexmk` runs (Overleaf uses its compiler menu).
$pdf_mode = 1;   # pdfLaTeX
RC

# The class, its deprecated wise.cls alias, the style files, and the DIN 1505 .bst.
cp "$root"/latex/fgdh-thesis/fgdh-thesis.cls "$root"/latex/fgdh-thesis/wise.cls \
   "$root"/latex/fgdh-thesis/*.sty "$out"/
cp "$root"/bst/*.bst "$out"/

# Licensing travels with the redistributed sources.
cp "$root"/LICENSE "$root"/THIRD-PARTY-NOTICES.md "$out"/ 2>/dev/null || true

echo "Assembled flattened template project in: $out"

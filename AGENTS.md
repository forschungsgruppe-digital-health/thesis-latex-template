# AGENTS.md

Build/release facts for automated agents (and humans) working on this repository.
Keep this file authoritative and up to date — agents should be able to build and release
from this file alone.

## What this is

A LaTeX **thesis template** built on the custom `fgdh-thesis` document class (formerly
`wise`; a deprecated `wise.cls` alias still loads it).
Engine: **pdfLaTeX**. Bibliography: **BibTeX + `natbib`** with custom DIN 1505 `.bst`
styles. Not biber/biblatex, not xelatex/lualatex.

## Build

There is no assumed local TeX install; build through Docker (this is also the CI image):

```bash
# Compile an example (latexmkrc handles the search path + engine + bibtex):
docker run --rm -v "$PWD":/work texlive/texlive:latest \
  latexmk -cd examples/de/thesis-de.tex
```

- Image: `texlive/texlive:latest` (full scheme; pin to the Overleaf/ZIH TeX Live year
  once known — see `docs/maintainer/decision-log.md`).
- Each buildable folder (`template/`, `examples/de`, `examples/en`) ships a `latexmkrc`
  that puts the bundled class (`latex/`) + DIN 1505 styles (`bst/`) on the search path and
  sets `$pdf_mode = 1`; the root [`latexmkrc`](latexmkrc) does the same for whole-repo builds.
- Render PDFs to PNG for visual checks with `gs` (poppler is **not** in the image).

## Definition of done for a build change

1. DE and EN examples compile to PDF — no `File 'fgdh-thesis.cls' not found`, no missing graphics.
2. Bibliography resolves: no undefined citations/references in the final pass.
3. For class/encoding edits: the rendered ToC + title page show correct, copy/paste-able
   umlauts (`Abkürzungsverzeichnis`, `Universität`, `Prüfungsordnung`).

## Source rules

- All `.tex/.cls/.sty/.bst/.bib` are **UTF-8, no BOM, LF** (enforced by `.editorconfig`).
  No `[latin1]/[latin9]/utf8x` `inputenc`.
- pdfLaTeX requires `\usepackage[T1]{fontenc}`. Do not add `fontspec` without switching
  the engine and documenting it.
- Do not strip headers from the bundled `.bst` files; rename on modification
  (see `THIRD-PARTY-NOTICES.md`). The `fgdh-thesis` class is LPPL 1.3c (record changes in the
  CHANGELOG and keep the work identifiable as modified).

## Conformance audit

The skill at `.claude/skills/overleaf-conformance/` audits the repo against the
custom-LaTeX-on-Overleaf checklist and regenerates
`docs/overleaf-conformance-report.md`. Run it after structural or class changes.

## Release (planned)

- SemVer tag `vX.Y.Z` → build PDFs + a **curated, flattened** `template.zip` (class beside
  the main `.tex`, no nested folders) attached to a GitHub Release; update `CHANGELOG.md`
  and `CITATION.cff` (`version`, `date-released`).

## Key references

- Plan: [`maintainer-setup-cot.md`](maintainer-setup-cot.md)
- Decisions: [`docs/maintainer/decision-log.md`](docs/maintainer/decision-log.md)
- Inventory: [`docs/maintainer/inventory.md`](docs/maintainer/inventory.md)
- Structure proposal: [`docs/maintainer/repo-structure.md`](docs/maintainer/repo-structure.md)

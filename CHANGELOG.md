# Changelog

All notable changes to this project are documented here.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
From the next release onward this file is **maintained automatically by Release Please**
from Conventional Commits — see [docs/maintainer/releasing.md](docs/maintainer/releasing.md).

## [Unreleased]

Modernization after the migration to the `forschungsgruppe-digital-health` organization
(still under the `wise` name; the rename to `fgdh-thesis` is a later, breaking release).

### Fixed

- **Encoding:** converted all sources to UTF-8, switched the class to `[utf8]{inputenc}`,
  and added `\usepackage[T1]{fontenc}`. The `Abkürzungsverzeichnis` heading no longer
  renders as mojibake, and umlauts/eszett now hyphenate and are copy/paste/searchable in
  the PDF (verified by text extraction + rendering).
- Removed committed build/editor cruft (`wise.log`, `.swn/.swo/.swp`).
- Fixed the malformed `\ProvidesClass` release date (`10/07/2012` → `2026/06/22`,
  `YYYY/MM/DD`) and gave it a SemVer version.

### Added

- Dual licensing: `LICENSE` overview, full `LICENSES/LPPL-1.3c.txt` (code) and
  `LICENSES/CC-BY-4.0.txt` (docs), and `THIRD-PARTY-NOTICES.md` for the bundled DIN 1505
  BibTeX styles.
- Community/health files: rewritten `README.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`
  (Contributor Covenant 2.1), `CITATION.cff`, this `CHANGELOG.md`, `AGENTS.md`,
  `.editorconfig`.
- Release automation: Release Please config + workflow, a `ci` build workflow, and a
  release-assets job that publishes a curated flattened `template.zip` + PDFs on each tag.
- `latexmkrc` search-path shim so the bundled class compiles from the project root
  (locally and on Overleaf) without moving files.
- `.devcontainer/` — a reproducible VS Code + full TeX Live local authoring environment.
- `docs/` — maintainer inventory, decision log, structure proposal, and release guide under
  `docs/maintainer/`; an Overleaf/CTAN **conformance report**; and a reusable
  `overleaf-conformance` skill that regenerates it.

### Known issues (tracked for upcoming releases)

- **Layout:** the custom class lives under `texmf/` (mitigated by `latexmkrc` + recursive
  `TEXINPUTS`); a flattened `template/` starter and `examples/` reorganization are planned.
- The EN title-page field order is scrambled and remains to be fixed.

## [1.x] — 2022 and earlier

- Original `wise`-based template (Malte Helmhold, 2012) with German/English example
  theses, maintained under `helict/fgdh-thesis-latex-template`; chair renamed to
  *Research Group Digital Health*. See the Git history for details.

[Unreleased]: https://github.com/forschungsgruppe-digital-health/thesis-latex-template/commits/main

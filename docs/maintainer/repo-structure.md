# Phase 0 (extended) — Repository structure: critique & restructuring proposal

> **Status (v2.0.0): EXECUTED.** The migration below has been carried out. The package
> was lifted out of `texmf/` to `latex/fgdh-thesis/` + `bst/`; `Dokumentation/` → `docs/manual/`
> and `Einfuehrung.pdf` → `docs/pdf/`; all file/dir names are kebab-case; and the package
> is named `fgdh-thesis` (not `wise`). The "Current layout" / "proposed layout" sections
> below are kept as the **historical record** of the design — the *proposed* layout (§4,
> adapted to `latex/fgdh-thesis/` and kebab-case) is now the actual one.
>
> A critical reflection on the original file layout and the prioritized plan that was
> followed. Companion to [inventory.md](inventory.md) and [decision-log.md](decision-log.md).

## 1. Current layout

```
thesis-latex-template/
├── README.md                      # 13 lines, links to PDFs only
├── Einfuehrung.pdf                # ~1 MB, in the clone path
├── .gitignore
├── Beispielarbeit/                # "example thesis" = de facto the template
│   ├── BeispielarbeitDE/          # Beispielarbeit.tex (+ .pdf, literatur.bib, bilder/)
│   └── BeispielarbeitEN/          # Example.tex (+ .pdf, test.bib, elsewhere.tex)
├── Dokumentation/                 # German PDFs + sources
│   ├── Vorlage/  Zitieren/  Titlepages (EN)/
└── texmf/                         # the custom package, hidden from Overleaf
    ├── tex/latex/wise/            # wise.cls, wise_diff.cls, wiseapp.sty,
    │                              #   wisetextDE.sty, wisetextEN.sty,
    │                              #   .swn .swo .swp (vim junk), wise.log (build log)
    └── bibtex/bst/wise/           # wisenat.bst, wisealpha.bst, wisenatnosc.bst
```

## 2. What's wrong with it (critique)

| # | Problem | Why it hurts | Severity |
|---|---|---|---|
| S1 | **Custom class buried in `texmf/`** | Overleaf does not search subfolders → "works on the author's machine, fails on upload" (the OVL-01 blocker). | **blocker** |
| S2 | **No separation of concerns** | `Beispielarbeit/` is simultaneously the example *and* the only starting point; the class, examples, and docs sit at the same level with no "this is what you copy" signal. | high |
| S3 | **No minimal `template/` starter** | New users must gut a full example instead of filling blanks (Phase 2.4). | high |
| S4 | **Heavy binaries in the clone path** | `Einfuehrung.pdf` (~1 MB) + every example/doc PDF bloat every clone and any ZIP built from the tree (Phase 4.4 / REPO-03). | medium |
| S5 | **Tracked build cruft** | `.swn/.swo/.swp`, `wise.log`, and the dev-only `wise_diff.cls` are committed (see inventory). | medium |
| S6 | **Inconsistent, German-only names** | `Beispielarbeit`, `Dokumentation`, `bilder` mix with English (`Example.tex`); the project wants bilingual, predictable names. | low |
| S7 | **No conventional repo files** | No `LICENSE`, `CONTRIBUTING`, `CHANGELOG`, `CITATION.cff`, `docs/`, `.github/`, `.devcontainer/` (REPO-01…09, DEV-01…03). | medium |
| S8 | **`texmf/` implies a TEXMF-tree install** | This layout only "works" if a user installs it into `TEXMFHOME`, which no student does; it encodes a maintenance model nobody follows. | medium |

## 3. The core tension — duplication vs. a single source of truth

Flattening the class next to every `.tex` (the simplest Overleaf layout) would create
**three copies** of `wise.cls` (template + DE example + EN example) to keep in sync.
Avoid that. Keep **one canonical copy** of the package in the repo and make the working
layout compile via a path shim, then **flatten only at packaging time** (CI builds the
distributed ZIPs). This gives both: a clean repo *and* zero-config student artifacts.

- In-repo working build: a root **`latexmkrc`** prepends recursive `TEXINPUTS`/`BSTINPUTS`
  (`./latex//:`, `./bst//:`) — the Overleaf-documented mechanism, verified locally.
- Distributed `template.zip` / example ZIPs: CI copies the canonical class beside the
  `.tex` so the uploaded project is flat and needs no shim.

## 4. Proposed target layout

```
thesis-latex-template/
├── README.md                      # value prop + Quickstart (Overleaf badge / ZIP / local)
├── LICENSE                        # dual-license overview → LICENSES/*
├── LICENSES/                      # LPPL-1.3c.txt, CC-BY-4.0.txt
├── THIRD-PARTY-NOTICES.md         # Lorenzen DIN 1505 .bst terms, etc.
├── CONTRIBUTING.md  CODE_OF_CONDUCT.md  CHANGELOG.md  CITATION.cff  AGENTS.md
├── latexmkrc                      # recursive TEXINPUTS/BSTINPUTS shim (Overleaf + local)
├── .editorconfig                  # UTF-8 + LF, enforced
├── .gitignore                     # GitHub TeX.gitignore based
├── .devcontainer/devcontainer.json
├── .github/workflows/             # ci.yml (build), release.yml (tag → ZIP+PDF)   [future]
├── latex/                         # ← the canonical package (was texmf/tex/latex/wise/)
│   └── wise/  wise.cls  wiseapp.sty  wisetextDE.sty  wisetextEN.sty
├── bst/                           # ← was texmf/bibtex/bst/wise/
│   └── wisenat.bst  wisealpha.bst  wisenatnosc.bst
├── template/                      # ← NEW minimal fill-in-the-blanks starter
│   ├── thesis.tex  references.bib  figures/
│   └── (latexmkrc symlink or note)
├── examples/                      # ← was Beispielarbeit/
│   ├── de/  thesis-de.tex  literatur.bib  figures/
│   └── en/  thesis-en.tex  elsewhere.tex  references.bib
└── docs/                          # ← was Dokumentation/ + Einfuehrung.pdf
    ├── getting-started.md (DE+EN)  filling-in.md  troubleshooting.md
    ├── overleaf-conformance-report.md
    ├── maintainer/  (this folder)
    └── pdf/  (heavy PDFs; or serve via Releases)
```

Naming: lower-case, hyphenated, English directory names; keep German *content* and
German fixed strings (`wisetextDE.sty`) as-is. `latex/` + `bst/` mirror the `TEXINPUTS`/
`BSTINPUTS` entries in `latexmkrc`.

## 5. Suggested migration order (non-destructive, reviewable)

1. **Hygiene** — `git rm` the cruft (S5): `.swn/.swo/.swp`, `wise.log`; move `wise_diff.cls`
   out of the distributed set (keep in `dev/` if still wanted).
2. **Encoding fix first** — normalize every source to UTF-8; switch the class to
   `[utf8]{inputenc}` (or drop it) + add `[T1]{fontenc}`. Re-run the build matrix.
   *(Do this before moving files so diffs stay readable.)*
3. **Add `latexmkrc`** (done) so the current tree compiles via `latexmk`/Overleaf.
4. **Lift the package**: `texmf/tex/latex/wise/ → latex/wise/`, `texmf/bibtex/bst/wise/ → bst/`;
   update `latexmkrc` paths. Re-run the build matrix.
5. **Rename examples**: `Beispielarbeit/ → examples/{de,en}/`; fix the EN title-page field
   order bug while there.
6. **Carve `template/`** from the simpler (DE) example: strip body to fill-in stubs.
7. **Relocate docs**: `Dokumentation/ → docs/`; move heavy PDFs to `docs/pdf/` or Releases.
8. **CI + release** packaging that flattens `latex/` + `bst/` into the distributed ZIPs.

Each step is one PR with a green build matrix gate, so the repo never enters a
non-compiling state.

## 6. Explicitly out of scope here

Refactoring `wise.cls` internals (modern `\DeclareKeys` option handling, expl3 metadata
interface, deprecated KOMA options) is recommended in the
[conformance report](../overleaf-conformance-report.md) (PKG-0x) but is a separate,
larger workstream from this structural move.

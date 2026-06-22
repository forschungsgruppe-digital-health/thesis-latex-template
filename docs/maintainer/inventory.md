# Phase 0 — Inventory

> Maintainer scratch artifact for the migration/modernization of the FGDH thesis
> LaTeX template. Captures the audited facts the rest of the plan depends on.
> Produced 2026-06-22 from a reproducible Docker build (see *Build environment*).
> Companion files: [decision-log.md](decision-log.md), [repo-structure.md](repo-structure.md).

## Build environment used

| Item | Value |
|---|---|
| Local TeX install | **none** on this machine — builds run in Docker |
| Image | `texlive/texlive:latest` (multi-arch, pulled 2026-06-22) |
| TeX Live | **2026** (`pdfTeX 3.141592653-2.6-1.40.29`) |
| Host | macOS, Apple Silicon (arm64) |
| Rendering | `gs` (ghostscript) for PDF→PNG; poppler is **not** in the image |

> Note: TeX Live 2026 is *newer* than any Overleaf target (overleaf.com is on TeX
> Live 2025; self-hosted ZIH lags further). Building green on 2026 is a useful upper
> bound but does **not** prove the older Overleaf baselines — see OVL-06 in the
> [conformance report](../overleaf-conformance-report.md).

## Engine & toolchain

| Item | Finding | Evidence |
|---|---|---|
| **Engine** | **pdfLaTeX** | `wise.cls` loads hyperref with `[pdftex]`, uses `times`, no `fontspec` |
| **Bibliography** | **BibTeX + `natbib`** (not biber/biblatex) | `\bibliographystyle{wisenat}` + `\bibliography{}`; `\RequirePackage{natbib}` in class |
| **Bib style** | custom `wisenat.bst` (+ `wisealpha`, `wisenatnosc`) | K.F. Lorenzen `natdin`/`alphadin`, DIN 1505 — third party, see [THIRD-PARTY-NOTICES](../../THIRD-PARTY-NOTICES.md) |
| **Base class** | KOMA-Script `scrartcl` (12pt) | `\LoadClass[...]{scrartcl}` |

## Custom package files

All custom code lives under `texmf/` (the root cause of the Overleaf blocker):

| File | Path | Role |
|---|---|---|
| `wise.cls` | `texmf/tex/latex/wise/` | main class, by **Malte Helmhold** (TU Dresden, 2012-07-10, v1.0) |
| `wiseapp.sty` | `texmf/tex/latex/wise/` | appendix / list helpers (`\listofabbreviations`, …) |
| `wisetextDE.sty` | `texmf/tex/latex/wise/` | German fixed strings (title page, declaration) |
| `wisetextEN.sty` | `texmf/tex/latex/wise/` | English fixed strings |
| `wisenat.bst` `wisealpha.bst` `wisenatnosc.bst` | `texmf/bibtex/bst/wise/` | DIN 1505 BibTeX styles (third party) |

Class options observed: `xlevel` (4th numbered sectioning level), `hyperref`, `mp`
(margin notes), `nat` (use `wisenat`/natbib), `en` (English; default is German).

## Examples

| Example | Entry file | Deps |
|---|---|---|
| German | `Beispielarbeit/BeispielarbeitDE/Beispielarbeit.tex` | `literatur.bib`, `bilder/flussdiagramm01.png`, `wisenat.bst` |
| English | `Beispielarbeit/BeispielarbeitEN/Example.tex` | `test.bib`, `\include{elsewhere}`, `wisenat.bst` |

There is **no minimal `template/` starter** — the examples *are* the template today.

## Encoding (the headline defect)

| File | Encoding on disk | Result under `[latin9]{inputenc}` |
|---|---|---|
| `wise.cls` | **UTF-8** | umlauts in the class are misread → mojibake |
| `wisetextDE.sty` `wisetextEN.sty` | ISO-8859 (latin9) | render correctly |
| `Beispielarbeit.tex` (DE) | ISO-8859 (latin9) | render correctly |
| `Example.tex` (EN) | ASCII | fine |

- The class declares `\RequirePackage[latin9]{inputenc}` ([wise.cls:201](../../texmf/tex/latex/wise/wise.cls#L201))
  but the file itself is UTF-8. Its only rendered non-ASCII heading,
  `\addsec{Abkürzungsverzeichnis}` ([wise.cls:289](../../texmf/tex/latex/wise/wise.cls#L289)),
  prints as **"AbkÃŒrzungsverzeichnis"** in both DE and EN PDFs (verified by rendering the ToC).
- **No `\usepackage[T1]{fontenc}`** anywhere → OT1 font encoding: the umlauts that *do*
  render are composite glyphs that are not copy/paste/search-able and break German hyphenation.
- This **mixed-encoding** state is the #1 Overleaf risk: Overleaf assumes UTF-8 (ENC-01/02/03).

## Build matrix (reproducible)

| # | Scenario | Layout | Result |
|---|---|---|---|
| C | naïve upload | main `.tex` in subdir, class only under `texmf/`, default search | ❌ `File 'wise.cls' not found`, no PDF |
| A | texmf installed | `TEXMFHOME=…/texmf` (how the authors built) | ✅ DE **14 pp**, EN PDF |
| B | flattened | all `.cls/.sty/.bst` beside the main `.tex` | ✅ identical PDFs |
| shim | subfolders + path shim | main at root + `texmf/` subtree + `TEXINPUTS=.:./texmf//:` | ✅ DE 14 pp, bibliography resolved |

BibTeX + `wisenat.bst` resolves correctly (the "undefined citation/reference" warnings
are pass-1 only and clear by the final pass).

## Committed cruft (should not be tracked)

- `texmf/tex/latex/wise/.swn`, `.swo`, `.swp` — Vim swap files
- `texmf/tex/latex/wise/wise.log` — a stray build log
- `wise_diff.cls` — a diff variant of the class, not needed by users
- Large PDFs in the clone path: `Einfuehrung.pdf` (~1 MB), the example/doc PDFs (bloat clones/ZIP — REPO-03 / Phase 4.4)

## What is missing (gap list)

`template/` starter · `LICENSE` · `THIRD-PARTY-NOTICES` · `README` rewrite ·
`CONTRIBUTING` · `CHANGELOG` · `CITATION.cff` · `CODE_OF_CONDUCT` · `AGENTS.md` ·
`.editorconfig` · `latexmkrc` (Overleaf path shim) · `.devcontainer/` · CI under
`.github/workflows/` · GitHub *template repository* flag.

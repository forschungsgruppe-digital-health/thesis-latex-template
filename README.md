# FGDH Thesis LaTeX Template

LaTeX template for academic theses (Seminar / Bachelor / Master / Diploma / PhD) at the
**Forschungsgruppe Digital Health (FGDH)**, Faculty of Business and Economics,
TU Dresden. Built on the `fgdh-thesis` document class (formerly `wise`; pdfLaTeX +
BibTeX/`natbib`, DIN 1505 citations), continued from the original template by Malte Helmhold.

[![License: LPPL 1.3c](https://img.shields.io/badge/code-LPPL%201.3c-blue.svg)](LICENSES/LPPL-1.3c.txt)
[![Docs: CC BY 4.0](https://img.shields.io/badge/docs-CC%20BY%204.0-lightgrey.svg)](LICENSES/CC-BY-4.0.txt)

> **Status (June 2026).** The class was renamed **`wise` → `fgdh-thesis`**.
> `\documentclass{wise}` still works via a deprecated alias (it loads `fgdh-thesis` and
> prints a warning), so existing documents keep compiling. See the
> [maintainer plan](docs/maintainer/) for the roadmap.

---

## Get started · Schnellstart

**New to LaTeX? Use Overleaf (A) — nothing to install.** Each path ends in a compiled PDF.

### A) Overleaf — TU Dresden ZIH or cloud *(easiest, no install)*

Write entirely in your browser; no LaTeX knowledge of the internals needed.

- **TU Dresden ZIH** (<https://tex.zih.tu-dresden.de>, ZIH/SSO login): download
  **`template.zip`** from the
  [latest release](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/releases/latest),
  then **New Project → Upload Project**, open `thesis.tex`, set **Compiler = pdfLaTeX**, Recompile.
- **Cloud** (<https://overleaf.com>): one-click —
  [![Open in Overleaf](https://img.shields.io/badge/Open%20in-Overleaf-47A141.svg)](https://www.overleaf.com/docs?snip_uri=https://github.com/forschungsgruppe-digital-health/thesis-latex-template/releases/latest/download/template.zip)

→ Full guide incl. Git/token sync and **backup** (ZIH deletes projects idle for 90 days):
**[docs/overleaf.md](docs/overleaf.md)**. Then fill in the blanks: [docs/filling-in.md](docs/filling-in.md).

### B) Dev Container — local, reproducible

A complete local LaTeX environment (full TeX Live + VS Code editor, live preview, SyncTeX);
the only installs are Docker + VS Code.

1. Install [Docker](https://www.docker.com/) and [VS Code](https://code.visualstudio.com/)
   with the **Dev Containers** extension.
2. Clone and open this repo in VS Code, then run **“Dev Containers: Reopen in Container”**
   (first start pulls TeX Live, a few GB).
3. Open [`template/thesis.tex`](template/thesis.tex) and **Build** (▶).

→ Details: [docs/devcontainer.md](docs/devcontainer.md).

### C) Local LaTeX (command line)

For an existing TeX Live (2021+) with `latexmk`. Build inside a document's folder:

```bash
cd template && latexmk thesis.tex   # pdflatex + bibtex, via the folder's latexmkrc
```

Each buildable folder (`template/`, `examples/de`, `examples/en`) ships a `latexmkrc` that
puts the bundled class (`latex/`) and DIN 1505 styles (`bst/`) on the search path.

---

## What you edit

Start from [`template/`](template/) — a minimal fill-in-the-blanks thesis (placeholders
marked `« … »`). Then:

| You want to… | File |
|---|---|
| Set title, author, supervisor, degree | the `\bachelortitlepage{…}` block in `template/thesis.tex` (swap for `\master…`/`\diploma…`/`\dissertation…`) |
| Choose language | class option: default German, `en` for English (`\documentclass[...,en]{fgdh-thesis}`) |
| Add chapters | `\section{…}`, or split with `\include{chapter}` |
| Add references | `template/references.bib` + `\cite{key}`; style is `\bibliographystyle{fgdh-thesis-nat}` (DIN 1505) |
| Declare AI-tool use | `\aideclaration` in the appendix — tick a box and list tools via `\aideclaration[\aitool{tool}{type & purpose}{chapter}…]` (see [filling-in.md §7](docs/filling-in.md)) |

Full walk-through: [docs/filling-in.md](docs/filling-in.md). The richer DE/EN sample
theses live under [`examples/`](examples/).

## Repository layout

```text
template/         minimal fill-in-the-blanks starter (start here)
examples/         richer DE/EN sample theses (de/, en/)
latex/            the fgdh-thesis class + styles (+ deprecated wise.cls alias)
bst/              DIN 1505 BibTeX styles (third-party)
docs/             documentation: filling-in, troubleshooting, dev container, maintainer/
.devcontainer/    local LaTeX dev environment
latexmkrc         whole-repo search-path config (build any document from the root)
```

## Documentation

- [docs/overleaf.md](docs/overleaf.md) — Overleaf (TU Dresden ZIH & cloud): upload, Git/token sync, backup
- [docs/filling-in.md](docs/filling-in.md) — how to fill in the template
- [docs/troubleshooting.md](docs/troubleshooting.md) — common problems & fixes
- [docs/devcontainer.md](docs/devcontainer.md) — the local LaTeX environment
- [docs/maintainer/](docs/maintainer/) — decision log, releasing
- [Overleaf conformance report](docs/overleaf-conformance-report.md)
- **New to LaTeX?** Start with [Overleaf Learn](https://www.overleaf.com/learn) or
  [learnlatex.org](https://www.learnlatex.org/) — you only need the basics to use this template.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) and our [Code of Conduct](CODE_OF_CONDUCT.md).

## License & citation

Dual-licensed — LaTeX **code** under [LPPL 1.3c](LICENSES/LPPL-1.3c.txt), **documentation**
under [CC BY 4.0](LICENSES/CC-BY-4.0.txt). Bundled third-party BibTeX styles keep their own
terms ([THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md)). Full overview: [LICENSE](LICENSE).
To cite the template, see [CITATION.cff](CITATION.cff) (GitHub’s “Cite this repository”).

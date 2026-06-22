# FGDH Thesis LaTeX Template

LaTeX template for academic theses (Seminar / Bachelor / Master / Diploma / PhD) at the
**Forschungsgruppe Digital Health (FGDH)**, Faculty of Business and Economics,
TU Dresden. Based on the `wise` document class (pdfLaTeX + BibTeX/`natbib`, DIN 1505
citations), continued from the original template by Malte Helmhold.

[![License: LPPL 1.3c](https://img.shields.io/badge/code-LPPL%201.3c-blue.svg)](LICENSES/LPPL-1.3c.txt)
[![Docs: CC BY 4.0](https://img.shields.io/badge/docs-CC%20BY%204.0-lightgrey.svg)](LICENSES/CC-BY-4.0.txt)

> **Status — modernization in progress (June 2026).** The repository has just been
> migrated to the FGDH organization and is being modernized (UTF-8/encoding fix,
> flattened layout, CI, releases). The **Dev Container** path below works today; the
> one-click Overleaf path lands with the first tagged release. See the
> [maintainer plan](docs/maintainer/) for the roadmap.

---

## Get started · Schnellstart

Pick **one** path. Each ends in a compiled PDF.

### A) Dev Container — local, reproducible *(recommended, works now)*

A complete LaTeX environment (full TeX Live + VS Code editor, preview, SyncTeX) with
zero local install beyond Docker + VS Code.

1. Install [Docker](https://www.docker.com/) and [VS Code](https://code.visualstudio.com/)
   with the **Dev Containers** extension.
2. Clone and open this repository in VS Code:
   `git clone https://github.com/forschungsgruppe-digital-health/thesis-latex-template.git`
3. Run **“Dev Containers: Reopen in Container”**. On first start it pulls TeX Live (a few GB).
4. Open [`template/thesis.tex`](template/thesis.tex) and **Build** (▶) — the PDF opens in
   a side tab. (Or open an example under `examples/`.)

→ Details: [docs/devcontainer.md](docs/devcontainer.md).

### B) Local LaTeX (command line)

Requires a TeX Live (2021+ recommended) with `latexmk`. From the project root:

```bash
latexmk examples/de/Beispielarbeit.tex   # pdflatex + bibtex, via latexmkrc
```

The bundled [`latexmkrc`](latexmkrc) puts the custom class (`texmf/`) on the search path.

### C) Overleaf (cloud or TU Dresden ZIH) *(coming with the first release)*

Because Overleaf does not search subfolders, the reliable Overleaf path is a **flattened
release ZIP** (produced by the upcoming release workflow). The one-click button will be:

[![Open in Overleaf](https://img.shields.io/badge/Open%20in-Overleaf-47A141.svg)](https://www.overleaf.com/docs?snip_uri=https://github.com/forschungsgruppe-digital-health/thesis-latex-template/archive/refs/heads/main.zip)

- **Cloud (overleaf.com):** click the badge (creates a new project from a ZIP).
- **TU Dresden ZIH (`tex.zih.tu-dresden.de`):** the badge targets overleaf.com only —
  download the release ZIP, then **New Project → Upload Project → Compile**.
  ⚠️ ZIH deletes projects inactive for **90 days** — keep GitHub (or a local clone) as the
  durable copy.

---

## What you edit

Start from [`template/`](template/) — a minimal fill-in-the-blanks thesis (placeholders
marked `« … »`). Then:

| You want to… | File |
|---|---|
| Set title, author, supervisor, degree | the `\bachelortitlepage{…}` block in `template/thesis.tex` (swap for `\master…`/`\diploma…`/`\dissertation…`) |
| Choose language | class option: default German, `en` for English (`\documentclass[...,en]{wise}`) |
| Add chapters | `\section{…}`, or split with `\include{chapter}` |
| Add references | `template/references.bib` + `\cite{key}`; style is `\bibliographystyle{wisenat}` (DIN 1505) |

Full walk-through: [docs/filling-in.md](docs/filling-in.md). The richer DE/EN sample
theses live under [`examples/`](examples/).

## Repository layout

```text
template/         minimal fill-in-the-blanks starter (start here)
examples/         richer DE/EN sample theses (de/, en/)
texmf/            custom class + styles + DIN 1505 .bst (the wise package)
Dokumentation/    original German documentation (PDF + sources)
docs/             documentation: filling-in, troubleshooting, dev container, maintainer plan
.devcontainer/    local LaTeX dev environment
latexmkrc         search-path shim so the class is found from the project root
```

A critique and the target layout are in
[docs/maintainer/repo-structure.md](docs/maintainer/repo-structure.md).

## Documentation

- [docs/filling-in.md](docs/filling-in.md) — how to fill in the template
- [docs/troubleshooting.md](docs/troubleshooting.md) — common problems & fixes
- [docs/devcontainer.md](docs/devcontainer.md) — the local LaTeX environment
- [docs/maintainer/](docs/maintainer/) — inventory, decision log, structure proposal, releasing
- [Overleaf conformance report](docs/overleaf-conformance-report.md)
- [`Einfuehrung.pdf`](Einfuehrung.pdf), [Dokumentation/](Dokumentation/) — original German docs

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) and our [Code of Conduct](CODE_OF_CONDUCT.md).

## License & citation

Dual-licensed — LaTeX **code** under [LPPL 1.3c](LICENSES/LPPL-1.3c.txt), **documentation**
under [CC BY 4.0](LICENSES/CC-BY-4.0.txt). Bundled third-party BibTeX styles keep their own
terms ([THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md)). Full overview: [LICENSE](LICENSE).
To cite the template, see [CITATION.cff](CITATION.cff) (GitHub’s “Cite this repository”).

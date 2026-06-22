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

Requires a TeX Live (2021+ recommended) with `latexmk`. Build inside a document's folder:

```bash
cd template && latexmk thesis.tex   # pdflatex + bibtex, via the folder's latexmkrc
```

Each buildable folder (`template/`, `examples/de`, `examples/en`) ships a `latexmkrc` that
puts the bundled class (`latex/`) and DIN 1505 styles (`bst/`) on the search path.

### C) Overleaf (cloud or TU Dresden ZIH)

Because Overleaf does not search subfolders, use the **flattened release ZIP** (the class
sits beside the main `.tex`), built and attached to each release. One-click:

[![Open in Overleaf](https://img.shields.io/badge/Open%20in-Overleaf-47A141.svg)](https://www.overleaf.com/docs?snip_uri=https://github.com/forschungsgruppe-digital-health/thesis-latex-template/releases/latest/download/template.zip)

- **Cloud (overleaf.com):** click the badge — it imports the latest release's `template.zip`.
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
| Choose language | class option: default German, `en` for English (`\documentclass[...,en]{fgdh-thesis}`) |
| Add chapters | `\section{…}`, or split with `\include{chapter}` |
| Add references | `template/references.bib` + `\cite{key}`; style is `\bibliographystyle{fgdh-thesis-nat}` (DIN 1505) |

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

A critique and the target layout are in
[docs/maintainer/repo-structure.md](docs/maintainer/repo-structure.md).

## Documentation

- [docs/filling-in.md](docs/filling-in.md) — how to fill in the template
- [docs/troubleshooting.md](docs/troubleshooting.md) — common problems & fixes
- [docs/devcontainer.md](docs/devcontainer.md) — the local LaTeX environment
- [docs/maintainer/](docs/maintainer/) — inventory, decision log, structure proposal, releasing
- [Overleaf conformance report](docs/overleaf-conformance-report.md)
- [docs/pdf/einfuehrung.pdf](docs/pdf/einfuehrung.pdf) — a general LaTeX introduction (German, legacy)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) and our [Code of Conduct](CODE_OF_CONDUCT.md).

## License & citation

Dual-licensed — LaTeX **code** under [LPPL 1.3c](LICENSES/LPPL-1.3c.txt), **documentation**
under [CC BY 4.0](LICENSES/CC-BY-4.0.txt). Bundled third-party BibTeX styles keep their own
terms ([THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md)). Full overview: [LICENSE](LICENSE).
To cite the template, see [CITATION.cff](CITATION.cff) (GitHub’s “Cite this repository”).

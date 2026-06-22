# Contributing

Thanks for helping improve the FGDH thesis template! This document explains how to set
up a build environment, the conventions we follow, and how changes get reviewed and
released. By participating you agree to our [Code of Conduct](CODE_OF_CONDUCT.md).

## Ways to contribute

- **Report a problem** — open an [issue](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/issues)
  (compile error, wrong output, unclear docs). Include your TeX Live / Overleaf version
  and a minimal example.
- **Improve the template, class, or docs** — open a pull request (see below).

## Development setup

You do **not** need a local TeX install.

- **Recommended — Dev Container:** open the repo in VS Code → *Reopen in Container*
  (see [docs/devcontainer.md](docs/devcontainer.md)). You get full TeX Live, LaTeX
  Workshop, build-on-save, and SyncTeX preview.
- **Docker only** — build exactly as CI does:

  ```bash
  docker run --rm -v "$PWD":/work texlive/texlive:latest \
    latexmk -cd examples/de/Beispielarbeit.tex
  ```

- **Native** — any TeX Live 2021+ with `latexmk`. The root [`latexmkrc`](latexmkrc) puts
  the bundled class on the search path.

## Source conventions

These are non-negotiable because they protect Overleaf compatibility and output quality
(see the [conformance report](docs/overleaf-conformance-report.md)):

- **Encoding:** every `.tex/.cls/.sty/.bst/.bib` file is **UTF-8 (no BOM)** with **LF**
  line endings. The repo ships an [`.editorconfig`](.editorconfig) that enforces this.
  Do **not** introduce `[latin1]`/`[latin9]`/`utf8x` `inputenc`.
- **Fonts:** under pdfLaTeX keep `\usepackage[T1]{fontenc}`; do not load `fontspec`
  unless the engine is switched to xelatex/lualatex (and document the switch).
- **Engine / bibliography:** pdfLaTeX + BibTeX (`natbib`). Let `latexmk` run the bib tool.
- **Third-party files:** never strip the copyright/contribution headers from the bundled
  `.bst` files. If you must modify one, **rename it** and update its in-file support
  contact, per its license and [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md).
- **LPPL:** the `wise` class is LPPL 1.3c. Substantive modifications must keep the work
  clearly identifiable as modified and record the change in [CHANGELOG.md](CHANGELOG.md).

## Verifying a change

Before opening a PR, confirm the build matrix still holds:

1. The DE and EN examples compile to PDF with **no missing-file / class-not-found** errors.
2. The bibliography resolves (no undefined citations in the final pass).
3. For class/encoding changes, render the ToC and title page and check the umlauts
   (`Abkürzungsverzeichnis`, `Universität`, …) render correctly and are copy/paste-able.

The reusable **Overleaf-conformance skill** (`.claude/skills/overleaf-conformance/`)
automates much of this audit and regenerates `docs/overleaf-conformance-report.md`.

## Commit messages

This project uses **[Conventional Commits](https://www.conventionalcommits.org/)** — they
drive automated versioning and the changelog (see Releases). Use them for commit messages
and (since PRs are squash-merged) for **PR titles**:

- `feat: …` — a new capability → **minor** version bump
- `fix: …` — a bug fix → **patch** bump
- `feat!: …` or a `BREAKING CHANGE:` footer → **major** bump
- `docs:` / `chore:` / `refactor:` / `ci:` / `test:` — no release on their own

## Pull requests

- `main` is **protected**: no direct pushes. Open a PR (from a feature branch or `dev`)
  **targeting `main`**, with a Conventional-Commit title.
- Keep PRs focused; one logical change each. Update docs in the same PR.
  Do **not** hand-edit `CHANGELOG.md` or version numbers — Release Please does that.
- Describe what you changed and how you verified the build. **CI must be green.**

## Releases (maintainers)

Releases are automated with **[Release Please](https://github.com/googleapis/release-please)**
and Semantic Versioning. You don't tag by hand — you merge the bot's release PR. Full
process, the phased `wise` → `fgdh-thesis` plan, and the required protected-branch settings
are in [docs/maintainer/releasing.md](docs/maintainer/releasing.md). Build/release facts for
automated agents are in [AGENTS.md](AGENTS.md).

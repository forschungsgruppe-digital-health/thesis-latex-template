# Best practices: custom LaTeX packages compatible with Overleaf

Prioritized, web-grounded best practices for authoring and distributing a custom LaTeX
class/package that compiles reliably on Overleaf (cloud + self-hosted) and locally.
Each maps to one or more checklist ids in [conformance-checklist.md](conformance-checklist.md).
Compiled and adversarially verified 2026-06; refresh version-sensitive facts (TeX Live
years, tool versions) before relying on them.

## Packaging

- **Open with `\NeedsTeXFormat{LaTeX2e}` then a dated `\ProvidesClass/\ProvidesPackage`**
  `[YYYY/MM/DD vX.Y desc]` (date first, no leading space). The kernel compares the *date*
  for version guards. — clsguide; <http://latexref.xyz/Class-and-package-structure.html>
- **Four-part layout**: identification → preliminary decls (`\RequirePackage`) → option
  declaration+processing → main decls and `\LoadClass` *after* options. Keep all config
  inside the class, not in user preambles. — latexref
- **Guard dependencies** with release dates: `\RequirePackage{dep}[YYYY/MM/DD]`,
  `\LoadClass{base}[YYYY/MM/DD]` → clear warning on outdated installs. — latexref
- **Expose metadata via a declared interface** (classic `\newcommand`+`\gdef\@field` under
  `\makeatletter`, or an l3keys-backed `\Setup{key=…}`), never by redefining internals. —
  Wikibooks LaTeX/Title_Creation
- **Namespace internals** with a unique module prefix (expl3 `\l_module_…_type`) to avoid
  clashes. — l3keys.dtx
- **Prefer the kernel key-value option system** (`\DeclareKeys`+`\ProcessKeyOptions`) for
  kernels ≥2022-06-01; treat `l3keys2e` as legacy; `kvoptions` only for old kernels. —
  LaTeX News 35
- **Version string + monotonic date**: SemVer `vMAJOR.MINOR.PATCH` for humans, but ensure
  the `YYYY/MM/DD` increases every release (the kernel compares the date). — semver.org

## Encoding & fonts

- **Save everything UTF-8 (no BOM), LF**; `\usepackage[utf8]{inputenc}` is redundant on
  TeX Live 2018+ (UTF-8 is the kernel default) but harmless. — Overleaf docs
- **Under pdfLaTeX, always `\usepackage[T1]{fontenc}`** (with a T1 font such as `lmodern`):
  OT1 builds umlauts with `\accent`, which breaks hyphenation and makes them
  non-copy/paste/search-able. — texfaq.org/FAQ-why-inp-font
- **`babel` with `ngerman`** for German (post-1996 orthography), across all engines;
  prefer babel over polyglossia. — babel German guide
- **pdfLaTeX is a deliberate, compatible default** (fullest `microtype`); switch to
  lua/xelatex + `fontspec` only for system/OpenType fonts or advanced Unicode/math. —
  microtype manual
- **Under xe/lualatex, drop fontenc/inputenc, use `fontspec`** (`\setmainfont`; TU encoding
  supersedes T1/TS1). — learnlatex.org
- **Never mix encodings**: `inputenc` does not transcode — one Latin-9 file in a UTF-8
  project yields "Invalid UTF-8 byte" or silent mojibake. Normalize all files. — latexref

## Overleaf compatibility

- **Flatten custom `.cls/.sty/.bst` to the project root** by default — Overleaf does **not**
  search subfolders (top cause of works-locally/fails-on-Overleaf). — Overleaf: adding deps
- **If you keep subfolders, add a root `latexmkrc`** (named exactly that, no dot):
  `$ENV{'TEXINPUTS'}='./tex//:' . $ENV{'TEXINPUTS'};` and the `BSTINPUTS` equivalent. —
  Overleaf: adding deps
- **Main document at the project root**, set via project Settings/file-tree; Overleaf
  **ignores `% !TeX root`** and engine magic comments. — Overleaf: the main document
- **Target a TeX Live baseline common to overleaf.com and the lagging self-hosted instance**
  (overleaf.com=TeX Live 2025; self-hosted often lags 1–2 yr). Document the pin. — Overleaf: tex-live
- **No shell-escape/`\write18`/network at compile** (minted works on overleaf.com but not
  default self-hosted; no internet at compile). — Overleaf: minted
- **Let `latexmk` pick the bib tool** (express via `\bibliographystyle`+`\bibliography` or
  biblatex options); don't run biber/bibtex by hand. — Overleaf: biblatex
- **Custom fonts**: upload the files, use xe/lualatex + fontspec (license permitting). —
  Overleaf: TeX Live & compilers

## Licensing

- **License the code under LPPL 1.3c** with a named *Current Maintainer* + contact; CTAN
  expects it and it preserves maintainer continuity. — ctan.org/license/lppl1.3
- **Do not put `.cls/.sty/.tex` under Creative Commons** — CC recommends against CC for
  code; reserve CC-BY for prose/figures. — creativecommons.org/faq
- **Audit & preserve each bundled third-party `.bst` license** (some are LPPL, some — e.g.
  APS REVTeX — restrictive); keep notices verbatim, rename on modification, aggregate into
  `THIRD-PARTY-NOTICES`. — ospo.co notice-files guide

## Repo hygiene & distribution

- **README leads with value proposition + multiple onboarding paths** (Open-in-Overleaf
  badge → manual ZIP upload → local clone+build), then prerequisites/build/layout/one
  customization config/license. — exemplar thesis-template READMEs
- **Open-in-Overleaf badge → a stable tagged-release ZIP** via URL-encoded `snip_uri`, not
  a moving branch tip. — overleaf.com/devs
- **`.gitignore` from GitHub's `TeX.gitignore`**; decide `*.bbl` deliberately (commit it
  when a journal/Overleaf needs it shipped). — github/gitignore
- **CONTRIBUTING + Contributor Covenant 2.1 CoC + CITATION.cff (1.2.0) + Keep-a-Changelog
  CHANGELOG.** — contributor-covenant.org; keepachangelog.com
- **GitHub *template repository* + CI under `.github/workflows`** (`xu-cheng/latex-action`,
  `texlive_version` pinned) copied into instantiated repos. — github/xu-cheng/latex-action
- **Automate releases on `v*` tag**: build PDF + curated ZIP (no CI/dev cruft), publish via
  `softprops/action-gh-release@v2`. — softprops/action-gh-release

## Dev container

- **Commit `.devcontainer/` with a pinned full-scheme Debian TeX Live image** (official
  `texlive/texlive` historic tag or `ghcr.io/xu-cheng/texlive-historic-debian:<year>`)
  matching the Overleaf year — not `:latest` — for parity + offline use. — Overleaf: tex-live
- **Pin LaTeX Workshop + an explicit `pdflatex→bibtex→pdflatex×2` recipe** (`-synctex=1`) in
  `customizations.vscode`. — LaTeX-Workshop wiki
- **Named volumes for caches** (bind mounts are slow on macOS/Windows); full scheme so no
  runtime `tlmgr`/network. — VS Code advanced containers

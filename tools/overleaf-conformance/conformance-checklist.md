# Custom-LaTeX-on-Overleaf Conformance Checklist

A reusable audit checklist for any repository that ships a **custom LaTeX class/package
intended to compile on Overleaf** (cloud and self-hosted) and be distributed. Each item
has a stable id, a category, a severity, and a concrete `howToCheck`. Derived from
web-grounded, adversarially-verified research (sources in
[best-practices.md](best-practices.md)).

Severity: **blocker** (will not work / legally unsafe) · **high** · **medium** · **low**.

## Packaging (PKG)

| id | criterion | sev | how to check |
|----|-----------|-----|--------------|
| PKG-01 | Each `.cls/.sty` begins with `\NeedsTeXFormat{LaTeX2e}` as its first declaration. | medium | First non-comment line of each file is `\NeedsTeXFormat{LaTeX2e}`. |
| PKG-02 | Each `.cls/.sty` has a `\ProvidesClass/\ProvidesPackage` line whose optional arg starts with a `YYYY/MM/DD` date (no leading space) + version + description. | high | `grep` the `\Provides…[YYYY/MM/DD …]` line; fail if the bracket opens with a space or the date is missing/misformatted. |
| PKG-03 | Class follows the four-part structure; options processed **before** `\LoadClass`. | medium | In the `.cls`, `\ProcessOptions`/`\ProcessKeyOptions` precedes `\LoadClass`; bulk of defs follow `\LoadClass`. |
| PKG-04 | Critical dependencies loaded with a release-date guard. | low | Version-sensitive `\RequirePackage`/`\LoadClass` carry a trailing `[YYYY/MM/DD]`. Informational. |
| PKG-05 | User metadata (title/author/supervisor/…) set via declared commands, not by redefining class internals in the document. | medium | Example main `.tex` uses provided setters; no `\makeatletter`/`\renewcommand` of class `@`-internals. |
| PKG-06 | Internal macros/variables namespaced with a unique module prefix. | low | expl3 `\l_<module>_…_type` / classic `\<module>`-prefixed `@`-internals; flag generic names likely to clash. |
| PKG-07 | If key-value options are used, new code uses kernel `\ProcessKeyOptions` (or maintained `kvoptions`/`l3keys2e` for old kernels), not bare `keyval`/`pgfkeys`. | low | `grep` for the option processor; fail if options use bare keyval/pgfkeys with no real package-option processor. |

## Encoding & fonts (ENC)

| id | criterion | sev | how to check |
|----|-----------|-----|--------------|
| ENC-01 | All text source files are UTF-8 without BOM. | high | `file --mime-encoding` on every `.tex/.sty/.cls/.bst/.bib` → all `utf-8`/`us-ascii`; no `EF BB BF` BOM. |
| ENC-02 | No legacy 8-bit inputenc (`latin1`/`latin9`/`utf8x`). | high | `grep` for `inputenc` with `[latin*]`/`[utf8x]`/`[ansinew]`/`[applemac]`; flag any. |
| ENC-03 | Under pdfLaTeX, `\usepackage[T1]{fontenc}` is loaded. | high | If pdflatex, `grep` for `[T1]{fontenc}`. Optionally verify an umlaut copy/pastes from the PDF. |
| ENC-04 | Engine-appropriate fonts: pdfLaTeX→fontenc/NFSS; xe/lualatex→fontspec and NO inputenc/fontenc. | medium | Determine engine; check the matching font setup is present and the wrong one is absent. |
| ENC-05 | German uses `babel` with `ngerman` (not deprecated `german`; `polyglossia` only if justified). | medium | `grep` for `[…ngerman…]{babel}`; flag bare `german` or unjustified `polyglossia`. |

## Overleaf compatibility (OVL)

| id | criterion | sev | how to check |
|----|-----------|-----|--------------|
| OVL-01 | Custom `.cls/.sty/.bst` are at the project root, OR a root `latexmkrc` adds recursive `TEXINPUTS`/`BSTINPUTS`. | **blocker** | List custom file paths; if in subfolders, confirm a root `latexmkrc` sets `$ENV{'TEXINPUTS'}`/`BSTINPUTS` with trailing `//`. |
| OVL-02 | The main/root `.tex` is at the project top level. | high | Files with `\documentclass`; intended main file at repo root, no shadowing same-named root `.tex`. |
| OVL-03 | A `latexmkrc` (if present) is named exactly `latexmkrc` (no dot) at the root. | high | Flag `.latexmkrc` or a `latexmkrc` inside a subfolder (not honoured by Overleaf). |
| OVL-04 | No magic comments relied on for root-file/engine selection. | medium | `grep` for `% !TeX root` / `%!TeX program` / `TS-program`; ensure config lives in Settings/latexmkrc. |
| OVL-05 | No required shell-escape/`\write18`/network at compile (or the self-hosted limitation is documented). | high | `grep` for `minted`, `--shell-escape`, `\write18`, `\input{|…}`, downloads; if present, verify docs note self-hosted caveat. |
| OVL-06 | Targets a TeX Live baseline available on both overleaf.com and the lagging self-hosted instance; pinned version documented. | high | README names a target TeX Live year; preamble avoids brand-new packages/kernel features an older image lacks. |
| OVL-07 | Bibliography set up so `latexmk` auto-runs the right tool. | medium | BibTeX: `\bibliographystyle`+`\bibliography`; biblatex: `[backend=biber]`+`\addbibresource`. Flag manual biber/bibtex hacks. |
| OVL-08 | All referenced packages/fonts/.bst/data exist in the target TeX Live or are committed (nothing fetched at compile). | high | Cross-check `\usepackage`/font/`.bst` names against the pinned TeX Live + repo contents. |
| OVL-09 | Custom OpenType/TrueType fonts (if any) are committed and used via XeLaTeX/LuaLaTeX + fontspec, license permitting. | medium | If `\setmainfont` references a non-TeX-Live font, confirm the file is committed, engine is xe/lua, license allows bundling. |

## Licensing (LIC)

| id | criterion | sev | how to check |
|----|-----------|-----|--------------|
| LIC-01 | A top-level `LICENSE` contains the full license text for the template's own code (LPPL 1.3c recommended). | **blocker** | Root `LICENSE` exists with complete LPPL 1.3c (or MIT) text; flag CC-BY applied to `.cls/.sty/.tex` source. |
| LIC-02 | If LPPL, the work declares maintenance status + a named Current Maintainer with contact. | high | `grep` headers/README for `maintained`/`Current Maintainer` + a contact; flag LPPL with no maintainer statement. |
| LIC-03 | Every bundled third-party `.bst` retains its original header/copyright/notices verbatim. | **blocker** | Diff each vendored `.bst` header vs upstream (or confirm the copyright block is intact). |
| LIC-04 | A top-level `THIRD-PARTY-NOTICES` lists each bundled component with copyright holder + license. | high | File exists and enumerates every vendored third-party file with attribution + terms. |
| LIC-05 | No bundled file is redistributed in violation of its terms (e.g. APS REVTeX without permission). | **blocker** | Audit each `.bst/.cls` header for restrictive/publisher-copyrighted terms; flag any bundled without redistribution rights. |
| LIC-06 | Any modified third-party `.bst` is renamed and its support contact updated, per its license. | high | For each `.bst` differing from upstream, confirm filename changed + in-file contact updated. |

## Repo hygiene & distribution (REPO)

| id | criterion | sev | how to check |
|----|-----------|-----|--------------|
| REPO-01 | A top-level README (UTF-8, no BOM) states purpose, author/contact, license, and a Quickstart with multiple onboarding paths. | high | Root README present + includes purpose, contact, license note, build command, Overleaf + local onboarding. |
| REPO-02 | An Open-in-Overleaf badge points at a stable (tagged-release) URL-encoded `snip_uri`. | medium | `grep` README for `overleaf.com/docs?snip_uri=`; verify it targets `refs/tags/…`, not `.../heads/main.zip`. |
| REPO-03 | `.gitignore` covers LaTeX build artifacts with a deliberate `*.bbl` decision. | medium | Based on GitHub `TeX.gitignore`; no committed `*.aux/*.log/*.fdb_latexmk`; intended `*.bbl` handling. |
| REPO-04 | `CONTRIBUTING.md` + a Contributor Covenant `CODE_OF_CONDUCT.md` linked from README. | low | Both exist (root or org `.github`); README/CONTRIBUTING link the CoC. |
| REPO-05 | A valid `CITATION.cff` (1.2.0) on the default branch. | low | Exists + validates (cff-version, title, authors, version, date-released, url). |
| REPO-06 | `CHANGELOG.md` in Keep a Changelog 1.1.0 (Unreleased section, dated newest-first, grouped). | low | Has Unreleased + ISO-dated versions newest-first + Added/Changed/… groupings. |
| REPO-07 | CI under `.github/workflows` builds the PDF reproducibly with a pinned TeX Live. | medium | A workflow uses `xu-cheng/latex-action` (or `texlive/texlive`) with `texlive_version` pinned + `root_file`; runs on push/PR; uploads PDF. |
| REPO-08 | The repo is configured as a GitHub template repository. | low | `gh api repos/<owner>/<repo> --jq .is_template` is `true`. |
| REPO-09 | Release automation publishes a curated ZIP (+PDF) on tag push as a stable `snip_uri` target. | low | Release workflow: `v*` trigger + `softprops/action-gh-release@v2` (`contents: write`) attaching a curated ZIP; excludes CI/dev cruft. |

## Dev container (DEV)

| id | criterion | sev | how to check |
|----|-----------|-----|--------------|
| DEV-01 | Committed `.devcontainer/devcontainer.json` pins a specific (non-`:latest`) full-scheme TeX Live image, ideally Debian matching the Overleaf year. | medium | Image tag is year/timestamp/historic-pinned + full scheme + matches the documented Overleaf year. |
| DEV-02 | Dev container pins LaTeX Workshop + an explicit build recipe with `-synctex=1`. | low | `customizations.vscode.extensions` includes `James-Yu.latex-workshop`; settings define the recipe (pdflatex args include `-synctex=1`; bibtex step present). |
| DEV-03 | Dev container is offline-capable (full scheme, no runtime tlmgr) + caches use named volumes. | low | Full-scheme image (or optional tlmgr installs) + write-heavy cache dirs are `type=volume` mounts. |

## Build (BUILD)

| id | criterion | sev | how to check |
|----|-----------|-----|--------------|
| BUILD-01 | The project compiles cleanly end-to-end with the documented engine + bibliography on the pinned TeX Live. | **blocker** | Run `latexmk -pdf` on the root file in the pinned image; exit 0, PDF produced, bibliography resolved, no undefined citations/refs. |

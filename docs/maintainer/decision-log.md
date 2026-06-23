# Phase 0 — Decision Log

> Resolved decisions for the FGDH thesis template migration/modernization.
> Supersedes the table in `maintainer-setup-cot.md`. Last updated 2026-06-22.

## Resolved

| # | Question | Decision | Rationale / evidence | Affects |
|---|---|---|---|---|
| D1 | Engine (pdf/xe/lua) | **pdfLaTeX** | Class is pdfLaTeX-only (`[pdftex]` hyperref, `times`, no fontspec). pdfLaTeX also has the fullest `microtype` support and broadest package compatibility — adequate for a German thesis. | all builds |
| D2 | Bibliography backend | **BibTeX + natbib** | Class requires `natbib`; uses custom DIN 1505 `.bst`. Not biber/biblatex. `latexmk` auto-runs bibtex. | docs, CI |
| D3 | Primary license | **Dual: LPPL 1.3c (code) + CC BY 4.0 (docs/content)** | LPPL is the CTAN/TeX-community standard for `.cls`/`.sty` and preserves the *Current Maintainer* role; CC explicitly recommends *against* CC for code, so prose/figures get CC BY. | LICENSE, headers, CONTRIBUTING |
| D4 | Third-party `.bst` handling | **Preserve verbatim + THIRD-PARTY-NOTICES** | `wisenat`/`wisealpha`/`wisenatnosc` are K.F. Lorenzen's `natdin`/`alphadin` (DIN 1505), copyright retained — **not** relicensable. Keep headers intact; rename if ever modified. | THIRD-PARTY-NOTICES, LIC-03/05/06 |
| D5 | Original class authorship | **Credit Malte Helmhold; FGDH = Current Maintainer** | `wise.cls` header: "Version 1.0 … (Malte Helmhold, 07/10/2012)". Under LPPL a modified derived work must self-identify; FGDH declares itself Current Maintainer with a contact channel. | LICENSE, headers |
| D6 | Dev container TeX Live | **Full image, `texlive/texlive:latest`** | Full scheme = zero "missing package" friction and offline-capable; matches the validated build + CI. TU Dresden's ZIH Overleaf/tex service runs the rolling `latest` TeX Live (see O1), so `latest` — not a frozen historic year — gives output parity with where students compile. | `.devcontainer/`, CI |
| D7 (partial) | overleaf.com TeX Live | **TeX Live 2025** (since 2025-09-04) | Overleaf blog / docs. New projects use latest installed; existing projects keep their creation-time version. | OVL-06, badge |
| D8 | `texmf` strategy | **Ship a root `latexmkrc` shim now; flatten into the distributed `template/`+`examples/` ZIPs at release** | Both proven to compile (build matrix B and shim). The shim is non-destructive and fixes Overleaf+local today; flattening is the zero-config layout for the student ZIP. See [repo-structure.md](repo-structure.md). | OVL-01, packaging, release |
| D9 | Documentation home | **`docs/`** (student + maintainer under `docs/maintainer/`); generated reports in `docs/` | Single, discoverable docs root; keeps heavy PDFs out of the student clone path (Phase 4.4). | structure, README |
| D10 | Release management | **Release Please + SemVer on a protected `main`**, driven by Conventional Commits | Automated, auditable version bumps + changelog from commit history; no manual tagging; protected `main` with required CI. See [releasing.md](releasing.md). | CI, CHANGELOG, CITATION, versioning |
| D11 | Rename sequencing | **Rename is the LAST step**: (1) fix + improve under `wise`, (2) legacy `wise` release (`v1.x`), (3) rename to **`fgdh-thesis`** (`v2.0.0`, breaking) with a `wise.cls` compat shim | Existing users aren't disrupted; the defunct "WiSe" acronym is retired only after a clean modernized baseline ships. LPPL also wants a modified derived work renamed. | class name, releases, docs |

## Still open (needs ZIH Service Desk / org owner)

| # | Question | Needed for |
|---|---|---|
| O1 | ~~Exact **ZIH self-hosted TeX Live year** (Server Pro image)~~ | **Resolved (2026-06-23):** TU Dresden's ZIH Overleaf/tex service tracks the rolling `latest` TeX Live, so D6 dev container + CI are pinned to `texlive/texlive:latest` for true ZIH parity (OVL-06). Use a historic tag only when targeting an overleaf.com project frozen to a specific year. |
| O2 | Is `/docs?snip_uri=` enabled on the **ZIH** host? | Whether an Open-in-Overleaf badge can target ZIH (it targets overleaf.com by default) |
| O3 | Exact ZIH **Server Pro version** | Confirms Git-bridge specifics (already known: bridge enabled, tokens present) |
| O4 | Final **citable authors** for `CITATION.cff` (individuals vs. org entity) | Citation metadata; currently set to the research-group entity + Helmhold credit |

## Notes carried from the plan (unchanged, still true)

- ZIH is self-hosted ⇒ direct GitHub Synchronization is unavailable; GitHub stays the
  single source of truth; Overleaf is a consumption target (ZIP upload or badge).
- ZIH deletes projects/accounts after 90 days of inactivity ⇒ document GitHub/local as
  the durable copy.

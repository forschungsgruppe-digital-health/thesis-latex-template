---
name: overleaf-conformance
description: >-
  Audit a custom-LaTeX-package repository for conformance with LaTeX packaging
  conventions and Overleaf compatibility (cloud + self-hosted), then generate a
  report in docs/. Use when asked to check whether a LaTeX class/template/package
  follows best practices, is Overleaf-compatible, or "conforms to conventions" —
  e.g. "audit this template", "is this Overleaf-ready", "run the conformance check".
---

# Overleaf / custom-LaTeX conformance audit

Audit a repository that ships a **custom LaTeX class/package** meant to compile on
Overleaf and be distributed, then write a scored report to
`docs/overleaf-conformance-report.md`.

The knowledge base lives next to this file:

- `reference/conformance-checklist.md` — the scored checklist (ids PKG/ENC/OVL/LIC/REPO/DEV/BUILD, each with severity + how-to-check). **This is the audit spec.**
- `reference/best-practices.md` — the underlying, cited best practices (refresh against the web when version-sensitive facts may have changed).
- `scripts/scan.sh` — runs the automatable static checks and prints PASS/WARN/FAIL.

## Procedure

1. **Scope.** Identify the repo root, the custom `.cls/.sty/.bst`, the example/main
   `.tex`, the engine (pdfLaTeX vs xe/lualatex), and the bibliography backend. Note the
   target Overleaf/TeX Live version if documented.

2. **Refresh facts (optional but recommended).** Version-sensitive items — current
   overleaf.com TeX Live year (OVL-06), latest LaTeX kernel option API (PKG-07), tool
   versions — drift. If web access is available, re-verify the relevant claims in
   `reference/best-practices.md` with `WebSearch`/`WebFetch` and prefer fresh sources.

3. **Static scan.** Run the helper in a TeX Live container (note: the minimal
   `texlive/texlive` image has `iconv` but **not** `file`; the script handles this):

   ```bash
   docker run --rm -v "$PWD":/repo:ro texlive/texlive:latest \
     bash /repo/.claude/skills/overleaf-conformance/scripts/scan.sh /repo
   ```

   Use the output for the automatable items (ENC-01/02/03/05, PKG-01/02, OVL-01/03/04/05,
   the REPO/LIC/DEV file-presence and HYGIENE checks).

4. **Build (BUILD-01).** Compile the main/example document end-to-end on the pinned
   TeX Live (`latexmk -pdf`/`-cd`), confirm exit 0, a PDF, and a resolved bibliography
   with no undefined citations/references in the final pass. For encoding items, render a
   page with `gs` and visually confirm umlauts are correct **and** copy/paste-able.

5. **Judge the context items** the script cannot (they need reading/judgement):
   PKG-03/04/05/06, OVL-02/06/07/08/09, LIC-02/03/05/06, REPO-02/08/09, DEV-02/03.
   For each, apply the `howToCheck` in the checklist and decide PASS / FAIL / WARN / N/A.

6. **Write the report** to `docs/overleaf-conformance-report.md`:
   - A summary table (counts by severity; overall verdict).
   - One row per checklist id: **verdict**, **evidence** (file:line, scan output, build
     result), and **remediation** for anything not passing.
   - Group blockers first. Be specific and cite the checklist source where relevant.

## Conventions

- **Do not fail on missing context** — mark items N/A with a reason (e.g. "no custom
  fonts ⇒ OVL-09 N/A") rather than guessing.
- **Severity drives priority**: blockers (OVL-01, LIC-01/03/05, BUILD-01) gate
  "Overleaf-ready"; high/medium/low are quality.
- **Re-runnable**: the report should be regenerated, not hand-edited, so the audit stays
  honest as the repo changes. Date every report.
- This checklist is general — it audits *any* custom-LaTeX-on-Overleaf repo, not only this one.

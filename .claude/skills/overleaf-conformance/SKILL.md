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

This skill is a thin wrapper over the **vendor-neutral** tooling in
[`tools/overleaf-conformance/`](../../../tools/overleaf-conformance/) so the *same* audit
works for any model or a human. Do not duplicate the checklist here — read it from there.

## Procedure

1. **Read the spec:** [`tools/overleaf-conformance/conformance-checklist.md`](../../../tools/overleaf-conformance/conformance-checklist.md)
   (the scored checklist) and [`best-practices.md`](../../../tools/overleaf-conformance/best-practices.md).
   If web access is available, re-verify version-sensitive facts (current overleaf.com TeX
   Live year, kernel option API, tool versions) with `WebSearch`/`WebFetch` and prefer fresh sources.

2. **Static scan:**

   ```bash
   docker run --rm -v "$PWD":/repo:ro texlive/texlive:TL2025-historic \
     bash /repo/tools/overleaf-conformance/scan.sh /repo
   ```

   (The minimal image has `iconv` but not `file`; the script handles that.) Use the output
   for the automatable items.

3. **Build (BUILD-01):** compile the main/example document with `latexmk` on the pinned TeX
   Live; confirm exit 0, a PDF, and a resolved bibliography with no undefined citations.
   Render a page with `gs` and visually confirm umlauts are correct **and** copy/paste-able.

4. **Judge the context items** the script can't (the checklist marks which) by reading the repo.

5. **Write the report** to `docs/overleaf-conformance-report.md`: a summary table (counts by
   severity, overall verdict) and one row per checklist id — **verdict**, **evidence**
   (file:line, scan output, build result), and **remediation**. Group blockers first. Date it.

## Conventions

- Mark items **N/A** with a reason rather than guessing.
- Severity drives priority: blockers (OVL-01, LIC-01/03/05, BUILD-01) gate "Overleaf-ready".
- **Regenerate** the report (don't hand-edit) after changes, so the audit stays honest.

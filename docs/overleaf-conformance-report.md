# Overleaf / custom-LaTeX Conformance Report

**Subject:** `forschungsgruppe-digital-health/thesis-latex-template` (the `fgdh-thesis` class)
**Date:** 2026-06-22 (regenerated after v3.0.0 + the restructure/de-wise + the AI-declaration section)
**Method:** [`tools/overleaf-conformance/scan.sh`](../tools/overleaf-conformance/scan.sh) +
a Docker build (`texlive/texlive:TL2025-historic`) + manual review against
[the checklist](../tools/overleaf-conformance/conformance-checklist.md).

## Verdict

**Overleaf-ready.** No blockers and no failures. The class compiles on pinned TeX Live with
correct German typesetting; the distributed `template.zip` is a flat, zero-config Overleaf
project; licensing, hygiene, CI, releases, the dev container, and the GitHub *template
repository* flag are all in place. The only open items are minor quality/refactor notes and
the pin to ZIH's exact TeX Live year (unknown).

| Severity | Pass | Warn / deferred | Fail |
|---|---|---|---|
| blocker | OVL-01, LIC-01, LIC-03, LIC-05, BUILD-01 | — | — |
| high | ENC-01/02/03, OVL-02/05/07/08, LIC-02/04, REPO-01 | OVL-06 | — |
| medium | PKG-02, OVL-03/04, ENC-04, REPO-07 | PKG-03, DEV-01 | — |
| low | PKG-01/05/07, ENC-05, REPO-02/03/04/05/06/08/09, DEV-02/03, LIC-06, OVL-09 (N/A) | PKG-04, PKG-06 | — |

## Open items (everything else passes — see the checklist)

| id | status | note |
|----|--------|------|
| OVL-06 | ⚠️ warn (high) | TeX Live pinned to `TL2025-historic` (overleaf.com parity). ZIH's exact year is unknown (decision O1) — adjust the tag if it differs. |
| DEV-01 | ⚠️ warn (med) | Dev container is full-scheme but pinned to `TL2025-historic` rather than ZIH's confirmed year (same O1). |
| PKG-03 | ⚠️ deferred (med) | `\LoadClass` precedes option processing in `fgdh-thesis.cls`; a four-part-structure refactor is a separate, larger workstream. |
| PKG-06 | ⚠️ deferred (low) | A few user-facing macros aren't module-prefixed (internal `\wisecft…` were renamed to `\fgdhthesiscft…`; full expl3-style namespacing is future work). |
| PKG-04 | info (low) | Dependencies are loaded without `[YYYY/MM/DD]` release guards. |

## What's confirmed green

- **Encoding/fonts:** all sources UTF-8; `[utf8]{inputenc}` + `[T1]{fontenc}`; `babel`/`ngerman`;
  umlauts render and are copy/paste/searchable.
- **Layout/Overleaf:** package under `latex/fgdh-thesis/` + `bst/`; per-folder + root `latexmkrc`;
  the release `template.zip` is flat (class beside `thesis.tex`) → no Overleaf shim needed.
- **Bibliography:** BibTeX + `natbib`, DIN 1505 `fgdh-thesis-nat.bst`; `latexmk` auto-runs it; 0 undefined citations.
- **Licensing:** dual LPPL 1.3c / CC BY 4.0; third-party DIN 1505 `.bst` preserved + noted; `wise.cls` alias kept.
- **Hygiene/distribution:** `.gitignore` clean; CI builds on push/PR; Release Please + flattened
  `template.zip` per tag; GitHub *template repository* enabled; CITATION/CHANGELOG maintained.
- **Build:** `template/`, `examples/{de,en}`, the `wise.cls` shim, and the flat ZIP all compile;
  the new AI-declaration section renders correctly in DE and EN.

*Regenerate this report (don't hand-edit it) with the vendor-neutral tooling in
[`tools/overleaf-conformance/`](../tools/overleaf-conformance/) after significant changes.*

# Third-Party Notices

This template bundles third-party files that are **not** covered by the repository's
own license ([LICENSE](LICENSE)). Each retains its original copyright and terms, kept
verbatim in the file header. They are redistributed here under those original terms.

If you ever **modify** any of these files, the conventional (and, for LPPL-style works,
required) practice is to **rename the file** and update its in-file author/support
contact so the modified version is not mistaken for the original.

---

## BibTeX styles — DIN 1505 (`natdin` / `alphadin`)

| Bundled file | Upstream | Description |
|---|---|---|
| `bst/wise/wisenat.bst` | `natdin.bst` v3.1 (2006-01-02) | DIN 1505 Teil 2+3, author–year labels, requires `natbib` |
| `bst/wise/wisenatnosc.bst` | `natdin.bst` v3.1, "no small caps" variant | as above, without small-caps author names |
| `bst/wise/wisealpha.bst` | `alphadin.bst` v8.2 (2006-01-02) | DIN 1505, alphabetic labels |

- **Copyright:** © 1994–2006 K.F. Lorenzen (`lorenzen.marxen@t-online.de`),
  HAW Hamburg. Upstream: <http://www.haw-hamburg.de/pers/Lorenzen/bibtex/>
- **Derivation:** developed from Oren Patashnik's standard BibTeX styles
  (`alpha`, and the `btxbst.doc` framework, "Copyright (C) 1985, all rights reserved",
  whose standard header — *"Copying of this file is authorized only if …"* — is retained
  inside the files).
- **Terms:** the original copyright notices and conditions are preserved in each file's
  header. These styles are **not** relicensed under this repository's LPPL/CC-BY terms.
  The `wise` prefix denotes the copy distributed with this template; the files are
  otherwise the upstream styles. If modified, rename and update the contact per the
  standard BibTeX-style header.

## Build/typesetting dependencies (NOT bundled — referenced from TeX Live)

These are loaded from the user's TeX Live / Overleaf installation and are listed here
for attribution only; their source is **not** included in this repository:

- **KOMA-Script** (`scrartcl`, `scrlayer-scrpage`) — © Markus Kohm; LPPL 1.3c.
  `wise.cls` is built on `scrartcl`.
- **natbib** — © Patrick W. Daly; LPPL. Required by the DIN 1505 `.bst` styles above.
- Standard CTAN packages (`geometry`, `graphicx`, `hyperref`, `babel`, `setspace`,
  `times`, …) under their respective licenses.

---

*If you believe any attribution here is incomplete or incorrect, please open an issue:*
<https://github.com/forschungsgruppe-digital-health/thesis-latex-template/issues>

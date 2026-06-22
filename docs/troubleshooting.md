# Troubleshooting / FAQ

| Symptom | Cause & fix |
|---|---|
| `File 'fgdh-thesis.cls' not found` on Overleaf | Overleaf doesn't search subfolders. Use the **release ZIP** (the class sits next to `thesis.tex`), or keep the root [`latexmkrc`](../latexmkrc) which adds `texmf/` to the search path. |
| `File 'fgdh-thesis.cls' not found` locally | Build from the project root (the `latexmkrc` shim is root-relative), or use the dev container (workspace-wide search path). |
| Umlauts look wrong / `Invalid UTF-8 byte` | Save the file as **UTF-8** (not Latin-1/Latin-9). The class expects UTF-8; mixing encodings corrupts umlauts. |
| Citations show as `[?]` / undefined | Run the full cycle (pdfLaTeX → **BibTeX** → pdfLaTeX×2). `latexmk` does this; a single pdfLaTeX run isn't enough. Check the `\cite{key}` matches a key in `references.bib`. |
| Wrong engine | This template is **pdfLaTeX**, not XeLaTeX/LuaLaTeX. On Overleaf set Menu → Settings → Compiler → *pdfLaTeX*. |
| biber vs bibtex confusion | This template uses classic **BibTeX** + `natbib` (DIN 1505 `wisenat` style), not biber/biblatex. Don't switch the backend. |
| The "Open in Overleaf" badge didn't land me in ZIH | Expected — the badge targets **overleaf.com** only. For TU Dresden ZIH, download the release ZIP and *New Project → Upload Project*. |
| My ZIH project disappeared | ZIH deletes projects/accounts inactive for **90 days**. Keep GitHub (or a local clone) as the durable copy and re-upload when needed. |
| Need a 4th numbered heading level | Add the `xlevel` class option. |

Still stuck? Open an issue:
<https://github.com/forschungsgruppe-digital-health/thesis-latex-template/issues>

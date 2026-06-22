# Filling in the template

How to turn the [`template/`](../template/) starter into your thesis. Placeholders in
`thesis.tex` are marked `« … »` — replace each (including the guillemets).

## 1. Choose your thesis type & title page

`thesis.tex` uses `\bachelortitlepage`. Swap it for your type — all take the **same 8
arguments**:

| Command | Use for |
|---|---|
| `\bachelortitlepage` | Bachelor's thesis |
| `\mastertitlepage` | Master's thesis |
| `\diplomatitlepage` | Diploma thesis |
| `\dissertationtitlepage` | Doctoral dissertation |
| `\seminartitlepage` / `\projecttitlepage` | seminar / project report (4 arguments) |

Arguments, in order:

```latex
\bachelortitlepage
  {Title}{Degree}{Author}{Student ID}{Supervisor 1}{Supervisor 2}{Start date}{End date}
```

## 2. Language

German is the default. For an English thesis add the `en` class option:

```latex
\documentclass[hyperref, nat, en]{wise}
```

## 3. Write content

- Add chapters with `\section{…}` (and `\subsection`, …). Add the `xlevel` class option
  for a 4th numbered level.
- Split big chapters into separate files and pull them in with `\include{chaptername}`.
- Cross-reference with `\label{sec:foo}` … `\ref{sec:foo}`.

## 4. Figures

Put images in [`figures/`](../template/figures/) and include them:

```latex
\begin{figure}[H]\centering
  \includegraphics[width=\textwidth]{figures/myplot}
  \caption{Caption}\label{fig:myplot}
\end{figure}
```

## 5. Citations & bibliography

- Add entries to [`references.bib`](../template/references.bib) (use JabRef/Zotero).
- Cite with `\cite{key}`. The style is `wisenat` (DIN 1505, author–year) — already set via
  `\bibliographystyle{wisenat}` + `\bibliography{references}`.
- Build order is pdfLaTeX → BibTeX → pdfLaTeX×2; `latexmk` does this automatically.

## 6. Abbreviations

```latex
\listofabbreviations
\abbreviation{z.\,B.}{zum Beispiel}
```

## 7. Compile

- **Dev container / VS Code:** open `template/thesis.tex` and Build (see
  [devcontainer.md](devcontainer.md)).
- **Command line:** `latexmk thesis.tex` from inside `template/`.
- **Overleaf:** upload the release ZIP (a flattened copy of `template/`) — see the
  [README](../README.md) onboarding paths.

Trouble? Common issues are collected in [troubleshooting.md](troubleshooting.md).

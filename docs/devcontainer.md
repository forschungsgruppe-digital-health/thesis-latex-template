# Local LaTeX environment (Dev Container)

This repository ships a [VS Code Dev Container](https://code.visualstudio.com/docs/devcontainers/create-dev-container)
that gives you a complete, reproducible LaTeX setup — a local alternative to cloud
Overleaf. You get the **full TeX Live** distribution plus the **LaTeX Workshop** editor
extension with build-on-save, an integrated PDF preview, SyncTeX, and `chktex` linting.

It is per-project: the environment is defined by
[`.devcontainer/devcontainer.json`](../.devcontainer/devcontainer.json) and versioned
with the repository, so everyone gets the same TeX Live, extensions, and build settings.

## Prerequisites

- [Docker](https://www.docker.com/) (Desktop on macOS/Windows, Engine on Linux)
- [VS Code](https://code.visualstudio.com/) with the **Dev Containers** extension
  (`ms-vscode-remote.remote-containers`)

## Use it

1. Clone the repo and open the folder in VS Code.
2. Command Palette → **Dev Containers: Reopen in Container**.
   The first build pulls the TeX Live image (several GB) — subsequent starts are fast.
3. Open a `.tex` file (e.g. `examples/de/thesis-de.tex`).
4. **Build:** save the file (build-on-save is enabled) or click the green ▶ (TeX badge →
   *Build LaTeX project*). The PDF opens in a side tab.
5. **Navigate:** `Ctrl/Cmd+Alt+J` jumps from source to PDF (forward SyncTeX);
   `Ctrl+click` in the PDF jumps back to the source.

## How it finds the custom class

The container sets `TEXINPUTS`/`BSTINPUTS`/`BIBINPUTS` to search the whole workspace
recursively, so `fgdh-thesis.cls` (under `latex/`) and the DIN 1505 `.bst` files (under
`bst/`) are found no matter which folder your document lives in — no manual TEXMF setup.
(The root [`latexmkrc`](../latexmkrc) does the same for command-line `latexmk` and for
Overleaf.)

## Output parity with Overleaf

The container uses `texlive/texlive:latest`, matching **TU Dresden's ZIH Overleaf/tex
service**, which runs the rolling `latest` TeX Live — so the container compiles against
the same toolchain students actually use.

If you instead target **overleaf.com**, note it pins each project to its creation-time
TeX Live and never auto-upgrades; for **identical output** there, pin this image to that
project's year by editing `.devcontainer/devcontainer.json`:

```jsonc
// e.g. match an overleaf.com project on TeX Live 2025:
"image": "texlive/texlive:TL2025-historic"
```

See [maintainer/decision-log.md](maintainer/decision-log.md) (D6, O1).

## Performance & offline notes

- The full-scheme image compiles **offline** — no `tlmgr install` / network needed.
- On macOS/Windows, bind mounts run through a VM and can be slow for write-heavy caches;
  if rebuilds feel slow you can add a Docker **named volume** for build artifacts via the
  `mounts` property in `devcontainer.json`.

## Troubleshooting

| Symptom | Fix |
|---|---|
| `File 'fgdh-thesis.cls' not found` | Ensure you opened the **repository root** as the workspace (the recursive `TEXINPUTS` is relative to it). |
| Umlauts look wrong in the PDF | Known class encoding bug — see the [conformance report](overleaf-conformance-report.md); not specific to the container. |
| PDF preview doesn't refresh | Run *LaTeX Workshop: Build LaTeX project* once; check the LaTeX Workshop output panel for errors. |
| First start is very slow | Expected — it's pulling multi-GB TeX Live. Later starts reuse the image. |

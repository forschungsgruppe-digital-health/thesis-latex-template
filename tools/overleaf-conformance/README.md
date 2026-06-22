# Overleaf / custom-LaTeX conformance audit (vendor-neutral)

Audit a repository that ships a **custom LaTeX class/package meant to compile on Overleaf**
and produce a scored report. This tooling is **vendor-neutral** — it is plain Markdown + a
POSIX shell script, usable by **any** AI assistant (Claude, Cursor, Aider, Copilot, …) or by
a human, with no vendor-specific runtime.

## Contents

- **[`conformance-checklist.md`](conformance-checklist.md)** — the scored checklist (ids
  `PKG`/`ENC`/`OVL`/`LIC`/`REPO`/`DEV`/`BUILD`, each with a severity and a concrete
  *how-to-check*). This is the audit spec.
- **[`best-practices.md`](best-practices.md)** — the underlying, web-grounded best practices
  (refresh version-sensitive facts before relying on them).
- **[`scan.sh`](scan.sh)** — runs the automatable static checks and prints PASS/WARN/FAIL.

## Run it

```bash
# from the repository root
bash tools/overleaf-conformance/scan.sh .

# …or in a pinned TeX Live container (has iconv; note: no `file` — the script handles that)
docker run --rm -v "$PWD":/repo:ro texlive/texlive:TL2025-historic \
  bash /repo/tools/overleaf-conformance/scan.sh /repo
```

## Full audit (procedure for an agent or a human)

1. **Scope** the repo: the custom `.cls/.sty/.bst`, the main/example `.tex`, the engine, the bib backend.
2. **Static scan** — run `scan.sh` for the automatable items (encoding, packaging, layout, hygiene files).
3. **Build (BUILD-01)** — compile the main document end-to-end with `latexmk` on the pinned
   TeX Live; confirm exit 0, a PDF, and a resolved bibliography; render a page (e.g. with `gs`)
   to check that umlauts are correct and copy/paste-able.
4. **Judge the context items** the script can't (the checklist marks which) by reading the repo.
5. **Write/refresh** [`docs/overleaf-conformance-report.md`](../../docs/overleaf-conformance-report.md):
   a verdict, one row per checklist id (verdict · evidence · remediation), blockers first.

## For AI assistants

- **Any model/agent:** read this file and `conformance-checklist.md`, run `scan.sh`, follow the
  procedure above. Nothing here depends on a specific vendor. See also the repo's `AGENTS.md`.
- **Claude Code:** a thin skill at `.claude/skills/overleaf-conformance/SKILL.md` simply points here.

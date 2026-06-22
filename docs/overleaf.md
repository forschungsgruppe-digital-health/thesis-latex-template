# Using the template on Overleaf (TU Dresden ZIH & cloud)

You do **not** need to understand LaTeX internals or install anything to write your thesis
with this template on Overleaf. Pick the path that fits you.

- **Just want to write?** → Path 1 (upload the ZIP). No Git, no install.
- **Want a backup / to sync with Git?** → Path 2 (the Git integration, token-based).

> **TU Dresden ZIH Overleaf:** <https://tex.zih.tu-dresden.de> (log in with your ZIH/SSO
> login). It is a self-hosted Overleaf, so the automatic *github.com* sync is **not**
> available here — use the ZIP upload or the Git integration (token) described below.

---

## Path 1 — Upload the template (easiest, no Git)

1. Download the template as a ZIP: from the
   [latest release](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/releases/latest)
   grab **`template.zip`** (it is a *flat* project — the class sits next to `thesis.tex`,
   so Overleaf compiles it with zero setup).
2. Open **<https://tex.zih.tu-dresden.de>** and log in.
3. **New Project → Upload Project →** select `template.zip`.
4. Open `thesis.tex`. In **Menu → Settings**, set **Compiler = pdfLaTeX** (this template is
   pdfLaTeX, and the bibliography uses BibTeX — Overleaf runs it automatically).
5. Click **Recompile**. Done — now fill in the `« … »` placeholders
   (see [filling-in.md](filling-in.md)).

On the public cloud (<https://overleaf.com>) you can instead click the **Open in Overleaf**
badge in the [README](../README.md).

> ⚠️ **ZIH deletes projects/accounts inactive for 90 days.** Keep a durable copy — the
> simplest is to download your project occasionally, or use the Git backup in Path 2.

---

## Path 2 — Git integration (token-based access)

ZIH Overleaf lets you **clone each project as a Git repository**, using a personal
*authentication token* as the password. This enables local editing and, importantly, a
backup of your work.

### 2a. Generate a token (once)

**Account Settings → Project synchronisation → Git integration → Generate token.**
Copy it immediately and store it in a password manager — **it is shown only once**, you can
have up to 10, and it expires after about a year. **Never commit a token** to a repository.

### 2b. Clone your project

In the project, open **Menu → Git** (or the *Integrations* menu) and copy the shown
`git clone …` command, then run it. When prompted:

- **Username:** `git`
- **Password:** paste your **token**

```bash
git clone https://git@tex.zih.tu-dresden.de/git/<your-project-id>
# Username: git    Password: <your token>
```

(Tip: enable a Git *credential helper* so you don't re-enter the token each time.)
Now edit locally, `git commit`, and `git push` to send changes back to Overleaf.

### 2c. Back up your thesis to your own GitHub (recommended)

This removes the single-point-of-failure of the 90-day deletion:

```bash
# after cloning your Overleaf project (2b):
git remote add backup git@github.com:<you>/<your-thesis>.git   # a PRIVATE repo
git push backup
```

Push to `backup` now and then — your thesis survives even if the Overleaf project is
idle-deleted. (Re-create the Overleaf project from your backup any time.)

---

## For maintainers — a canonical Overleaf project (optional)

You can keep one canonical template project on ZIH Overleaf and refresh it from this GitHub
repository after each release, via the Git integration (token). Keep the flow **one-way,
GitHub → Overleaf**: GitHub remains the single source of truth (real versioning, tags, PRs,
CI live here). The Git bridge is single-branch with just-in-time, mis-attributed commits,
so don't rely on it for history. If the 90-day deletion removes the canonical project,
just re-seed it from a fresh release ZIP — nothing is lost.

---

## Quick reference

| | |
|---|---|
| ZIH Overleaf | <https://tex.zih.tu-dresden.de> (SSO) |
| Engine | **pdfLaTeX** (Menu → Settings → Compiler) |
| Bibliography | **BibTeX** (run automatically) |
| Easiest start | upload `template.zip` from the latest release |
| Git password | your **Git authentication token** (username `git`) |
| Backup | clone via Git → push to a private GitHub repo |
| Gotcha | 90-day inactivity deletion; no github.com auto-sync (self-hosted) |

# FGDH Thesis LaTeX Template — Maintainer Setup Plan (Chain-of-Thought)

> **Purpose.** A reasoning-first checklist for migrating and improving the FGDH thesis
> LaTeX template so that students can use it easily via **GitHub** and **Overleaf**
> (incl. the self-hosted TU Dresden ZIH instance).
> **How to use.** Hand this file to Claude Code. Each step is written as
> *Thought (why) → Action (what) → Done-when (acceptance check)*. Execute top-to-bottom;
> do not skip Phase 0, because two later decisions depend on its outcome.
>
> Source repo: `https://github.com/helict/fgdh-thesis-latex-template`
> Target org:  `https://github.com/forschungsgruppe-digital-health`
> ZIH Overleaf: `https://tex.zih.tu-dresden.de` (SSO login)

---

## Operating constraints (read first)

These are the facts that shape every decision below. Verify the ones marked **(verify)**.

1. **ZIH is self-hosted.** Direct GitHub Synchronization works only against `github.com`
   and not against enterprise/self-hosted instances. **It will not work on ZIH.**
2. **Git-bridge is confirmed available on ZIH (RESOLVED).** The ZIH instance exposes
   Git integration with view-once authentication tokens, which means it is **Server Pro
   4.0+** with the bridge enabled (the bridge does not exist in Community Edition). This
   makes each Overleaf *project* cloneable as a git remote (token = password).
   **Caveat:** this is NOT the same as GitHub Synchronization. The direct Overleaf↔github.com
   link is cloud-only and github.com-only and remains unavailable here — GitHub is connected
   manually via a local clone with a second remote, not automatically.
3. **90-day auto-deletion on ZIH.** Projects/accounts inactive for 90 days are deleted.
   Treat GitHub (or a local clone) as the durable copy; say so in student docs.
4. **Design principle.** GitHub is the single source of truth. Overleaf is a consumption
   target reached via (a) release ZIP upload or (b) an "Open in Overleaf" badge for cloud
   users. No student workflow may depend on live GitHub↔Overleaf sync.

---

## Phase 0 — Discover & decide

### 0.1 Audit the current repo
- **Thought.** Last release was 2022 and layout uses a `texmf/` tree; we need an exact
  inventory before changing anything, because the `texmf/` handling is the main Overleaf
  risk.
- **Action.** Clone `helict/fgdh-thesis-latex-template`. Produce a tree listing. Identify:
  the main `.tex` entry file, all custom `.cls`/`.sty` under `texmf/`, the example theses
  (`Beispielarbeit/`), the existing docs PDFs (`Dokumentation/`, `Einfuehrung.pdf`),
  and the bibliography style/citation setup.
- **Done-when.** A short `INVENTORY.md` (scratch) lists entry file, class/style files with
  paths, fonts/encoding (check `inputenc`/`fontspec`), the bib backend (biber vs bibtex),
  and the engine (pdflatex/xelatex/lualatex).

### 0.2 ZIH Overleaf edition & capabilities (RESOLVED — keep remaining sub-questions)
- **Thought.** Whether we offer a maintainer Git-bridge path depends on the edition.
- **Resolved.** Git integration with auth tokens is enabled → **Server Pro 4.0+, Git-bridge
  on**. The maintainer sync path (3.5) is therefore unlocked, not gated. GitHub
  Synchronization remains unavailable (self-hosted).
- **Action (still confirm with ZIH Service Desk):** (a) exact Server Pro version;
  (b) the TeX Live year/version installed; (c) whether the `/docs?snip_uri=` "Open in
  Overleaf" endpoint is enabled on the ZIH host.
- **Done-when.** Remaining answers recorded in `INVENTORY.md` and the decision log.

### 0.3 Decide engine & TeX Live baseline
- **Thought.** "Works on my machine" failures come from engine/TeX-Live mismatches between
  local, GitHub CI, and the ZIH Overleaf TeX Live.
- **Action.** Pick the engine the template actually needs. Pin CI to a TeX Live version
  matching (or close to) ZIH's. Document the assumed version.
- **Done-when.** A single documented engine + TeX Live target that CI and Overleaf both
  satisfy.

---

## Phase 1 — Repository on the new org

### 1.1 Migrate to `forschungsgruppe-digital-health`
- **Thought.** Preserve history and issues; a fresh copy-paste loses provenance.
- **Action.** Transfer or mirror-push the repo into the new org. Choose a clear name
  (recommended: `thesis-latex-template`). Keep `helict/...` as an archived redirect or add
  a deprecation note pointing to the new location.
- **Done-when.** New repo exists under the org with full commit history; old repo README
  links to the new one.

### 1.2 Rename default branch `master` → `main`
- **Thought.** Current default is `master`; modern Overleaf Git tooling and CI default to
  `main`, and badge/ZIP URLs must reference the right branch.
- **Action.** Rename the default branch to `main`; update any hard-coded `master`
  references in docs, CI, and badge URLs.
- **Done-when.** Default branch is `main`; no `master` strings remain in tracked files.

### 1.3 Make it a GitHub *template repository*
- **Thought.** Gives git-savvy students a one-click "Use this template" start that is
  independent of Overleaf.
- **Action.** Enable the "Template repository" setting. Add repo topics
  (`latex`, `thesis`, `template`, `overleaf`, `tu-dresden`) and a concise description.
- **Done-when.** "Use this template" button appears; topics set.

### 1.4 Licensing & metadata
- **Thought.** A template students copy needs an explicit, permissive license, or its
  reuse status is ambiguous.
- **Action.** Add a `LICENSE` (e.g. a permissive license for the template scaffolding;
  keep any third-party class files under their own terms and note them). Add `CITATION.cff`
  if you want the template itself citable.
- **Done-when.** `LICENSE` present and referenced from the README.

---

## Phase 2 — Overleaf compatibility (the make-or-break phase)

### 2.1 Prove a clean ZIP compiles on Overleaf
- **Thought.** The universal student path is "download ZIP → New Project → Upload Project",
  which works on *any* Overleaf incl. ZIH. It must compile with zero manual fixes.
- **Action.** Build a release ZIP of the template (not the whole repo — exclude docs PDFs,
  CI, dev files). Upload it to ZIH Overleaf as a fresh project and compile.
- **Done-when.** The uploaded ZIP compiles to PDF on ZIH Overleaf with no missing-file or
  class-not-found errors.

### 2.2 Resolve the `texmf/` custom-class problem
- **Thought.** Overleaf does not auto-treat a `texmf/` subtree as a TEXMF root, so custom
  `.cls`/`.sty` placed only under `texmf/` may be unfindable — the most likely 2.1 failure.
- **Action.** Choose one and document it:
  - **(A) Flatten:** place `.cls`/`.sty` so they are reachable from the main file
    (root or a known input path); simplest for students. *Preferred for the student ZIP.*
  - **(B) Keep tree, add a path shim:** only if confirmed to work on ZIH's edition.
  Re-run 2.1 after the change.
- **Done-when.** A naïve upload-and-compile works for a first-time user with no extra steps.

### 2.3 Main file at root + sensible defaults
- **Thought.** Overleaf picks a main document; ambiguity confuses students.
- **Action.** Ensure exactly one obvious top-level entry `.tex`. Set a `% !TeX` magic
  comment / `latexmkrc` so the engine and bib tool are unambiguous on Overleaf.
- **Done-when.** Overleaf auto-selects the correct main file; recompile is one click.

### 2.4 Strip a clean "starter" from the "example"
- **Thought.** Students should start from a minimal skeleton, not delete a full sample
  thesis. Keep the rich example separately as reference.
- **Action.** Provide `template/` (minimal, fill-in-the-blanks) and keep
  `examples/` (the existing DE/EN Beispielarbeiten) as read-only references.
- **Done-when.** Both compile; the release ZIP ships the minimal `template/`.

---

## Phase 3 — Distribution mechanics

### 3.1 GitHub Actions: compile on push and PR
- **Thought.** CI guarantees the template and examples always build, catching breakage
  before students hit it.
- **Action.** Add a workflow that compiles `template/` and both examples on every push/PR
  using the pinned TeX Live, and uploads the PDFs as build artifacts.
- **Done-when.** Green CI badge; PDFs downloadable from the Actions run.

### 3.2 GitHub Actions: release ZIP on tag
- **Thought.** Students need a stable, clean "latest template" download, not the dev repo.
- **Action.** On tag `v*`, build the curated `template.zip` (only files students need) and
  attach it to a GitHub Release. Use semantic version tags.
- **Done-when.** A tagged release exposes `template.zip` at a stable URL.

### 3.3 "Open in Overleaf" badge (cloud users)
- **Thought.** One-click onboarding for students who use the free Overleaf cloud (not ZIH).
- **Action.** Add a README badge linking to
  `https://www.overleaf.com/docs?snip_uri=https://github.com/forschungsgruppe-digital-health/thesis-latex-template/archive/refs/heads/main.zip`
  (or point `snip_uri` at the release ZIP for stability). Label it clearly as **cloud only**.
- **Done-when.** Clicking the badge creates a compiling project on overleaf.com.

### 3.4 ZIH-specific onboarding note
- **Thought.** The badge does NOT land students in ZIH; they must upload manually.
- **Action.** Document the ZIH path explicitly: download release ZIP → `tex.zih.tu-dresden.de`
  → New Project → Upload Project → compile. Add the 90-day-deletion + backup warning here.
- **Done-when.** A ZIH student can go from zero to compiling PDF following only the README.

### 3.5 (Maintainer) Canonical Overleaf template project synced to GitHub via Git-bridge
- **Thought.** With the bridge confirmed, the maintainer can keep one canonical Overleaf
  project on ZIH in sync with the GitHub repo, so the in-Overleaf "template" students see
  stays current. GitHub stays the source of truth — the bridge is single-branch with
  just-in-time, mis-attributed commits, so real versioning (tags, branches, PRs) lives on
  GitHub, not in Overleaf.
- **Action.**
  1. Create the canonical template as an Overleaf project on ZIH.
  2. Generate a Git auth token in Overleaf account settings (view-once — copy and store in
     a password manager; **never commit it**; treat it as the clone password).
  3. Clone the project locally via the Git-bridge URL; add the GitHub repo as a second
     remote; reconcile so GitHub is authoritative.
  4. Document the one-way refresh routine: GitHub `main` → local → push to the Overleaf
     remote after each release.
- **Caveats to document.** (a) 90-day inactivity can delete the canonical Overleaf project;
  re-seed it from GitHub if that happens — losing it costs nothing because GitHub is the
  source of truth. (b) Single linear history, branch `main` (older clones `master`);
  no branching through the bridge. (c) Symlinks are converted to regular files.
- **Done-when.** A documented maintainer routine refreshes the Overleaf project from a
  GitHub release; no token is stored in the repo.

### 3.6 (Optional) Publish to the Overleaf Template Gallery
- **Thought.** Increases reach beyond TUD; cloud-only and separate from ZIH.
- **Action.** Decide whether to submit a cloud project to the public template gallery.
- **Done-when.** A go/no-go decision recorded.

### 3.7 (Student, optional) Back up your thesis with Git — mitigates the 90-day deletion
- **Thought.** The bridge gives git-comfortable students a real durability path: clone the
  ZIH project and push it to their *own* private GitHub repo, so an idle-deleted Overleaf
  project is no longer a single point of failure. This is opt-in; it does not replace the
  ZIP/badge onboarding (the bridge does not make the *first* copy easier).
- **Action (student-facing docs).** Walk through: generate a personal Git auth token in
  Overleaf settings → clone the project (token as password) → add a private GitHub repo as
  a remote → push. Stress: the token is shown once, is personal, and must never be
  committed; pull/push periodically so the backup stays current.
- **Done-when.** A git-comfortable student can establish a working personal backup from the
  docs alone.

---

## Phase 4 — Student-facing documentation

> Write student docs **bilingual (DE + EN)**: the template is German-context but
> international students and reviewers benefit from English. Keep technical terms in English.

### 4.1 README quickstart with two clearly separated paths
- **Thought.** Students self-select; mixing paths causes confusion.
- **Action.** Top of README: a 5-line "Get started" with two tabs/sections —
  **Overleaf (ZIH or cloud)** and **Local / Git**. Each ends in a compiling PDF.
- **Done-when.** A newcomer reaches a PDF in under 5 minutes by one path.

### 4.2 "Filling in the template" guide
- **Thought.** Students need to know *where* to put title, author, chair, supervisor,
  abstract, bibliography entries — not just how to compile.
- **Action.** Document the metadata/config file(s), how to add chapters, how to cite, and
  the expected bib workflow (biber/bibtex). Reuse/refresh the existing `Zitieren` doc.
- **Done-when.** Each editable field is documented with file + location.

### 4.3 Troubleshooting / FAQ
- **Thought.** Predictable failure modes should be answered before they email you.
- **Action.** Cover: class-not-found after upload (→ Phase 2 fix), wrong engine, biber vs
  bibtex, fonts/encoding, ZIH 90-day deletion, "badge didn't open in ZIH" (expected).
- **Done-when.** The top failure modes from 2.1/3.x each have an entry.

### 4.4 Keep heavy PDFs out of the clone path
- **Thought.** Shipping large compiled PDFs bloats the student ZIP and clones.
- **Action.** Serve documentation PDFs via Releases or a `docs/` area, not inside the
  student `template/` ZIP. Link to them from the README.
- **Done-when.** Student ZIP contains only source needed to compile.

---

## Phase 5 — Maintainer documentation & governance

### 5.1 `CONTRIBUTING.md` + update routine
- **Thought.** "Slightly outdated" happens when updating is undocumented.
- **Action.** Document how to change the template, run CI locally, cut a release, and
  (if applicable) push the canonical Overleaf project.
- **Done-when.** A new maintainer can ship a release from the docs alone.

### 5.2 `AGENTS.md` for agent-assisted maintenance
- **Thought.** You intend to use Claude Code; encode build/release facts as a single source
  of truth so future agent runs are deterministic.
- **Action.** Record engine, TeX Live target, build commands, release process, and the
  Phase 2 `texmf` decision in `AGENTS.md`.
- **Done-when.** An agent can build and release using only `AGENTS.md`.

### 5.3 Versioning & changelog
- **Thought.** Students should know which template version they're on.
- **Action.** Adopt semantic version tags; maintain `CHANGELOG.md`; optionally print the
  template version on the title page or in a comment.
- **Done-when.** Each release has a changelog entry and a tag.

---

## Phase 6 — End-to-end validation (act as a first-time student)

### 6.1 ZIH dry run
- **Action.** From a clean state, follow only the README ZIH path on `tex.zih.tu-dresden.de`.
- **Done-when.** Compiling PDF with zero undocumented steps.

### 6.2 Cloud badge dry run
- **Action.** Click the "Open in Overleaf" badge on overleaf.com from a fresh account.
- **Done-when.** Compiling project with no manual fixes.

### 6.3 Local/Git dry run
- **Action.** "Use this template" → clone → compile locally and confirm CI is green.
- **Done-when.** Local PDF matches CI artifact.

### 6.4 Sign-off
- **Action.** Tick every "Done-when" above; file issues for anything deferred.
- **Done-when.** All three student paths verified and documented.

---

## Decision log

| Question | Answer | Affects |
|---|---|---|
| ZIH edition (Community / Server Pro x.y) | **Server Pro 4.0+** (Git tokens present) — confirm exact version | 3.5 |
| Git-bridge enabled on ZIH? | **Yes** (auth tokens, up to 10, view-once) | 3.5, 3.7 |
| ZIH TeX Live version | _____ (confirm with Service Desk) | 0.3, 3.1 |
| `/docs?snip_uri=` enabled on ZIH host? | _____ (confirm with Service Desk) | 3.3 badge target |
| Engine (pdf/xe/lua) | _____ | all builds |
| `texmf` strategy (flatten / shim) | _____ | 2.2 |

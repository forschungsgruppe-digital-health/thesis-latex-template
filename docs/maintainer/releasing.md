# Releasing

Releases use **[Release Please](https://github.com/googleapis/release-please)** +
**[Semantic Versioning](https://semver.org/)**, driven by **Conventional Commits** on a
**protected `main`** branch. Maintainers do not bump versions or edit the changelog by
hand — they merge a release PR.

## How it works

1. Work lands on `main` (via PR from `dev`/feature branches) using
   [Conventional Commits](https://www.conventionalcommits.org/): `feat:`, `fix:`,
   `docs:`, `chore:`, `refactor:`, … A `feat:` → MINOR bump, `fix:` → PATCH,
   `feat!:`/`BREAKING CHANGE:` → MAJOR.
2. The [`release-please`](../../.github/workflows/release-please.yml) workflow opens (and
   keeps updating) a **release PR** that bumps the version in
   `.release-please-manifest.json` and `CITATION.cff`, and regenerates the `CHANGELOG.md`
   section from the commits.
3. **Merging the release PR** creates the Git tag `vX.Y.Z` and the GitHub Release; the
   `release-assets` job then builds the PDFs + a curated, **flattened** `template.zip`
   and attaches them (the stable *Open in Overleaf* target).

Config: [`release-please-config.json`](../../release-please-config.json) (release-type
`simple`; `CITATION.cff` kept in sync via the version line). The class version in
`wise.cls` (`\ProvidesClass{wise}[YYYY/MM/DD vX.Y.Z …]`) is **bumped manually** at release
time (the date there is the LaTeX version-comparison date) — update it in the release PR.

## Protected `main` — required settings

Enable on GitHub (Settings → Branches → add rule for `main`):

- Require a pull request before merging (no direct pushes).
- Require status checks to pass → select the **`ci` / build** check.
- Require branches to be up to date before merging.
- Recommended: require linear history; restrict who can push; include administrators.
- Allow GitHub Actions to create/approve PRs (Settings → Actions → General) so
  release-please can open its release PR.

> These are repo-admin settings and are not committed in the repo. Ask the maintainers
> (or run `gh api` with admin rights) to apply them.

## Versioning roadmap (phased)

Per the migration plan, the package keeps the **`wise`** name first, then is renamed:

1. **Fix + improve** (current): encoding, hygiene, docs/usage — all under `wise`.
2. **Legacy `wise` release** (`v1.x`): the modernized-but-still-`wise` class, so existing
   users upgrade with no rename. (Bootstrap baseline is `1.0.0`; the encoding/hygiene work
   should land as `fix:`/`feat:` commits → release-please cuts `1.1.0`.)
3. **`fgdh-thesis` rename + release** (`v2.0.0`, a breaking change): rename the class
   (`\documentclass{fgdh-thesis}`), keeping a thin `wise.cls` shim that loads
   `fgdh-thesis` and warns, so old documents keep compiling.

## Cutting a release (maintainer checklist)

1. Ensure CI is green on `main`.
2. Review the open **release-please** PR (version bump + CHANGELOG). Adjust the manual
   `wise.cls` version/date in that PR if needed.
3. Merge it. Confirm the tag, GitHub Release, and attached `template.zip` + PDFs.
4. Point the README "Open in Overleaf" badge `snip_uri` at the new release ZIP.

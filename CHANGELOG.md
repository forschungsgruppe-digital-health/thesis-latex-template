# Changelog

All notable changes to this project are documented here.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
From the next release onward this file is **maintained automatically by Release Please**
from Conventional Commits — see [docs/maintainer/releasing.md](docs/maintainer/releasing.md).

## [3.1.0](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/compare/v3.0.0...v3.1.0) (2026-06-23)


### Features

* add AI-use declaration section; vendor-neutral conformance tooling ([89d62a5](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/commit/89d62a54619a1faa84537f26e4df7504d2005596))
* add the AI-use declaration section (DE + EN) ([8977f14](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/commit/8977f141d76912b943ec7aa5d9450ca833b842d3))

## [3.0.0](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/compare/v2.0.0...v3.0.0) (2026-06-22)


### ⚠ BREAKING CHANGES

* the bibliography style is now fgdh-thesis-nat (was wisenat); update \bibliographystyle{...} in existing documents.

### Code Refactoring

* rename bundled bst styles and internal macros from wise to fgdh-thesis ([d61a29b](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/commit/d61a29b24abfbcae98a1784bb7d88fd05027e8f1))

## [2.0.0](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/compare/v1.1.0...v2.0.0) (2026-06-22)


### ⚠ BREAKING CHANGES

* the class is now named fgdh-thesis. \documentclass{wise} still works via a deprecated alias that emits a warning; switch to \documentclass{fgdh-thesis}.

### Features

* rename the wise document class to fgdh-thesis ([78c76c0](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/commit/78c76c01dc21f1aa8f6523a71def804a10695ee6))

## [1.1.0](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/compare/v1.0.0...v1.1.0) (2026-06-22)


### Features

* add latexmkrc search-path shim for the bundled class ([8215d8b](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/commit/8215d8bb1c58f0e3d839d443c4f3dfef4659711f))
* add licensing, community health files, and editorconfig ([fe52d49](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/commit/fe52d497a43c2075b66c29eff7333480894ac7c4))
* add minimal template/ thesis starter and student guides ([d8bdf67](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/commit/d8bdf675aace3e7a38e52a8985ff502e633404f9))
* add VS Code dev container for local LaTeX authoring ([19fd434](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/commit/19fd43449644184caa5af1a1d61e3db79b7ab188))
* modernize the wise thesis template (UTF-8, tooling, docs, release automation) ([81c3eca](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/commit/81c3eca3374a45a23b819a50950e0c63281cd22b))


### Bug Fixes

* convert sources to UTF-8 and load T1 fontenc ([bb4ed51](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/commit/bb4ed517edc004e07256e0f13570b78517fb0748))
* correct EN title-page arguments and ProvidesPackage names ([b3a10f0](https://github.com/forschungsgruppe-digital-health/thesis-latex-template/commit/b3a10f020a6a8ef023bde39e2f2ca09ba563d877))

## [1.x] — 2022 and earlier

- Original `wise`-based template (Malte Helmhold, 2012) with German/English example
  theses, maintained under `helict/fgdh-thesis-latex-template`; chair renamed to
  *Research Group Digital Health*. See the Git history for details.

# latexmkrc — makes this template compile even though the custom class/styles/bst
# live in a subfolder (texmf/), both locally (latexmk) and on Overleaf.
#
# Why this file exists: Overleaf does NOT search project subfolders for .cls/.sty/.bst
# files, and plain kpathsea only searches the current dir + TEXMF trees. This file
# prepends the bundled tree to the search paths so the files are found from the root.
# (Overleaf reads a root file named exactly "latexmkrc" — no leading dot.)
#
# Verified: pdflatex + bibtex resolve wise.cls and wisenat.bst with this shim.
# NOTE: for the *distributed* student ZIP the preferred layout is to flatten the
# class beside the main .tex (see docs/maintainer/repo-structure.md), which needs
# no shim at all.

# Bundled custom package tree. "//" = search recursively; trailing ":" keeps the
# system TeX paths. Paths are relative to the project root (where latexmk runs).
$ENV{'TEXINPUTS'} = './texmf//:' . ($ENV{'TEXINPUTS'} // '');
$ENV{'BSTINPUTS'} = './texmf//:' . ($ENV{'BSTINPUTS'} // '');
$ENV{'BIBINPUTS'} = '.:'         . ($ENV{'BIBINPUTS'} // '');

# Engine: pdfLaTeX (this template is pdfLaTeX-only). On Overleaf the engine is also
# selectable in Menu > Settings; locally this makes `latexmk` do the right thing.
$pdf_mode = 1;   # 1 = pdflatex

# latexmk auto-detects and runs bibtex (the template uses BibTeX + natbib, not biber).
$bibtex_use = 2; # run bibtex when a .bib is referenced, even if not strictly required

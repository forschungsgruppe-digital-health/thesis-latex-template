# Root latexmkrc — whole-repo recursive search path, for building a document from the
# repository root (e.g. `latexmk template/thesis.tex`).
#
# For the usual workflow, build inside a document's own folder instead — each buildable
# folder (template/, examples/de, examples/en) ships its own latexmkrc, so
# `cd template && latexmk` just works. The dev container sets the same paths globally.
#
# The custom class + styles live under latex/ and the DIN 1505 .bst under bst/.
# "//" = search recursively; trailing ":" keeps the system TeX paths.
$ENV{'TEXINPUTS'} = './/:' . ($ENV{'TEXINPUTS'} // '');
$ENV{'BSTINPUTS'} = './/:' . ($ENV{'BSTINPUTS'} // '');
$ENV{'BIBINPUTS'} = './/:' . ($ENV{'BIBINPUTS'} // '');

# Engine: pdfLaTeX (this template is pdfLaTeX-only).
$pdf_mode = 1;   # 1 = pdflatex

# latexmk auto-detects and runs bibtex (the template uses BibTeX + natbib, not biber).
$bibtex_use = 2;

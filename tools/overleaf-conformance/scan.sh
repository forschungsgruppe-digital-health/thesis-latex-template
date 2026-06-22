#!/usr/bin/env bash
# Static portion of the Overleaf-conformance audit.
# Runs the automatable checklist checks (encoding, packaging, layout, hygiene files)
# and prints PASS/WARN/FAIL lines. It does NOT build (see BUILD-01) and does NOT judge
# items needing human/web context (OVL-06, LIC-05, etc.) — the skill handles those.
#
# Usage:  bash scan.sh [REPO_ROOT]   (defaults to the current directory)
# Exit code is always 0; this is an advisory report.

set -u
ROOT="${1:-.}"
cd "$ROOT" || { echo "cannot cd to $ROOT"; exit 0; }

pass(){ printf '  PASS  %-8s %s\n' "$1" "$2"; }
warn(){ printf '  WARN  %-8s %s\n' "$1" "$2"; }
fail(){ printf '  FAIL  %-8s %s\n' "$1" "$2"; }
info(){ printf '  ----  %-8s %s\n' "$1" "$2"; }

# Source files (skip VCS, build dirs, and the docs PDFs).
mapfile -t SRC < <(find . -type f \
  \( -name '*.tex' -o -name '*.cls' -o -name '*.sty' -o -name '*.bst' -o -name '*.bib' \) \
  -not -path './.git/*' 2>/dev/null | sort)
mapfile -t CLSSTY < <(printf '%s\n' "${SRC[@]}" | grep -E '\.(cls|sty)$')

echo "== ENCODING =="
# ENC-01 valid UTF-8 (ASCII is a subset), no BOM.
# Use iconv for the validity test (always present via glibc); fall back to `file` for a label.
bad_enc=(); bom=()
for f in "${SRC[@]}"; do
  if ! iconv -f UTF-8 -t UTF-8 "$f" >/dev/null 2>&1; then
    label=$(file -b "$f" 2>/dev/null); [ -n "$label" ] && label=" [$label]"
    bad_enc+=("$f${label}")
  fi
  if [ "$(head -c3 "$f" 2>/dev/null | xxd -p 2>/dev/null)" = "efbbbf" ]; then bom+=("$f"); fi
done
[ ${#bad_enc[@]} -eq 0 ] && pass ENC-01 "all sources utf-8/ascii" || { fail ENC-01 "non-UTF-8 sources:"; printf '            %s\n' "${bad_enc[@]}"; }
[ ${#bom[@]} -eq 0 ] && pass "ENC-01b" "no BOM" || { fail "ENC-01b" "BOM present: ${bom[*]}"; }

# ENC-02 legacy inputenc
if grep -arnE 'inputenc.*(latin[0-9]+|utf8x|ansinew|applemac)|\[(latin[0-9]+|utf8x)\]\{inputenc\}' --include='*.tex' --include='*.cls' --include='*.sty' . 2>/dev/null | grep -v '/.git/' >/tmp/enc2; then
  fail ENC-02 "legacy 8-bit inputenc found:"; sed 's/^/            /' /tmp/enc2
else pass ENC-02 "no legacy inputenc"; fi

# ENC-03 T1 fontenc (pdflatex assumption)
if grep -arlE '\[T1\]\{fontenc\}|\{fontenc\}.*T1|fontenc.*\bT1\b' --include='*.tex' --include='*.cls' --include='*.sty' . 2>/dev/null | grep -qv '/.git/'; then
  pass ENC-03 "[T1]{fontenc} present"
else fail ENC-03 "no [T1]{fontenc} (pdfLaTeX umlaut hyphenation/copy broken)"; fi

# ENC-05 babel ngerman
if grep -arqE 'ngerman' --include='*.tex' --include='*.cls' --include='*.sty' . 2>/dev/null; then pass ENC-05 "ngerman in use"; else warn ENC-05 "no ngerman found"; fi

echo "== PACKAGING =="
for f in "${CLSSTY[@]}"; do
  head1=$(grep -avE '^\s*%' "$f" | grep -avE '^\s*$' | head -1)
  case "$head1" in
    *'\NeedsTeXFormat{LaTeX2e}'*) pass PKG-01 "$f starts with \\NeedsTeXFormat";;
    *) warn PKG-01 "$f: first decl is not \\NeedsTeXFormat{LaTeX2e}";;
  esac
  if grep -aqE '\\Provides(Class|Package)\{[^}]+\}\[[0-9]{4}/[0-9]{2}/[0-9]{2} ' "$f"; then
    pass PKG-02 "$f has dated \\Provides… line"
  elif grep -aqE '\\Provides(Class|Package)\{[^}]+\}\[ ' "$f"; then
    fail PKG-02 "$f: \\Provides… opens with a space before the date"
  else
    warn PKG-02 "$f: \\Provides… missing/!YYYY/MM/DD date"
  fi
done

echo "== OVERLEAF LAYOUT =="
# OVL-01 custom cls/sty/bst in subfolders?
mapfile -t CUSTOM < <(find . -type f \( -name '*.cls' -o -name '*.sty' -o -name '*.bst' \) -not -path './.git/*' 2>/dev/null)
sub=0; for f in "${CUSTOM[@]}"; do [ "$(dirname "$f")" != "." ] && sub=$((sub+1)); done
have_latexmkrc=$([ -f ./latexmkrc ] && echo yes || echo no)
if [ "$sub" -gt 0 ]; then
  if [ "$have_latexmkrc" = yes ] && grep -qE "TEXINPUTS" ./latexmkrc; then
    warn OVL-01 "$sub custom files in subfolders, mitigated by root latexmkrc (flatten for the distributed ZIP)"
  else
    fail OVL-01 "$sub custom files in subfolders and no root latexmkrc TEXINPUTS shim"
  fi
else pass OVL-01 "custom files at root"; fi
# OVL-03 latexmkrc name/location
[ -f ./.latexmkrc ] && fail OVL-03 ".latexmkrc (dot) is not honoured by Overleaf — rename to latexmkrc"
[ -f ./latexmkrc ] && pass OVL-03 "root latexmkrc present" || info OVL-03 "no latexmkrc"
# OVL-04 magic comments
if grep -arqE '%\s*!\s*TeX (root|program)|TS-program' --include='*.tex' . 2>/dev/null; then warn OVL-04 "magic comments present (ignored by Overleaf)"; else pass OVL-04 "no relied-on magic comments"; fi
# OVL-05 shell-escape/network
if grep -arqE 'minted|--shell-escape|\\write18|\\input\{\s*\|' --include='*.tex' --include='*.cls' --include='*.sty' . 2>/dev/null; then warn OVL-05 "shell-escape/minted/write18 usage — verify self-hosted note"; else pass OVL-05 "no shell-escape/network deps"; fi

echo "== HYGIENE / FILES =="
chk(){ [ -e "$2" ] && pass "$1" "$2 present" || fail "$1" "$2 missing"; }
chk LIC-01 LICENSE
chk LIC-04 THIRD-PARTY-NOTICES.md
chk REPO-01 README.md
chk REPO-04a CONTRIBUTING.md
chk REPO-04b CODE_OF_CONDUCT.md
chk REPO-05 CITATION.cff
chk REPO-06 CHANGELOG.md
chk REPO-03 .gitignore
[ -f .devcontainer/devcontainer.json ] && pass DEV-01 ".devcontainer present" || warn DEV-01 "no .devcontainer"
[ -d .github/workflows ] && pass REPO-07 "CI workflows present" || warn REPO-07 "no .github/workflows (CI)"
# committed build cruft
if find . -path './.git' -prune -o \( -name '*.swp' -o -name '*.swo' -o -name '*.swn' -o -name '*.log' -o -name '*.aux' -o -name '*.fdb_latexmk' \) -type f -print 2>/dev/null | grep -q .; then
  warn HYGIENE "committed build/editor cruft found:"; find . -path './.git' -prune -o \( -name '*.swp' -o -name '*.swo' -o -name '*.swn' -o -name '*.log' -o -name '*.aux' -o -name '*.fdb_latexmk' \) -type f -print 2>/dev/null | sed 's/^/            /'
else pass HYGIENE "no obvious build/editor cruft"; fi

echo
echo "(Build BUILD-01 and context items OVL-06/08, LIC-02/03/05/06, REPO-02/08/09 are assessed by the skill, not this script.)"

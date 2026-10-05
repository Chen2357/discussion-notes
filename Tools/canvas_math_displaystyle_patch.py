#!/usr/bin/env python3
"""Wrap <math> content in <mstyle> when a descendant has displaystyle="true".

For every <math> element in an HTML file that contains a descendant element
with a displaystyle="true" attribute, this script:

  1. wraps the content of the <math> element in
         <mstyle scriptlevel="0" displaystyle="true"> ... </mstyle>
  2. removes the now-redundant displaystyle="true" attribute from the
     descendant elements.

Example:
    <math><mo lspace="0em" displaystyle="true">&sum;</mo>
          <mfrac displaystyle="true"><mn>1</mn><mn>2</mn></mfrac></math>
    becomes
    <math><mstyle scriptlevel="0" displaystyle="true">
          <mo lspace="0em">&sum;</mo>
          <mfrac><mn>1</mn><mn>2</mn></mfrac></mstyle></math>

The script is idempotent: running it twice does not double-wrap.

Usage:
    python3 fix_math_displaystyle.py FILE [FILE ...] [--dry-run]

Files are modified in place (unless --dry-run is given). Only files with an
HTML-ish extension (.html, .htm, .xhtml) are touched; anything else is
skipped with a notice.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

# <math ...> ... </math>  (case-insensitive, non-greedy; assumes <math> does
# not nest inside <math>)
MATH_RE = re.compile(r"<math\b[^>]*>.*?</math\s*>", re.IGNORECASE | re.DOTALL)

# Any element tag, e.g. <mo lspace="0em">
TAG_RE = re.compile(r"<[A-Za-z][^>]*>", re.DOTALL)

# displaystyle="true" (also 'true' or unquoted true). The lookbehind makes sure
# we don't match a longer attribute name such as xdisplaystyle.
DISPLAYSTYLE_TRUE_RE = re.compile(
    r"(?<![-\w])displaystyle\s*=\s*(?:\"true\"|'true'|true\b)", re.IGNORECASE
)

# Same, plus the whitespace in front of the attribute, for removal.
DISPLAYSTYLE_TRUE_STRIP_RE = re.compile(
    r"\s*(?<![-\w])displaystyle\s*=\s*(?:\"true\"|'true'|true\b)", re.IGNORECASE
)

# Content that already starts with <mstyle ... displaystyle="true"> (idempotency).
ALREADY_WRAPPED_RE = re.compile(
    r"^\s*<mstyle\b[^>]*?(?<![-\w])displaystyle\s*=\s*(?:\"true\"|'true'|true\b)",
    re.IGNORECASE | re.DOTALL,
)

WRAPPER_OPEN = '<mstyle scriptlevel="0" displaystyle="true">'
WRAPPER_CLOSE = "</mstyle>"

HTML_EXTS = {".html", ".htm", ".xhtml"}

USAGE = "usage: python3 fix_math_displaystyle.py [--dry-run] FILE [FILE ...]"


def transform_math(match: re.Match) -> str:
    """Transform a single <math>...</math> match, if needed."""
    full = match.group(0)
    open_tag = full[: full.index(">") + 1]
    close_tag = full[full.rindex("</") :]
    inner = full[len(open_tag) : len(full) - len(close_tag)]

    # Nothing to do: already wrapped by this script, or no descendant carries
    # displaystyle="true".
    if ALREADY_WRAPPED_RE.match(inner):
        return full
    if not any(DISPLAYSTYLE_TRUE_RE.search(tag) for tag in TAG_RE.findall(inner)):
        return full

    cleaned = DISPLAYSTYLE_TRUE_STRIP_RE.sub("", inner)
    return f"{open_tag}{WRAPPER_OPEN}{cleaned}{WRAPPER_CLOSE}{close_tag}"


def process_file(path: Path, dry_run: bool) -> None:
    text = path.read_text(encoding="utf-8")
    changed = 0

    def repl(m: re.Match) -> str:
        nonlocal changed
        out = transform_math(m)
        if out != m.group(0):
            changed += 1
        return out

    new_text = MATH_RE.sub(repl, text)
    if changed:
        if dry_run:
            print(f"{path}: would update {changed} <math> element(s)")
        else:
            path.write_text(new_text, encoding="utf-8")
            print(f"{path}: updated {changed} <math> element(s)")
    else:
        print(f"{path}: no changes")


def main(argv: list[str]) -> int:
    dry_run = False
    files: list[Path] = []
    for arg in argv[1:]:
        if arg == "--dry-run":
            dry_run = True
        elif arg in ("-h", "--help"):
            print(USAGE)
            return 0
        else:
            files.append(Path(arg))

    if not files:
        print(USAGE, file=sys.stderr)
        return 2

    exit_code = 0
    for path in files:
        if not path.is_file():
            print(f"error: file not found: {path}", file=sys.stderr)
            exit_code = 1
            continue
        if path.suffix.lower() not in HTML_EXTS:
            print(f"{path}: skipped (not an HTML file)")
            continue
        try:
            process_file(path, dry_run)
        except (OSError, UnicodeDecodeError) as exc:
            print(f"error: {path}: {exc}", file=sys.stderr)
            exit_code = 1
    return exit_code


if __name__ == "__main__":
    sys.exit(main(sys.argv))

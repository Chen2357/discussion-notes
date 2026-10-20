#!/usr/bin/env python3
"""Patch the MathML in Typst-generated HTML files before uploading to Canvas.

Typst's HTML export is almost what Canvas needs, but a few MathML details
render badly. This script applies a set of independent patches ("features")
to HTML files in place. All features are on by default; use --features to
apply a subset (or --features none to apply none), and --list-features to
see what is available.

Features
--------
displaystyle
    For every <math> element that contains a descendant element with a
    displaystyle="true" attribute:

      1. wrap the content of the <math> element in
             <mstyle scriptlevel="0" displaystyle="true"> ... </mstyle>
      2. remove the now-redundant displaystyle="true" attribute from the
         descendant elements.

    Example:
        <math><mo lspace="0em" displaystyle="true">&sum;</mo>
              <mfrac displaystyle="true"><mn>1</mn><mn>2</mn></mfrac></math>
        becomes
        <math><mstyle scriptlevel="0" displaystyle="true">
              <mo lspace="0em">&sum;</mo>
              <mfrac><mn>1</mn><mn>2</mn></mfrac></mstyle></math>

mtable
    Every <mtable> opening tag whose class attribute contains the
    "multiline-equation" token (in practice usually
    class="multiline-equation aligned") is augmented with

        columnalign="right left right left right left right left right left right left"
        rowspacing="3pt"
        columnspacing="0em 2em 0em 2em 0em 2em 0em 2em 0em 2em 0em"

    unless the tag already carries any of columnalign, rowspacing, or
    columnspacing, so manually tuned values are never clobbered.

arrow
    Typst exports $arrow(v)$ as
        <mover accent="true"><mi>v</mi><mo stretchy="true">⃗</mo></mover>
    Some renderers stretch the arrow to fill its container, so the arrow's
    <mo> tag is rewritten to carry stretchy="false" instead. Only <mo>
    elements whose sole content is the combining right arrow above (U+20D7)
    are touched; other stretchy elements are left alone.

Each feature is idempotent: running the script twice (with the same
features) does not change the file a second time.

Usage:
    python3 canvas_math_patch.py FILE [FILE ...] [--dry-run]
                              [--features all|none|displaystyle,mtable,arrow]
                              [--list-features]

Files are modified in place (unless --dry-run is given). Only files with an
HTML-ish extension (.html, .htm, .xhtml) are touched; anything else is
skipped with a notice.
"""

from __future__ import annotations

import argparse
from os import PathLike
import re
import sys
from dataclasses import dataclass
from pathlib import Path

# Any element tag, e.g. <mo lspace="0em">
TAG_RE = re.compile(r"<[A-Za-z][^>]*>", re.DOTALL)

# ---------------------------------------------------------------------------
# displaystyle feature

# <math ...> ... </math>  (case-insensitive, non-greedy; assumes <math> does
# not nest inside <math>)
MATH_RE = re.compile(r"<math\b[^>]*>.*?</math\s*>", re.IGNORECASE | re.DOTALL)

# displaystyle="true" (also 'true' or unquoted true). The lookbehind makes
# sure we don't match a longer attribute name such as xdisplaystyle.
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


# ---------------------------------------------------------------------------
# mtable feature

# <mtable ...> opening tag (case-insensitive).
MTABLE_OPEN_RE = re.compile(r"<mtable\b[^>]*>", re.IGNORECASE)

# The class attribute of an opening tag: double-quoted, single-quoted, or
# unquoted. The lookbehind avoids matching a longer attribute name.
CLASS_ATTR_RE = re.compile(
    r"""(?<![-\w])class\s*=\s*(?:"([^"]*)"|'([^']*)'|([^\s>]+))""",
    re.IGNORECASE,
)

# Any of the attributes this script adds, already present on the tag
# (idempotency, and protection of manually tuned values).
MTABLE_ATTR_PRESENT_RE = re.compile(
    r"(?<![-\w])(?:columnalign|rowspacing|columnspacing)\s*=", re.IGNORECASE
)

MULTILINE_EQUATION_CLASS = "multiline-equation"

MULTILINE_EQUATION_ATTRS = (
    'columnalign="right left right left right left right left right left right left" '
    'rowspacing="3pt" '
    'columnspacing="0em 2em 0em 2em 0em 2em 0em 2em 0em 2em 0em"'
)


def transform_mtable(match: re.Match) -> str:
    """Augment a <mtable ...> opening tag with the multiline-equation attrs."""
    tag = match.group(0)
    if MTABLE_ATTR_PRESENT_RE.search(tag):
        return tag  # already annotated, or carries manual values: leave alone
    class_match = CLASS_ATTR_RE.search(tag)
    if not class_match:
        return tag
    classes = class_match.group(1) or class_match.group(2) or class_match.group(3)
    if MULTILINE_EQUATION_CLASS not in classes.split():
        return tag  # exact class token match; e.g. not "x-multiline-equation"
    close = "/>" if tag.endswith("/>") else ">"
    body = tag[: len(tag) - len(close)].rstrip()
    return f"{body} {MULTILINE_EQUATION_ATTRS}{close}"


# ---------------------------------------------------------------------------
# arrow feature

# The combining right arrow above that Typst uses for $arrow(v)$.
ARROW_CHAR = "\u20d7"

# An <mo> whose sole content is the arrow character (surrounding whitespace
# tolerated).
ARROW_MO_RE = re.compile(
    rf"(<mo\b[^>]*>)(\s*{re.escape(ARROW_CHAR)}\s*)(</mo\s*>)",
    re.IGNORECASE,
)

# stretchy="true" (also 'true' or unquoted true). The lookbehind makes sure
# we don't match a longer attribute name such as xstretchy.
STRETCHY_TRUE_RE = re.compile(
    r"(?<![-\w])stretchy\s*=\s*(?:\"true\"|'true'|true\b)", re.IGNORECASE
)


def transform_arrow(match: re.Match) -> str:
    """Set stretchy="false" on an arrow <mo> tag, if it currently says true."""
    open_tag, arrow, close_tag = match.groups()
    if not STRETCHY_TRUE_RE.search(open_tag):
        return match.group(0)  # no stretchy="true": nothing to do
    new_open = STRETCHY_TRUE_RE.sub('stretchy="false"', open_tag)
    return f"{new_open}{arrow}{close_tag}"


# ---------------------------------------------------------------------------
# feature registry

HTML_EXTS = {".html", ".htm", ".xhtml"}


@dataclass(frozen=True)
class Feature:
    name: str
    description: str
    pattern: re.Pattern
    transform: callable  # re.Match -> str
    count_label: str  # noun used in the "updated ..." summary


FEATURES: dict[str, Feature] = {
    "displaystyle": Feature(
        name="displaystyle",
        description='wrap <math> in <mstyle> and strip redundant displaystyle="true"',
        pattern=MATH_RE,
        transform=transform_math,
        count_label="<math> element(s)",
    ),
    "mtable": Feature(
        name="mtable",
        description="annotate multiline-equation <mtable> tags with alignment attributes",
        pattern=MTABLE_OPEN_RE,
        transform=transform_mtable,
        count_label="<mtable> element(s)",
    ),
    "arrow": Feature(
        name="arrow",
        description="rewrite vector arrows (⃗, U+20D7) as stretchy=\"false\"",
        pattern=ARROW_MO_RE,
        transform=transform_arrow,
        count_label="vector-arrow <mo> element(s)",
    ),
}


def parse_features(spec: str) -> list[Feature]:
    """Resolve a --features spec.

    Accepts 'all' (the default), 'none', or a comma-separated list of feature
    names; 'none' may be combined with names to start from an empty set
    (e.g. 'none,arrow' runs only the arrow feature). Order is preserved.
    """
    tokens = [t.strip() for t in spec.split(",") if t.strip()]
    if not tokens:
        tokens = ["all"]
    if "all" in tokens:
        selected: dict[str, Feature] = dict(FEATURES)
    else:
        selected = {}
    for token in tokens:
        if token in ("all", "none"):
            continue
        if token not in FEATURES:
            known = ", ".join(FEATURES)
            raise ValueError(
                f"unknown feature '{token}' (known: {known}; or use 'all'/'none')"
            )
        selected[token] = FEATURES[token]
    return list(selected.values())


def process_file(path: Path, features: list[Feature], dry_run: bool) -> None:
    text = path.read_text(encoding="utf-8")
    changed: list[str] = []

    new_text = text
    for feature in features:
        count = 0

        def repl(match: re.Match) -> str:
            nonlocal count
            out = feature.transform(match)
            if out != match.group(0):
                count += 1
            return out

        new_text = feature.pattern.sub(repl, new_text)
        if count:
            changed.append(f"{count} {feature.count_label}")

    if changed:
        what = " and ".join(changed)
        if dry_run:
            print(f"{path}: would update {what}")
        else:
            path.write_text(new_text, encoding="utf-8")
            print(f"{path}: updated {what}")
    else:
        print(f"{path}: no changes")


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(
        prog="canvas_math_patch.py",
        description=(
            "Patch MathML in Typst-generated HTML files. All features are on "
            "by default; use --features to select a subset and "
            "--list-features to see the available features."
        ),
    )
    parser.add_argument(
        "files", nargs="*", metavar="FILE", help="HTML file(s) to patch in place"
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="report what would change without writing the files",
    )
    parser.add_argument(
        "--features",
        default="all",
        metavar="LIST",
        help=(
            "comma-separated feature names to apply (default: all, i.e. all "
            "features); 'none' disables them all (e.g. --features none,arrow "
            "runs only the arrow feature)"
        ),
    )
    parser.add_argument(
        "--list-features",
        action="store_true",
        help="print the available features and exit",
    )
    args = parser.parse_args(argv[1:])

    if args.list_features:
        width = max(len(f.name) for f in FEATURES.values())
        for feature in FEATURES.values():
            print(f"{feature.name:<{width}}  {feature.description}")
        print()
        print("default: all features on (use --features to select a subset)")
        return 0

    try:
        features = parse_features(args.features)
    except ValueError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 2

    if not args.files:
        parser.print_usage(sys.stderr)
        print("error: no FILE arguments given", file=sys.stderr)
        return 2

    exit_code = 0
    for file in args.files:
        path = Path(file)
        if not path.is_file():
            print(f"error: file not found: {path}", file=sys.stderr)
            exit_code = 1
            continue
        if path.suffix.lower() not in HTML_EXTS:
            print(f"{path}: skipped (not an HTML file)")
            continue
        try:
            process_file(path, features, args.dry_run)
        except (OSError, UnicodeDecodeError) as exc:
            print(f"error: {path}: {exc}", file=sys.stderr)
            exit_code = 1
    return exit_code


if __name__ == "__main__":
    sys.exit(main(sys.argv))

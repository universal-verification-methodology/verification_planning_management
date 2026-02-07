#!/usr/bin/env python3
"""
Structure checker for planning documents.

Reads a JSON schema of required ## headings per file, parses Markdown files
in a module directory, and reports missing sections. Optionally reports
sections that appear to be still only TODO/placeholder content.

Usage:
  python check_structure.py --module 1 [--module-dir PATH] [--schema PATH] [--check-empty]

Exit: 0 if all required sections present (and no empty sections when --check-empty), else 1.
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path


def get_script_dir() -> Path:
    """Return directory containing this script."""
    return Path(__file__).resolve().parent


def load_schema(schema_path: Path) -> dict[str, list[str]]:
    """Load schema JSON: { filename: [ required_heading, ... ] }."""
    with open(schema_path, encoding="utf-8") as f:
        data = json.load(f)
    if not isinstance(data, dict):
        raise ValueError("Schema must be a JSON object (file -> list of headings)")
    for k, v in data.items():
        if not isinstance(v, list) or not all(isinstance(h, str) for h in v):
            raise ValueError("Schema values must be lists of strings")
    return data


def extract_headings(content: str) -> list[str]:
    """
    Extract ## headings from Markdown (not ###).
    Returns list of heading titles with leading ## and whitespace stripped.
    """
    pattern = re.compile(r"^##\s+(.+)$", re.MULTILINE)
    return [m.group(1).strip() for m in pattern.finditer(content)]


def check_file(
    module_dir: Path,
    filename: str,
    required_headings: list[str],
    check_empty: bool,
) -> tuple[list[str], list[str]]:
    """
    Check one file: missing required sections and (optional) sections still only TODO.

    Returns (missing_headings, empty_section_headings).
    """
    filepath = module_dir / filename
    missing: list[str] = []
    empty_sections: list[str] = []

    if not filepath.exists():
        return required_headings.copy(), []  # all required considered missing

    text = filepath.read_text(encoding="utf-8")
    found_headings = extract_headings(text)

    for req in required_headings:
        if req not in found_headings:
            missing.append(req)

    if check_empty:
        # Split by ## and inspect each section body
        parts = re.split(r"^(##\s+.+)$", text, flags=re.MULTILINE)
        # parts: [preamble, "## H1", body1, "## H2", body2, ...]
        i = 1
        while i + 1 < len(parts):
            heading_line = parts[i]
            body = parts[i + 1]
            title = re.sub(r"^##\s+", "", heading_line).strip()
            if title in required_headings and title not in missing:
                body_stripped = body.strip()
                # Consider empty if content is only blank, <!-- TODO -->, or "> **How to fill**"
                non_empty_lines = [
                    line.strip()
                    for line in body_stripped.splitlines()
                    if line.strip()
                    and not line.strip().startswith("<!--")
                    and "TODO" not in line.strip()
                    and "How to fill" not in line.strip()
                ]
                if len(non_empty_lines) <= 1:
                    empty_sections.append(title)
            i += 2

    return missing, empty_sections


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Check planning documents for required sections (Module 1)."
    )
    parser.add_argument(
        "--module",
        type=int,
        default=1,
        help="Module number (default 1); schema must exist as schema/moduleN.json",
    )
    parser.add_argument(
        "--module-dir",
        type=Path,
        default=None,
        help="Module root directory (default: PROJECT_ROOT/moduleN)",
    )
    parser.add_argument(
        "--schema",
        type=Path,
        default=None,
        help="Path to schema JSON (default: scripts/schema/moduleN.json)",
    )
    parser.add_argument(
        "--check-empty",
        action="store_true",
        help="Also report sections that appear still only TODO/placeholder",
    )
    parser.add_argument(
        "--quiet",
        action="store_true",
        help="Only exit code; no stdout",
    )
    args = parser.parse_args()

    script_dir = get_script_dir()
    project_root = script_dir.parent

    if args.module_dir is not None:
        module_dir = args.module_dir.resolve()
    else:
        module_dir = project_root / f"module{args.module}"

    if args.schema is not None:
        schema_path = args.schema.resolve()
    else:
        schema_path = script_dir / "schema" / f"module{args.module}.json"

    if not schema_path.exists():
        if not args.quiet:
            print(f"Schema not found: {schema_path}", file=sys.stderr)
        return 0  # no schema -> skip silently

    try:
        schema = load_schema(schema_path)
    except (OSError, ValueError) as e:
        print(f"Schema error: {e}", file=sys.stderr)
        return 2

    has_error = False
    for filename, required_headings in schema.items():
        missing, empty = check_file(module_dir, filename, required_headings, args.check_empty)
        if missing and not args.quiet:
            has_error = True
            print(f"File: {filename} — Missing required section(s): {', '.join(missing)}")
            print(f"  How to fix: add ## headings for each; see module{args.module}/templates/{filename} or docs/FILL_GUIDES.md.")
        if empty and args.check_empty and not args.quiet:
            has_error = True
            print(f"File: {filename} — Section(s) still only TODO/placeholder: {', '.join(empty)}")
            print(f"  How to fix: replace placeholder with real content; see module{args.module}/.solutions/{filename}.")

    return 1 if has_error else 0


if __name__ == "__main__":
    sys.exit(main())

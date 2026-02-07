#!/usr/bin/env python3
"""
Traceability checker for Module 1 planning documents.

Extracts requirement IDs (R1, R2, ...) from REQUIREMENTS_MATRIX.md and checks
they are referenced in VERIFICATION_PLAN.md and HIGH_PRIORITY_REQUIREMENTS_TRACEABILITY.md.
Reports:
  - Orphan: in matrix but not referenced in plan or high-priority doc
  - Missing: referenced in plan/high-priority but not in matrix (informational)

Usage:
  python check_traceability.py --module 1 [--module-dir PATH] [--quiet]

Exit: 0 if no orphans (and optionally no missing), else 1.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


REQ_ID_PATTERN = re.compile(r"\bR[0-9]+\b")


def get_script_dir() -> Path:
    """Return directory containing this script."""
    return Path(__file__).resolve().parent


def extract_req_ids(text: str) -> set[str]:
    """Extract unique requirement IDs (R1, R2, ...) from text."""
    return set(REQ_ID_PATTERN.findall(text))


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Check requirement ID traceability (Module 1)."
    )
    parser.add_argument(
        "--module",
        type=int,
        default=1,
        help="Module number (default 1)",
    )
    parser.add_argument(
        "--module-dir",
        type=Path,
        default=None,
        help="Module root directory (default: PROJECT_ROOT/moduleN)",
    )
    parser.add_argument(
        "--report-missing",
        action="store_true",
        help="Also report IDs in plan/high-priority doc but not in matrix",
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

    matrix_file = module_dir / "REQUIREMENTS_MATRIX.md"
    plan_file = module_dir / "VERIFICATION_PLAN.md"
    high_priority_file = module_dir / "HIGH_PRIORITY_REQUIREMENTS_TRACEABILITY.md"

    if not matrix_file.exists():
        if not args.quiet:
            print("REQUIREMENTS_MATRIX.md not found; skipping traceability check.", file=sys.stderr)
        return 0

    matrix_text = matrix_file.read_text(encoding="utf-8")
    ids_in_matrix = extract_req_ids(matrix_text)

    if not ids_in_matrix:
        if not args.quiet:
            print("No requirement IDs (R1, R2, ...) found in REQUIREMENTS_MATRIX.md; skipping traceability check.", file=sys.stderr)
        return 0

    ids_in_plan: set[str] = set()
    if plan_file.exists():
        ids_in_plan = extract_req_ids(plan_file.read_text(encoding="utf-8"))

    ids_in_high_priority: set[str] = set()
    if high_priority_file.exists():
        ids_in_high_priority = extract_req_ids(high_priority_file.read_text(encoding="utf-8"))

    ids_referenced_elsewhere = ids_in_plan | ids_in_high_priority

    orphans = ids_in_matrix - ids_referenced_elsewhere
    missing = ids_referenced_elsewhere - ids_in_matrix if args.report_missing else set()

    has_error = False

    if orphans and not args.quiet:
        has_error = True
        orphan_list = ", ".join(sorted(orphans, key=lambda x: int(x[1:])))
        print(f"Traceability: requirement(s) in REQUIREMENTS_MATRIX.md but not referenced in VERIFICATION_PLAN.md or HIGH_PRIORITY_REQUIREMENTS_TRACEABILITY.md: {orphan_list}")
        print("  How to fix: reference these Req IDs in the verification plan (e.g. test catalogue, risk table) or in HIGH_PRIORITY_REQUIREMENTS_TRACEABILITY.md. See module1/.solutions/ for examples.")

    if missing and args.report_missing and not args.quiet:
        missing_list = ", ".join(sorted(missing, key=lambda x: int(x[1:])))
        print(f"Traceability (info): ID(s) referenced in plan/high-priority doc but not in REQUIREMENTS_MATRIX.md: {missing_list}")
        print("  Suggestion: add these to the Requirement List (§2) in REQUIREMENTS_MATRIX.md, or remove references from the plan.")

    if not has_error and not args.quiet and ids_in_matrix:
        print("Traceability: all requirement IDs in matrix are referenced in plan or high-priority doc.")

    return 1 if has_error else 0


if __name__ == "__main__":
    sys.exit(main())

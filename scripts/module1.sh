#!/usr/bin/env bash

# Module 1: Verification Planning & Management Foundations Orchestrator
# This script summarizes and checks the planning artifacts for Module 1.
# Usage: ./scripts/module1.sh [OPTIONS]

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MODULE1_DIR="$PROJECT_ROOT/module1"
DOCS_DIR="$MODULE1_DIR"
LOG_FILE="$MODULE1_DIR/run.log"

# Options
RUN_PLAN_STATUS=true
RUN_MATRIX_STATUS=true
RUN_CHECKLIST_STATUS=true
RUN_STRUCTURE_CHECK=true
RUN_TRACEABILITY_CHECK=true

print_status() {
    local color=$1
    local message=$2
    echo -e "${color}[$(date '+%Y-%m-%d %H:%M:%S')] ${message}${NC}"
}

print_header() {
    local message=$1
    echo ""
    echo -e "${CYAN}========================================${NC}"
    echo -e "${CYAN}${message}${NC}"
    echo -e "${CYAN}========================================${NC}"
    echo ""
}

show_usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Module 1: Verification Planning & Management Foundations (SV/UVM)
This script summarizes and checks the planning artifacts for Module 1.

OPTIONS:
    --plan-status        Show status of verification_plan.md only
    --matrix-status      Show status of requirements_matrix.md only
    --checklist-status   Show status of checklist_module1.md only
    --structure-status   Show required-sections check only
    --traceability-status  Show Req ID traceability check only
    --summary            Show all statuses (default)
    --help, -h           Show this help message

EXAMPLES:
    # Full summary (plan, matrix, checklist)
    $0

    # Focus only on plan status
    $0 --plan-status

    # Focus only on traceability matrix
    $0 --matrix-status

EOF
}

parse_args() {
    # Defaults already set to "summary" mode
    while [[ $# -gt 0 ]]; do
        case $1 in
            --plan-status)
                RUN_PLAN_STATUS=true
                RUN_MATRIX_STATUS=false
                RUN_CHECKLIST_STATUS=false
                RUN_STRUCTURE_CHECK=false
                RUN_TRACEABILITY_CHECK=false
                shift
                ;;
            --matrix-status)
                RUN_PLAN_STATUS=false
                RUN_MATRIX_STATUS=true
                RUN_CHECKLIST_STATUS=false
                RUN_STRUCTURE_CHECK=false
                RUN_TRACEABILITY_CHECK=false
                shift
                ;;
            --checklist-status)
                RUN_PLAN_STATUS=false
                RUN_MATRIX_STATUS=false
                RUN_STRUCTURE_CHECK=false
                RUN_TRACEABILITY_CHECK=false
                RUN_CHECKLIST_STATUS=true
                shift
                ;;
            --structure-status)
                RUN_PLAN_STATUS=false
                RUN_MATRIX_STATUS=false
                RUN_CHECKLIST_STATUS=false
                RUN_TRACEABILITY_CHECK=true
                RUN_STRUCTURE_CHECK=true
                shift
                ;;
            --traceability-status)
                RUN_PLAN_STATUS=false
                RUN_MATRIX_STATUS=false
                RUN_CHECKLIST_STATUS=false
                RUN_STRUCTURE_CHECK=false
                RUN_TRACEABILITY_CHECK=true
                shift
                ;;
            --summary)
                RUN_PLAN_STATUS=true
                RUN_MATRIX_STATUS=true
                RUN_CHECKLIST_STATUS=true
                RUN_STRUCTURE_CHECK=true
                RUN_TRACEABILITY_CHECK=true
                shift
                ;;
            --help|-h)
                show_usage
                exit 0
                ;;
            *)
                print_status "$RED" "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
}

check_structure() {
    print_status "$BLUE" "Checking basic Module 1 structure..."

    local missing=0

    if [[ ! -d "$MODULE1_DIR" ]]; then
        print_status "$RED" "module1/ directory not found at: $MODULE1_DIR"
        exit 1
    fi

    for d in "$DOCS_DIR" "$MODULE1_DIR/dut" "$MODULE1_DIR/tb"; do
        if [[ ! -d "$d" ]]; then
            print_status "$YELLOW" "Directory missing: $d"
            missing=$((missing + 1))
        fi
    done

    if [[ $missing -eq 0 ]]; then
        print_status "$GREEN" "Basic Module 1 structure looks OK."
    else
        print_status "$YELLOW" "Some directories are missing; see messages above."
    fi
}

plan_status() {
    print_header "Verification Plan Status"

    local plan_file="$DOCS_DIR/VERIFICATION_PLAN.md"

    if [[ ! -f "$plan_file" ]]; then
        print_status "$RED" "File missing: VERIFICATION_PLAN.md"
        echo "  Location: $plan_file"
        echo "  How to fix: copy from module1/templates/VERIFICATION_PLAN.md, or create the file in module1/. See module1/.solutions/VERIFICATION_PLAN.md for an example."
        return 1
    fi

    # Basic size / TODO heuristic
    local lines
    # wc -l prints a single integer; file existence is already checked above
    lines=$(wc -l < "$plan_file")
    local todos
    # Use grep -c but mask non-zero exit (no matches) with `true` so `set -e` does not abort.
    # This avoids duplicate numeric outputs that would otherwise break numeric tests below.
    todos=$(grep -c "TODO" "$plan_file" || true)

    print_status "$GREEN" "Found VERIFICATION_PLAN.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "File: VERIFICATION_PLAN.md — $todos TODO marker(s) still present (sections not yet filled)."
        echo "  How to fix: replace each <!-- TODO: ... --> with real content for that section. See module1/.solutions/VERIFICATION_PLAN.md for an example, or docs/FILL_GUIDES.md for section-by-section guidance."
    else
        print_status "$GREEN" "No explicit TODO markers found in VERIFICATION_PLAN.md."
    fi
}

matrix_status() {
    print_header "Requirements Matrix Status"

    local matrix_file="$DOCS_DIR/REQUIREMENTS_MATRIX.md"

    if [[ ! -f "$matrix_file" ]]; then
        print_status "$RED" "File missing: REQUIREMENTS_MATRIX.md"
        echo "  Location: $matrix_file"
        echo "  How to fix: copy from module1/templates/REQUIREMENTS_MATRIX.md, or create the file in module1/. See module1/.solutions/REQUIREMENTS_MATRIX.md for an example."
        return 1
    fi

    local req_count

    # Count Req IDs in section 2 (simple heuristic)
    req_count=$(grep -c -E "^\| R[0-9]+" "$matrix_file" 2>/dev/null) || req_count=0

    print_status "$GREEN" "Found REQUIREMENTS_MATRIX.md."
    print_status "$BLUE"  "Approx. requirement entries: $req_count"

    # Simple sanity: if zero, warn
    if [[ "$req_count" -eq 0 ]]; then
        print_status "$YELLOW" "File: REQUIREMENTS_MATRIX.md — Section: Requirement List (§2). No requirement rows detected (R1, R2, …)."
        echo "  How to fix: add a markdown table with rows like | R1 | Description | H | Notes |. See module1/.solutions/REQUIREMENTS_MATRIX.md §2, or docs/FILL_GUIDES.md."
    fi
}

traceability_check_status() {
    print_header "Traceability (Requirement IDs)"

    local check_script="$SCRIPT_DIR/check_traceability.py"
    if [[ ! -f "$check_script" ]]; then
        print_status "$YELLOW" "Traceability checker not found: $check_script (skipping)."
        return 0
    fi

    if ! command -v python3 &>/dev/null; then
        print_status "$YELLOW" "python3 not found (skipping traceability check)."
        return 0
    fi

    local out
    out=$(python3 "$check_script" --module 1 --module-dir "$MODULE1_DIR" 2>&1) || true
    local rc=$?
    if [[ -n "$out" ]]; then
        echo "$out"
    fi
    if [[ $rc -ne 0 ]]; then
        print_status "$YELLOW" "Some requirement IDs in the matrix are not referenced in the plan or high-priority doc. See above."
        return 1
    fi
    return 0
}

structure_check_status() {
    print_header "Document Structure (Required Sections)"

    local check_script="$SCRIPT_DIR/check_structure.py"
    if [[ ! -f "$check_script" ]]; then
        print_status "$YELLOW" "Structure checker not found: $check_script (skipping section check)."
        return 0
    fi

    if ! command -v python3 &>/dev/null; then
        print_status "$YELLOW" "python3 not found (skipping section check)."
        return 0
    fi

    local out
    out=$(python3 "$check_script" --module 1 --module-dir "$MODULE1_DIR" 2>&1) || true
    local rc=$?
    if [[ -n "$out" ]]; then
        echo "$out"
    fi
    if [[ $rc -ne 0 ]]; then
        print_status "$YELLOW" "Some required sections are missing or still placeholder. See above for file and section."
        return 1
    fi
    print_status "$GREEN" "Required sections present in planning documents."
    return 0
}

checklist_status() {
    print_header "Checklist Status"

    local checklist_file="$DOCS_DIR/CHECKLIST.md"

    if [[ ! -f "$checklist_file" ]]; then
        print_status "$RED" "File missing: CHECKLIST.md"
        echo "  Location: $checklist_file"
        echo "  How to fix: copy from module1/templates/CHECKLIST.md, or create the file in module1/. See module1/.solutions/CHECKLIST.md for an example."
        return 1
    fi

    local total unchecked checked
    # Count all checklist lines, allowing for no matches without aborting due to `set -e`.
    total=$(grep -c "^\- \[.\]" "$checklist_file" || true)
    unchecked=$(grep -c "^\- \[ \]" "$checklist_file" || true)
    # Treat both lowercase and uppercase checked boxes as completed using a single regex.
    checked=$(grep -Ec "^\- \[[xX]\]" "$checklist_file" || true)

    print_status "$GREEN" "Found CHECKLIST.md."
    print_status "$BLUE"  "Checklist items: $total  |  Completed: $checked  |  Remaining: $unchecked"

    if [[ "$unchecked" -gt 0 ]]; then
        print_status "$YELLOW" "File: CHECKLIST.md — $unchecked item(s) still unchecked."
        echo "  How to fix: mark completed items with - [x] (lowercase x). Work through each section; run ./scripts/module1.sh again to see progress. See module1/.solutions/CHECKLIST.md or docs/FILL_GUIDES.md."
        echo ""
        print_status "$BLUE" "Unchecked items (line : content):"
        grep -n "^\- \[ \]" "$checklist_file" 2>/dev/null | while IFS= read -r line; do
            line_num="${line%%:*}"
            rest="${line#*:}"
            # Show first 60 chars of content
            if [[ ${#rest} -gt 60 ]]; then
                rest="${rest:0:57}..."
            fi
            echo "    $line_num : $rest"
        done
    else
        print_status "$GREEN" "All checklist items appear to be completed."
    fi
}

main() {
    # Initialize logging: mirror output to console and run.log in module1/
    mkdir -p "$MODULE1_DIR"
    {
        echo "=========================================="
        echo "Module 1 Planning Orchestrator Log"
        echo "Started: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Command: $0 $*"
        echo "Project root: $PROJECT_ROOT"
        echo "Module dir : $MODULE1_DIR"
        echo "=========================================="
        echo ""
    } > "$LOG_FILE"

    # Redirect stdout/stderr through tee into the log file
    exec 3>&1
    exec > >(tee -a "$LOG_FILE" >&3)
    exec 2>&1

    print_header "Module 1: Verification Planning & Management Foundations"

    parse_args "$@"
    check_structure

    local errors=0

    if [[ "$RUN_PLAN_STATUS" == true ]]; then
        if ! plan_status; then
            errors=$((errors + 1))
        fi
    fi

    if [[ "$RUN_MATRIX_STATUS" == true ]]; then
        if ! matrix_status; then
            errors=$((errors + 1))
        fi
    fi

    if [[ "$RUN_CHECKLIST_STATUS" == true ]]; then
        if ! checklist_status; then
            errors=$((errors + 1))
        fi
    fi

    if [[ "$RUN_STRUCTURE_CHECK" == true ]]; then
        if ! structure_check_status; then
            errors=$((errors + 1))
        fi
    fi

    if [[ "$RUN_TRACEABILITY_CHECK" == true ]]; then
        if ! traceability_check_status; then
            errors=$((errors + 1))
        fi
    fi

    print_header "Summary"

    if [[ $errors -eq 0 ]]; then
        print_status "$GREEN" "✓ Module 1 planning artifacts look structurally OK."
        echo ""
        print_status "$BLUE" "Next steps:"
        echo "  1. Fill out verification_plan.md with your DUT details."
        echo "  2. Populate requirements_matrix.md with Req/Test/Coverage mappings."
        echo "  3. Update checklist_module1.md as you complete tasks."
    else
        print_status "$YELLOW" "Completed with $errors warning/error(s). See output above for details."
        exit 1
    fi

    {
        echo ""
        echo "=========================================="
        echo "Module 1 Planning Orchestrator Log - Completed"
        echo "Finished: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Exit code: $errors"
        echo "Log file: $LOG_FILE"
        echo "=========================================="
    } >> "$LOG_FILE"
}

main "$@"


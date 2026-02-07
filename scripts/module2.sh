#!/usr/bin/env bash

# Module 2: Test Planning & Strategy Orchestrator
# This script summarizes and checks the planning artifacts for Module 2.
# Usage: ./scripts/module2.sh [OPTIONS]

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
MODULE2_DIR="$PROJECT_ROOT/module2"
DOCS_DIR="$MODULE2_DIR"
LOG_FILE="$MODULE2_DIR/run.log"

# Options
RUN_TEST_PLAN_STATUS=true
RUN_REGRESSION_PLAN_STATUS=true
RUN_COVERAGE_PLAN_STATUS=true
RUN_CHECKLIST_STATUS=true
RUN_STRUCTURE_CHECK=true

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

Module 2: Test Planning & Strategy in Depth (SV/UVM)
This script summarizes and checks the planning artifacts for Module 2.

OPTIONS:
    --test-plan-status       Show status of test_plan.md only
    --regression-status      Show status of regression_plan.md only
    --coverage-status        Show status of coverage_plan.md only
    --checklist-status       Show status of checklist_module2.md only
    --structure-status       Show required-sections check only
    --summary                Show all statuses (default)
    --help, -h               Show this help message

EXAMPLES:
    # Full summary
    $0

    # Focus only on test plan status
    $0 --test-plan-status

    # Focus only on regression plan
    $0 --regression-status

EOF
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --test-plan-status)
                RUN_TEST_PLAN_STATUS=true
                RUN_REGRESSION_PLAN_STATUS=false
                RUN_COVERAGE_PLAN_STATUS=false
                RUN_CHECKLIST_STATUS=false
                RUN_STRUCTURE_CHECK=false
                shift
                ;;
            --regression-status)
                RUN_TEST_PLAN_STATUS=false
                RUN_REGRESSION_PLAN_STATUS=true
                RUN_COVERAGE_PLAN_STATUS=false
                RUN_CHECKLIST_STATUS=false
                RUN_STRUCTURE_CHECK=false
                shift
                ;;
            --coverage-status)
                RUN_TEST_PLAN_STATUS=false
                RUN_REGRESSION_PLAN_STATUS=false
                RUN_COVERAGE_PLAN_STATUS=true
                RUN_CHECKLIST_STATUS=false
                RUN_STRUCTURE_CHECK=false
                shift
                ;;
            --checklist-status)
                RUN_TEST_PLAN_STATUS=false
                RUN_REGRESSION_PLAN_STATUS=false
                RUN_COVERAGE_PLAN_STATUS=false
                RUN_STRUCTURE_CHECK=false
                RUN_CHECKLIST_STATUS=true
                shift
                ;;
            --structure-status)
                RUN_TEST_PLAN_STATUS=false
                RUN_REGRESSION_PLAN_STATUS=false
                RUN_COVERAGE_PLAN_STATUS=false
                RUN_CHECKLIST_STATUS=false
                RUN_STRUCTURE_CHECK=true
                shift
                ;;
            --summary)
                RUN_TEST_PLAN_STATUS=true
                RUN_REGRESSION_PLAN_STATUS=true
                RUN_COVERAGE_PLAN_STATUS=true
                RUN_CHECKLIST_STATUS=true
                RUN_STRUCTURE_CHECK=true
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
    print_status "$BLUE" "Checking basic Module 2 structure..."

    local missing=0

    if [[ ! -d "$MODULE2_DIR" ]]; then
        print_status "$RED" "module2/ directory not found at: $MODULE2_DIR"
        exit 1
    fi

    if [[ ! -d "$DOCS_DIR" ]]; then
        print_status "$YELLOW" "Directory missing: $DOCS_DIR"
        missing=$((missing + 1))
    fi

    if [[ $missing -eq 0 ]]; then
        print_status "$GREEN" "Basic Module 2 structure looks OK."
    else
        print_status "$YELLOW" "Some directories are missing; see messages above."
    fi
}

test_plan_status() {
    print_header "Test Plan Status"

    local plan_file="$DOCS_DIR/TEST_PLAN.md"

    if [[ ! -f "$plan_file" ]]; then
        print_status "$RED" "File missing: TEST_PLAN.md"
        echo "  Location: $plan_file"
        echo "  How to fix: copy from module2/templates/TEST_PLAN.md, or create the file in module2/. See module2/.solutions/TEST_PLAN.md for an example."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$plan_file" || echo 0)
    todos=$(grep -c "TODO" "$plan_file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found TEST_PLAN.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "File: TEST_PLAN.md — $todos TODO marker(s) still present (sections not yet filled)."
        echo "  How to fix: replace each <!-- TODO: ... --> with real content for that section. See module2/.solutions/TEST_PLAN.md for an example, or docs/FILL_GUIDES.md for section-by-section guidance."
    else
        print_status "$GREEN" "No explicit TODO markers found in TEST_PLAN.md."
    fi
}

regression_plan_status() {
    print_header "Regression Plan Status"

    local reg_file="$DOCS_DIR/REGRESSION_PLAN.md"

    if [[ ! -f "$reg_file" ]]; then
        print_status "$RED" "File missing: REGRESSION_PLAN.md"
        echo "  Location: $reg_file"
        echo "  How to fix: copy from module2/templates/REGRESSION_PLAN.md, or create the file in module2/. See module2/.solutions/REGRESSION_PLAN.md for an example."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$reg_file" || echo 0)
    todos=$(grep -c "TODO" "$reg_file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found REGRESSION_PLAN.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "File: REGRESSION_PLAN.md — $todos TODO marker(s) still present (sections not yet filled)."
        echo "  How to fix: replace each <!-- TODO: ... --> with real content for that section. See module2/.solutions/REGRESSION_PLAN.md for an example, or docs/FILL_GUIDES.md."
    else
        print_status "$GREEN" "No explicit TODO markers found in REGRESSION_PLAN.md."
    fi
}

coverage_plan_status() {
    print_header "Coverage Plan Status"

    local cov_file="$DOCS_DIR/COVERAGE_PLAN.md"

    if [[ ! -f "$cov_file" ]]; then
        print_status "$YELLOW" "File missing: COVERAGE_PLAN.md (optional but recommended)"
        echo "  Location: $cov_file"
        echo "  How to fix: copy from module2/templates/COVERAGE_PLAN.md, or create the file in module2/. See module2/.solutions/COVERAGE_PLAN.md for an example, or docs/FILL_GUIDES.md."
        return 0
    fi

    local lines todos
    lines=$(wc -l < "$cov_file" || echo 0)
    todos=$(grep -c "TODO" "$cov_file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found COVERAGE_PLAN.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "File: COVERAGE_PLAN.md — $todos TODO marker(s) still present (sections not yet filled)."
        echo "  How to fix: replace each <!-- TODO: ... --> with real content for that section. See module2/.solutions/COVERAGE_PLAN.md for an example, or docs/FILL_GUIDES.md."
    else
        print_status "$GREEN" "No explicit TODO markers found in COVERAGE_PLAN.md."
    fi
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
    out=$(python3 "$check_script" --module 2 --module-dir "$MODULE2_DIR" 2>&1) || true
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
    print_header "Module 2 Checklist Status"

    local checklist_file="$DOCS_DIR/CHECKLIST.md"

    if [[ ! -f "$checklist_file" ]]; then
        print_status "$RED" "File missing: CHECKLIST.md"
        echo "  Location: $checklist_file"
        echo "  How to fix: copy from module2/templates/CHECKLIST.md, or create the file in module2/. See module2/.solutions/CHECKLIST.md for an example."
        return 1
    fi

    local total unchecked checked checked_x checked_X
    total=$(grep -c "^\- \[.\]" "$checklist_file" 2>/dev/null)
    total=${total:-0}
    unchecked=$(grep -c "^\- \[ \]" "$checklist_file" 2>/dev/null)
    unchecked=${unchecked:-0}
    checked_x=$(grep -c "^\- \[x\]" "$checklist_file" 2>/dev/null)
    checked_x=${checked_x:-0}
    checked_X=$(grep -c "^\- \[X\]" "$checklist_file" 2>/dev/null)
    checked_X=${checked_X:-0}
    checked=$((checked_x + checked_X))

    print_status "$GREEN" "Found CHECKLIST.md."
    print_status "$BLUE"  "Checklist items: $total  |  Completed: $checked  |  Remaining: $unchecked"

    if [[ "$unchecked" -gt 0 ]]; then
        print_status "$YELLOW" "File: CHECKLIST.md — $unchecked item(s) still unchecked."
        echo "  How to fix: mark completed items with - [x] (lowercase x). Work through each section; run ./scripts/module2.sh again to see progress. See module2/.solutions/CHECKLIST.md or docs/FILL_GUIDES.md."
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
    # Initialize logging
    mkdir -p "$MODULE2_DIR"
    {
        echo "=========================================="
        echo "Module 2 Planning Orchestrator Log"
        echo "Started: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Command: $0 $*"
        echo "Project root: $PROJECT_ROOT"
        echo "Module dir : $MODULE2_DIR"
        echo "=========================================="
        echo ""
    } > "$LOG_FILE"

    exec 3>&1
    exec > >(tee -a "$LOG_FILE" >&3)
    exec 2>&1

    print_header "Module 2: Test Planning & Strategy in Depth"

    parse_args "$@"
    check_structure

    local errors=0

    if [[ "$RUN_TEST_PLAN_STATUS" == true ]]; then
        if ! test_plan_status; then
            errors=$((errors + 1))
        fi
    fi

    if [[ "$RUN_REGRESSION_PLAN_STATUS" == true ]]; then
        if ! regression_plan_status; then
            errors=$((errors + 1))
        fi
    fi

    if [[ "$RUN_COVERAGE_PLAN_STATUS" == true ]]; then
        if ! coverage_plan_status; then
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

    print_header "Summary"

    if [[ $errors -eq 0 ]]; then
        print_status "$GREEN" "✓ Module 2 planning artifacts look structurally OK."
        echo ""
        print_status "$BLUE" "Next steps:"
        echo "  1. Flesh out test_plan.md with a rich test catalogue."
        echo "  2. Complete regression_plan.md with realistic tiers and runtimes."
        echo "  3. Refine coverage_plan.md to align tests and coverage goals."
    else
        print_status "$YELLOW" "Completed with $errors warning/error(s). See output above for details."
        exit 1
    fi

    {
        echo ""
        echo "=========================================="
        echo "Module 2 Planning Orchestrator Log - Completed"
        echo "Finished: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Exit code: $errors"
        echo "Log file: $LOG_FILE"
        echo "=========================================="
    } >> "$LOG_FILE"
}

main "$@"


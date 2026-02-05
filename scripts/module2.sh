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
                shift
                ;;
            --regression-status)
                RUN_TEST_PLAN_STATUS=false
                RUN_REGRESSION_PLAN_STATUS=true
                RUN_COVERAGE_PLAN_STATUS=false
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --coverage-status)
                RUN_TEST_PLAN_STATUS=false
                RUN_REGRESSION_PLAN_STATUS=false
                RUN_COVERAGE_PLAN_STATUS=true
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --checklist-status)
                RUN_TEST_PLAN_STATUS=false
                RUN_REGRESSION_PLAN_STATUS=false
                RUN_COVERAGE_PLAN_STATUS=false
                RUN_CHECKLIST_STATUS=true
                shift
                ;;
            --summary)
                RUN_TEST_PLAN_STATUS=true
                RUN_REGRESSION_PLAN_STATUS=true
                RUN_COVERAGE_PLAN_STATUS=true
                RUN_CHECKLIST_STATUS=true
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
        print_status "$RED" "test_plan.md not found at: $plan_file"
        echo "Hint: copy from module2/templates/ or edit the file in module2/ directly. Reference: module2/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$plan_file" || echo 0)
    todos=$(grep -c "TODO" "$plan_file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found test_plan.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in test_plan.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in test_plan.md."
    fi
}

regression_plan_status() {
    print_header "Regression Plan Status"

    local reg_file="$DOCS_DIR/REGRESSION_PLAN.md"

    if [[ ! -f "$reg_file" ]]; then
        print_status "$RED" "regression_plan.md not found at: $reg_file"
        echo "Hint: copy from module2/templates/ or edit the file in module2/ directly. Reference: module2/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$reg_file" || echo 0)
    todos=$(grep -c "TODO" "$reg_file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found regression_plan.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in regression_plan.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in regression_plan.md."
    fi
}

coverage_plan_status() {
    print_header "Coverage Plan Status"

    local cov_file="$DOCS_DIR/COVERAGE_PLAN.md"

    if [[ ! -f "$cov_file" ]]; then
        print_status "$YELLOW" "coverage_plan.md not found at: $cov_file"
        echo "Hint: coverage refinement is optional but recommended; copy from module2/templates/ (or create COVERAGE_PLAN.md) and edit in module2/. Reference: module2/.solutions/."
        return 0
    fi

    local lines todos
    lines=$(wc -l < "$cov_file" || echo 0)
    todos=$(grep -c "TODO" "$cov_file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found coverage_plan.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in coverage_plan.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in coverage_plan.md."
    fi
}

checklist_status() {
    print_header "Module 2 Checklist Status"

    local checklist_file="$DOCS_DIR/CHECKLIST.md"

    if [[ ! -f "$checklist_file" ]]; then
        print_status "$RED" "checklist_module2.md not found at: $checklist_file"
        echo "Hint: copy from module2/templates/ or edit the file in module2/ directly. Reference: module2/.solutions/."
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

    print_status "$GREEN" "Found checklist_module2.md."
    print_status "$BLUE"  "Checklist items: $total  |  Completed: $checked  |  Remaining: $unchecked"

    if [[ "$unchecked" -gt 0 ]]; then
        print_status "$YELLOW" "There are still unchecked items; review checklist_module2.md."
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


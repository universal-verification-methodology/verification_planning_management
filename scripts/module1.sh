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
                shift
                ;;
            --matrix-status)
                RUN_PLAN_STATUS=false
                RUN_MATRIX_STATUS=true
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --checklist-status)
                RUN_PLAN_STATUS=false
                RUN_MATRIX_STATUS=false
                RUN_CHECKLIST_STATUS=true
                shift
                ;;
            --summary)
                RUN_PLAN_STATUS=true
                RUN_MATRIX_STATUS=true
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
        print_status "$RED" "verification_plan.md not found at: $plan_file"
        echo "Hint: copy from module1/templates/ or edit the file in module1/ directly. Reference: module1/.solutions/."
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

    print_status "$GREEN" "Found verification_plan.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in plan: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in verification_plan.md."
    fi
}

matrix_status() {
    print_header "Requirements Matrix Status"

    local matrix_file="$DOCS_DIR/REQUIREMENTS_MATRIX.md"

    if [[ ! -f "$matrix_file" ]]; then
        print_status "$RED" "requirements_matrix.md not found at: $matrix_file"
        echo "Hint: copy from module1/templates/ or edit the file in module1/ directly. Reference: module1/.solutions/."
        return 1
    fi

    local req_count test_map_count cov_map_count

    # Count Req IDs in section 2 (simple heuristic)
    req_count=$(grep -E "^\| R[0-9]+" "$matrix_file" | wc -l || echo 0)
    test_map_count=$(grep -E "^\| R[0-9]+" "$matrix_file" | wc -l || echo 0)
    cov_map_count=$(grep -E "^\| R[0-9]+" "$matrix_file" | wc -l || echo 0)

    print_status "$GREEN" "Found requirements_matrix.md."
    print_status "$BLUE"  "Approx. requirement entries: $req_count"

    # Simple sanity: if zero, warn
    if [[ "$req_count" -eq 0 ]]; then
        print_status "$YELLOW" "No requirement rows detected yet (R1, R2, ...)."
    fi
}

checklist_status() {
    print_header "Checklist Status"

    local checklist_file="$DOCS_DIR/CHECKLIST.md"

    if [[ ! -f "$checklist_file" ]]; then
        print_status "$RED" "checklist_module1.md not found at: $checklist_file"
        echo "Hint: copy from module1/templates/ or edit the file in module1/ directly. Reference: module1/.solutions/."
        return 1
    fi

    local total unchecked checked
    # Count all checklist lines, allowing for no matches without aborting due to `set -e`.
    total=$(grep -c "^\- \[.\]" "$checklist_file" || true)
    unchecked=$(grep -c "^\- \[ \]" "$checklist_file" || true)
    # Treat both lowercase and uppercase checked boxes as completed using a single regex.
    checked=$(grep -Ec "^\- \[[xX]\]" "$checklist_file" || true)

    print_status "$GREEN" "Found checklist_module1.md."
    print_status "$BLUE"  "Checklist items: $total  |  Completed: $checked  |  Remaining: $unchecked"

    if [[ "$unchecked" -gt 0 ]]; then
        print_status "$YELLOW" "There are still unchecked items; review checklist_module1.md."
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


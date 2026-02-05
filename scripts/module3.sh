#!/usr/bin/env bash

# Module 3: Coverage Planning & Analysis Orchestrator
# This script summarizes and checks the coverage artifacts for Module 3.
# Usage: ./scripts/module3.sh [OPTIONS]

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
MODULE3_DIR="$PROJECT_ROOT/module3"
DOCS_DIR="$MODULE3_DIR"
LOG_FILE="$MODULE3_DIR/run.log"

# Options
RUN_COVERAGE_DESIGN_STATUS=true
RUN_COVERAGE_RUNS_STATUS=true
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

Module 3: Coverage Planning & Analysis in Practice (SV/UVM)
This script summarizes and checks the coverage artifacts for Module 3.

OPTIONS:
    --design-status        Show status of coverage_design.md only
    --runs-status          Show status of coverage_runs.md only
    --checklist-status     Show status of checklist_module3.md only
    --summary              Show all statuses (default)
    --help, -h             Show this help message

EXAMPLES:
    # Full summary
    $0

    # Focus only on coverage design
    $0 --design-status

EOF
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --design-status)
                RUN_COVERAGE_DESIGN_STATUS=true
                RUN_COVERAGE_RUNS_STATUS=false
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --runs-status)
                RUN_COVERAGE_DESIGN_STATUS=false
                RUN_COVERAGE_RUNS_STATUS=true
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --checklist-status)
                RUN_COVERAGE_DESIGN_STATUS=false
                RUN_COVERAGE_RUNS_STATUS=false
                RUN_CHECKLIST_STATUS=true
                shift
                ;;
            --summary)
                RUN_COVERAGE_DESIGN_STATUS=true
                RUN_COVERAGE_RUNS_STATUS=true
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
    print_status "$BLUE" "Checking basic Module 3 structure..."

    local missing=0

    if [[ ! -d "$MODULE3_DIR" ]]; then
        print_status "$RED" "module3/ directory not found at: $MODULE3_DIR"
        exit 1
    fi

    if [[ ! -d "$DOCS_DIR" ]]; then
        print_status "$YELLOW" "Directory missing: $DOCS_DIR"
        missing=$((missing + 1))
    fi

    if [[ $missing -eq 0 ]]; then
        print_status "$GREEN" "Basic Module 3 structure looks OK."
    else
        print_status "$YELLOW" "Some directories are missing; see messages above."
    fi
}

coverage_design_status() {
    print_header "Coverage Design Status"

    local design_file="$DOCS_DIR/COVERAGE_DESIGN.md"

    if [[ ! -f "$design_file" ]]; then
        print_status "$RED" "coverage_design.md not found at: $design_file"
        echo "Hint: copy from module3/templates/ or edit the file in module3/ directly. Reference: module3/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$design_file" || echo 0)
    todos=$(grep -c "TODO" "$design_file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found coverage_design.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in coverage_design.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in coverage_design.md."
    fi
}

coverage_runs_status() {
    print_header "Coverage Runs Log Status"

    local runs_file="$DOCS_DIR/COVERAGE_RUN.md"

    if [[ ! -f "$runs_file" ]]; then
        print_status "$RED" "coverage_runs.md not found at: $runs_file"
        echo "Hint: copy from module3/templates/ or edit the file in module3/ directly. Reference: module3/.solutions/."
        return 1
    fi

    local lines runs
    lines=$(wc -l < "$runs_file" || echo 0)
    runs=$(grep -c "^### Run " "$runs_file" 2>/dev/null)
    runs=${runs:-0}

    print_status "$GREEN" "Found coverage_runs.md ($lines lines)."
    if [[ "$runs" -gt 0 ]]; then
        print_status "$BLUE" "Documented coverage runs: $runs"
    else
        print_status "$YELLOW" "No coverage runs logged yet (no '### Run N' sections)."
    fi
}

checklist_status() {
    print_header "Module 3 Checklist Status"

    local checklist_file="$DOCS_DIR/CHECKLIST.md"

    if [[ ! -f "$checklist_file" ]]; then
        print_status "$RED" "checklist_module3.md not found at: $checklist_file"
        echo "Hint: copy from module3/templates/ or edit the file in module3/ directly. Reference: module3/.solutions/."
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

    print_status "$GREEN" "Found checklist_module3.md."
    print_status "$BLUE"  "Checklist items: $total  |  Completed: $checked  |  Remaining: $unchecked"

    if [[ "$unchecked" -gt 0 ]]; then
        print_status "$YELLOW" "There are still unchecked items; review checklist_module3.md."
    else
        print_status "$GREEN" "All checklist items appear to be completed."
    fi
}

main() {
    # Initialize logging
    mkdir -p "$MODULE3_DIR"
    {
        echo "=========================================="
        echo "Module 3 Coverage Orchestrator Log"
        echo "Started: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Command: $0 $*"
        echo "Project root: $PROJECT_ROOT"
        echo "Module dir : $MODULE3_DIR"
        echo "=========================================="
        echo ""
    } > "$LOG_FILE"

    exec 3>&1
    exec > >(tee -a "$LOG_FILE" >&3)
    exec 2>&1

    print_header "Module 3: Coverage Planning & Analysis in Practice"

    parse_args "$@"
    check_structure

    local errors=0

    if [[ "$RUN_COVERAGE_DESIGN_STATUS" == true ]]; then
        if ! coverage_design_status; then
            errors=$((errors + 1))
        fi
    fi

    if [[ "$RUN_COVERAGE_RUNS_STATUS" == true ]]; then
        if ! coverage_runs_status; then
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
        print_status "$GREEN" "✓ Module 3 coverage artifacts look structurally OK."
        echo ""
        print_status "$BLUE" "Next steps:"
        echo "  1. Implement the covergroups described in coverage_design.md."
        echo "  2. Run at least one coverage-enabled regression and log it in coverage_runs.md."
        echo "  3. Use checklist_module3.md to drive closure and readiness for Module 4."
    else
        print_status "$YELLOW" "Completed with $errors warning/error(s). See output above for details."
        exit 1
    fi

    {
        echo ""
        echo "=========================================="
        echo "Module 3 Coverage Orchestrator Log - Completed"
        echo "Finished: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Exit code: $errors"
        echo "Log file: $LOG_FILE"
        echo "=========================================="
    } >> "$LOG_FILE"
}

main "$@"


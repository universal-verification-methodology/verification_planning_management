#!/usr/bin/env bash

# Module 4: UVM Environment & Checker Orchestrator
# This script summarizes and checks the artifacts for Module 4.
# Usage: ./scripts/module4.sh [OPTIONS]

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
MODULE4_DIR="$PROJECT_ROOT/module4"
DOCS_DIR="$MODULE4_DIR"
LOG_FILE="$MODULE4_DIR/run.log"

# Options
RUN_ENV_DESIGN_STATUS=true
RUN_CHECKER_PLAN_STATUS=true
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

Module 4: UVM Environment & Checker Maturity (SV/UVM)
This script summarizes and checks the planning artifacts for Module 4.

OPTIONS:
    --env-status          Show status of env_design.md only
    --checker-status      Show status of checker_plan.md only
    --checklist-status    Show status of checklist_module4.md only
    --summary             Show all statuses (default)
    --help, -h            Show this help message

EXAMPLES:
    # Full summary
    $0

    # Focus only on environment design
    $0 --env-status

EOF
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --env-status)
                RUN_ENV_DESIGN_STATUS=true
                RUN_CHECKER_PLAN_STATUS=false
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --checker-status)
                RUN_ENV_DESIGN_STATUS=false
                RUN_CHECKER_PLAN_STATUS=true
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --checklist-status)
                RUN_ENV_DESIGN_STATUS=false
                RUN_CHECKER_PLAN_STATUS=false
                RUN_CHECKLIST_STATUS=true
                shift
                ;;
            --summary)
                RUN_ENV_DESIGN_STATUS=true
                RUN_CHECKER_PLAN_STATUS=true
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
    print_status "$BLUE" "Checking basic Module 4 structure..."

    local missing=0

    if [[ ! -d "$MODULE4_DIR" ]]; then
        print_status "$RED" "module4/ directory not found at: $MODULE4_DIR"
        exit 1
    fi

    if [[ ! -d "$DOCS_DIR" ]]; then
        print_status "$YELLOW" "Directory missing: $DOCS_DIR"
        missing=$((missing + 1))
    fi

    if [[ $missing -eq 0 ]]; then
        print_status "$GREEN" "Basic Module 4 structure looks OK."
    else
        print_status "$YELLOW" "Some directories are missing; see messages above."
    fi
}

env_design_status() {
    print_header "Environment Design Status"

    local env_file="$DOCS_DIR/ENV_DESIGN.md"

    if [[ ! -f "$env_file" ]]; then
        print_status "$RED" "env_design.md not found at: $env_file"
        echo "Hint: copy from module4/templates/ or edit the file in module4/ directly. Reference: module4/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$env_file" || echo 0)
    todos=$(grep -c "TODO" "$env_file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found env_design.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in env_design.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in env_design.md."
    fi
}

checker_plan_status() {
    print_header "Checker Plan Status"

    local checker_file="$DOCS_DIR/CHECKER_PLAN.md"

    if [[ ! -f "$checker_file" ]]; then
        print_status "$RED" "checker_plan.md not found at: $checker_file"
        echo "Hint: copy from module4/templates/ or edit the file in module4/ directly. Reference: module4/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$checker_file" || echo 0)
    todos=$(grep -c "TODO" "$checker_file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found checker_plan.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in checker_plan.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in checker_plan.md."
    fi
}

checklist_status() {
    print_header "Module 4 Checklist Status"

    local checklist_file="$DOCS_DIR/CHECKLIST.md"

    if [[ ! -f "$checklist_file" ]]; then
        print_status "$RED" "checklist_module4.md not found at: $checklist_file"
        echo "Hint: copy from module4/templates/ or edit the file in module4/ directly. Reference: module4/.solutions/."
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

    print_status "$GREEN" "Found checklist_module4.md."
    print_status "$BLUE"  "Checklist items: $total  |  Completed: $checked  |  Remaining: $unchecked"

    if [[ "$unchecked" -gt 0 ]]; then
        print_status "$YELLOW" "There are still unchecked items; review checklist_module4.md."
    else
        print_status "$GREEN" "All checklist items appear to be completed."
    fi
}

main() {
    # Initialize logging
    mkdir -p "$MODULE4_DIR"
    {
        echo "=========================================="
        echo "Module 4 Environment & Checker Log"
        echo "Started: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Command: $0 $*"
        echo "Project root: $PROJECT_ROOT"
        echo "Module dir : $MODULE4_DIR"
        echo "=========================================="
        echo ""
    } > "$LOG_FILE"

    exec 3>&1
    exec > >(tee -a "$LOG_FILE" >&3)
    exec 2>&1

    print_header "Module 4: UVM Environment & Checker Maturity"

    parse_args "$@"
    check_structure

    local errors=0

    if [[ "$RUN_ENV_DESIGN_STATUS" == true ]]; then
        if ! env_design_status; then
            errors=$((errors + 1))
        fi
    fi

    if [[ "$RUN_CHECKER_PLAN_STATUS" == true ]]; then
        if ! checker_plan_status; then
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
        print_status "$GREEN" "✓ Module 4 environment & checker artifacts look structurally OK."
        echo ""
        print_status "$BLUE" "Next steps:"
        echo "  1. Implement/refine the env/agent structure from env_design.md in common_dut/tb/."
        echo "  2. Implement scoreboards, reference models, and assertions from checker_plan.md."
        echo "  3. Use checklist_module4.md to track review and readiness for Module 5."
    else
        print_status "$YELLOW" "Completed with $errors warning/error(s). See output above for details."
        exit 1
    fi

    {
        echo ""
        echo "=========================================="
        echo "Module 4 Environment & Checker Log - Completed"
        echo "Finished: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Exit code: $errors"
        echo "Log file: $LOG_FILE"
        echo "=========================================="
    } >> "$LOG_FILE"
}

main "$@"


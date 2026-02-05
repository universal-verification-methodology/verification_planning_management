#!/usr/bin/env bash

# Module 5: Regression & Advanced UVM Orchestrator
# This script summarizes and checks the artifacts for Module 5.
# Usage: ./scripts/module5.sh [OPTIONS]

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
MODULE5_DIR="$PROJECT_ROOT/module5"
DOCS_DIR="$MODULE5_DIR"
LOG_FILE="$MODULE5_DIR/run.log"

# Options
RUN_REGRESSION_OPS_STATUS=true
RUN_ADV_UVM_STATUS=true
RUN_DEBUG_FLAKE_STATUS=true
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

Module 5: Regression Management & Advanced UVM Orchestration (SV/UVM)
This script summarizes and checks the planning artifacts for Module 5.

OPTIONS:
    --regression-status    Show status of regression_ops.md only
    --uvm-status           Show status of advanced_uvm_plan.md only
    --debug-status         Show status of debug_flake_plan.md only
    --checklist-status     Show status of checklist_module5.md only
    --summary              Show all statuses (default)
    --help, -h             Show this help message

EXAMPLES:
    # Full summary
    $0

    # Focus only on regression operations
    $0 --regression-status

EOF
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --regression-status)
                RUN_REGRESSION_OPS_STATUS=true
                RUN_ADV_UVM_STATUS=false
                RUN_DEBUG_FLAKE_STATUS=false
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --uvm-status)
                RUN_REGRESSION_OPS_STATUS=false
                RUN_ADV_UVM_STATUS=true
                RUN_DEBUG_FLAKE_STATUS=false
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --debug-status)
                RUN_REGRESSION_OPS_STATUS=false
                RUN_ADV_UVM_STATUS=false
                RUN_DEBUG_FLAKE_STATUS=true
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --checklist-status)
                RUN_REGRESSION_OPS_STATUS=false
                RUN_ADV_UVM_STATUS=false
                RUN_DEBUG_FLAKE_STATUS=false
                RUN_CHECKLIST_STATUS=true
                shift
                ;;
            --summary)
                RUN_REGRESSION_OPS_STATUS=true
                RUN_ADV_UVM_STATUS=true
                RUN_DEBUG_FLAKE_STATUS=true
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
    print_status "$BLUE" "Checking basic Module 5 structure..."

    local missing=0

    if [[ ! -d "$MODULE5_DIR" ]]; then
        print_status "$RED" "module5/ directory not found at: $MODULE5_DIR"
        exit 1
    fi

    if [[ ! -d "$DOCS_DIR" ]]; then
        print_status "$YELLOW" "Directory missing: $DOCS_DIR"
        missing=$((missing + 1))
    fi

    if [[ $missing -eq 0 ]]; then
        print_status "$GREEN" "Basic Module 5 structure looks OK."
    else
        print_status "$YELLOW" "Some directories are missing; see messages above."
    fi
}

regression_ops_status() {
    print_header "Regression Ops Status"

    local file="$DOCS_DIR/REGRESSION_OPS.md"

    if [[ ! -f "$file" ]]; then
        print_status "$RED" "regression_ops.md not found at: $file"
        echo "Hint: copy from module5/templates/ or edit the file in module5/ directly. Reference: module5/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$file" || echo 0)
    todos=$(grep -c "TODO" "$file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found regression_ops.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in regression_ops.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in regression_ops.md."
    fi
}

advanced_uvm_status() {
    print_header "Advanced UVM Plan Status"

    local file="$DOCS_DIR/ADVANCED_UVM_PLAN.md"

    if [[ ! -f "$file" ]]; then
        print_status "$RED" "advanced_uvm_plan.md not found at: $file"
        echo "Hint: copy from module5/templates/ or edit the file in module5/ directly. Reference: module5/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$file" || echo 0)
    todos=$(grep -c "TODO" "$file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found advanced_uvm_plan.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in advanced_uvm_plan.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in advanced_uvm_plan.md."
    fi
}

debug_flake_status() {
    print_header "Debug / Flake Plan Status"

    local file="$DOCS_DIR/DEBUG_FLAKE_PLAN.md"

    if [[ ! -f "$file" ]]; then
        print_status "$RED" "debug_flake_plan.md not found at: $file"
        echo "Hint: copy from module5/templates/ or edit the file in module5/ directly. Reference: module5/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$file" || echo 0)
    todos=$(grep -c "TODO" "$file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found debug_flake_plan.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in debug_flake_plan.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in debug_flake_plan.md."
    fi
}

checklist_status() {
    print_header "Module 5 Checklist Status"

    local file="$DOCS_DIR/CHECKLIST.md"

    if [[ ! -f "$file" ]]; then
        print_status "$RED" "checklist_module5.md not found at: $file"
        echo "Hint: copy from module5/templates/ or edit the file in module5/ directly. Reference: module5/.solutions/."
        return 1
    fi

    local total unchecked checked checked_x checked_X
    total=$(grep -c "^\- \[.\]" "$file" 2>/dev/null)
    total=${total:-0}
    unchecked=$(grep -c "^\- \[ \]" "$file" 2>/dev/null)
    unchecked=${unchecked:-0}
    checked_x=$(grep -c "^\- \[x\]" "$file" 2>/dev/null)
    checked_x=${checked_x:-0}
    checked_X=$(grep -c "^\- \[X\]" "$file" 2>/dev/null)
    checked_X=${checked_X:-0}
    checked=$((checked_x + checked_X))

    print_status "$GREEN" "Found checklist_module5.md."
    print_status "$BLUE"  "Checklist items: $total  |  Completed: $checked  |  Remaining: $unchecked"

    if [[ "$unchecked" -gt 0 ]]; then
        print_status "$YELLOW" "There are still unchecked items; review checklist_module5.md."
    else
        print_status "$GREEN" "All checklist items appear to be completed."
    fi
}

main() {
    # Initialize logging
    mkdir -p "$MODULE5_DIR"
    {
        echo "=========================================="
        echo "Module 5 Regression & UVM Log"
        echo "Started: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Command: $0 $*"
        echo "Project root: $PROJECT_ROOT"
        echo "Module dir : $MODULE5_DIR"
        echo "=========================================="
        echo ""
    } > "$LOG_FILE"

    exec 3>&1
    exec > >(tee -a "$LOG_FILE" >&3)
    exec 2>&1

    print_header "Module 5: Regression Management & Advanced UVM Orchestration"

    parse_args "$@"
    check_structure

    local errors=0

    if [[ "$RUN_REGRESSION_OPS_STATUS" == true ]]; then
        if ! regression_ops_status; then
            errors=$((errors + 1))
        fi
    fi

    if [[ "$RUN_ADV_UVM_STATUS" == true ]]; then
        if ! advanced_uvm_status; then
            errors=$((errors + 1))
        fi
    fi

    if [[ "$RUN_DEBUG_FLAKE_STATUS" == true ]]; then
        if ! debug_flake_status; then
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
        print_status "$GREEN" "✓ Module 5 regression & advanced UVM artifacts look structurally OK."
        echo ""
        print_status "$BLUE" "Next steps:"
        echo "  1. Implement regression jobs defined in regression_ops.md."
        echo "  2. Implement virtual sequences/config/callbacks from advanced_uvm_plan.md."
        echo "  3. Apply debug/flake policies from debug_flake_plan.md and track progress via checklist_module5.md."
    else
        print_status "$YELLOW" "Completed with $errors warning/error(s). See output above for details."
        exit 1
    fi

    {
        echo ""
        echo "=========================================="
        echo "Module 5 Regression & UVM Log - Completed"
        echo "Finished: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Exit code: $errors"
        echo "Log file: $LOG_FILE"
        echo "=========================================="
    } >> "$LOG_FILE"
}

main "$@"


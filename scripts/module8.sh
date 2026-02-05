#!/usr/bin/env bash

# Module 8: Capstone Orchestrator
# This script summarizes and checks the artifacts for the Module 8 capstone.
# Usage: ./scripts/module8.sh [OPTIONS]

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
MODULE8_DIR="$PROJECT_ROOT/module8"
DOCS_DIR="$MODULE8_DIR"
LOG_FILE="$MODULE8_DIR/run.log"

# Options
RUN_CAPSTONE_STATUS=true
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

Module 8: Capstone – End‑to‑End Verification & VIP Delivery (SV/UVM)
This script summarizes and checks the capstone planning artifacts for Module 8.

OPTIONS:
    --capstone-status      Show status of capstone_project.md only
    --checklist-status     Show status of checklist_module8.md only
    --summary              Show both statuses (default)
    --help, -h             Show this help message

EXAMPLES:
    # Full summary
    $0

    # Focus only on capstone project plan
    $0 --capstone-status

EOF
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --capstone-status)
                RUN_CAPSTONE_STATUS=true
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --checklist-status)
                RUN_CAPSTONE_STATUS=false
                RUN_CHECKLIST_STATUS=true
                shift
                ;;
            --summary)
                RUN_CAPSTONE_STATUS=true
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
    print_status "$BLUE" "Checking basic Module 8 structure..."

    local missing=0

    if [[ ! -d "$MODULE8_DIR" ]]; then
        print_status "$RED" "module8/ directory not found at: $MODULE8_DIR"
        exit 1
    fi

    if [[ ! -d "$MODULE8_DIR" ]]; then
        print_status "$RED" "module8/ directory not found at: $MODULE8_DIR"
        exit 1
    fi

    if [[ $missing -eq 0 ]]; then
        print_status "$GREEN" "Basic Module 8 structure looks OK."
    else
        print_status "$YELLOW" "Some directories are missing; see messages above."
    fi
}

capstone_status() {
    print_header "Capstone Project Plan Status"

    local file="$DOCS_DIR/CAPSTONE_PROJECT.md"

    if [[ ! -f "$file" ]]; then
        print_status "$RED" "CAPSTONE_PROJECT.md not found at: $file"
        echo "Hint: copy from module8/templates/ or edit the file in module8/ directly. Reference: module8/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$file" || echo 0)
    todos=$(grep -c "TODO" "$file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found CAPSTONE_PROJECT.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in capstone_project.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in capstone_project.md."
    fi
}

checklist_status() {
    print_header "Module 8 Checklist Status"

    local file="$DOCS_DIR/CHECKLIST.md"

    if [[ ! -f "$file" ]]; then
        print_status "$RED" "CHECKLIST.md not found at: $file"
        echo "Hint: copy from module8/templates/ or edit the file in module8/ directly. Reference: module8/.solutions/."
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

    print_status "$GREEN" "Found CHECKLIST.md."
    print_status "$BLUE"  "Checklist items: $total  |  Completed: $checked  |  Remaining: $unchecked"

    if [[ "$unchecked" -gt 0 ]]; then
        print_status "$YELLOW" "There are still unchecked items; review checklist_module8.md."
    else
        print_status "$GREEN" "All checklist items appear to be completed."
    fi
}

main() {
    # Initialize logging
    mkdir -p "$MODULE8_DIR"
    {
        echo "=========================================="
        echo "Module 8 Capstone Log"
        echo "Started: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Command: $0 $*"
        echo "Project root: $PROJECT_ROOT"
        echo "Module dir : $MODULE8_DIR"
        echo "=========================================="
        echo ""
    } > "$LOG_FILE"

    exec 3>&1
    exec > >(tee -a "$LOG_FILE" >&3)
    exec 2>&1

    print_header "Module 8: Capstone – End‑to‑End Verification & VIP Delivery"

    parse_args "$@"
    check_structure

    local errors=0

    if [[ "$RUN_CAPSTONE_STATUS" == true ]]; then
        if ! capstone_status; then
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
        print_status "$GREEN" "✓ Module 8 capstone planning artifacts look structurally OK."
        echo ""
        print_status "$BLUE" "Next steps:"
        echo "  1. Implement the capstone described in capstone_project.md."
        echo "  2. Use checklist_module8.md to track progress toward completion."
    else
        print_status "$YELLOW" "Completed with $errors warning/error(s). See output above for details."
        exit 1
    fi

    {
        echo ""
        echo "=========================================="
        echo "Module 8 Capstone Log - Completed"
        echo "Finished: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Exit code: $errors"
        echo "Log file: $LOG_FILE"
        echo "=========================================="
    } >> "$LOG_FILE"
}

main "$@"


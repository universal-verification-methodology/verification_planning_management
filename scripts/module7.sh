#!/usr/bin/env bash

# Module 7: Real-World Applications & VIP Orchestrator
# This script summarizes and checks the artifacts for Module 7.
# Usage: ./scripts/module7.sh [OPTIONS]

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
MODULE7_DIR="$PROJECT_ROOT/module7"
DOCS_DIR="$MODULE7_DIR"
LOG_FILE="$MODULE7_DIR/run.log"

# Options
RUN_PROJECTS_STATUS=true
RUN_VIP_STATUS=true
RUN_BEST_PRACTICES_STATUS=true
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

Module 7: Real-World Verification Applications & VIP (SV/UVM)
This script summarizes and checks the planning artifacts for Module 7.

OPTIONS:
    --projects-status      Show status of projects.md only
    --vip-status           Show status of vip_design.md only
    --best-practices       Show status of best_practices.md only
    --checklist-status     Show status of checklist_module7.md only
    --summary              Show all statuses (default)
    --help, -h             Show this help message

EXAMPLES:
    # Full summary
    $0

    # Focus only on VIP design
    $0 --vip-status

EOF
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --projects-status)
                RUN_PROJECTS_STATUS=true
                RUN_VIP_STATUS=false
                RUN_BEST_PRACTICES_STATUS=false
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --vip-status)
                RUN_PROJECTS_STATUS=false
                RUN_VIP_STATUS=true
                RUN_BEST_PRACTICES_STATUS=false
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --best-practices)
                RUN_PROJECTS_STATUS=false
                RUN_VIP_STATUS=false
                RUN_BEST_PRACTICES_STATUS=true
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --checklist-status)
                RUN_PROJECTS_STATUS=false
                RUN_VIP_STATUS=false
                RUN_BEST_PRACTICES_STATUS=false
                RUN_CHECKLIST_STATUS=true
                shift
                ;;
            --summary)
                RUN_PROJECTS_STATUS=true
                RUN_VIP_STATUS=true
                RUN_BEST_PRACTICES_STATUS=true
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
    print_status "$BLUE" "Checking basic Module 7 structure..."

    local missing=0

    if [[ ! -d "$MODULE7_DIR" ]]; then
        print_status "$RED" "module7/ directory not found at: $MODULE7_DIR"
        exit 1
    fi

    if [[ ! -d "$DOCS_DIR" ]]; then
        print_status "$YELLOW" "Directory missing: $DOCS_DIR"
        missing=$((missing + 1))
    fi

    if [[ $missing -eq 0 ]]; then
        print_status "$GREEN" "Basic Module 7 structure looks OK."
    else
        print_status "$YELLOW" "Some directories are missing; see messages above."
    fi
}

projects_status() {
    print_header "Projects Status"

    local file="$DOCS_DIR/PROJECTS.md"

    if [[ ! -f "$file" ]]; then
        print_status "$RED" "projects.md not found at: $file"
        echo "Hint: copy from module7/templates/ or edit the file in module7/ directly. Reference: module7/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$file" || echo 0)
    todos=$(grep -c "TODO" "$file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found projects.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in projects.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in projects.md."
    fi
}

vip_status() {
    print_header "VIP Design Status"

    local file="$DOCS_DIR/VIP_DESIGN.md"

    if [[ ! -f "$file" ]]; then
        print_status "$RED" "vip_design.md not found at: $file"
        echo "Hint: copy from module7/templates/ or edit the file in module7/ directly. Reference: module7/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$file" || echo 0)
    todos=$(grep -c "TODO" "$file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found vip_design.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in vip_design.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in vip_design.md."
    fi
}

best_practices_status() {
    print_header "Best Practices Status"

    local file="$DOCS_DIR/BEST_PRACTICES.md"

    if [[ ! -f "$file" ]]; then
        print_status "$RED" "best_practices.md not found at: $file"
        echo "Hint: copy from module7/templates/ or edit the file in module7/ directly. Reference: module7/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$file" || echo 0)
    todos=$(grep -c "TODO" "$file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found best_practices.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in best_practices.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in best_practices.md."
    fi
}

checklist_status() {
    print_header "Module 7 Checklist Status"

    local file="$DOCS_DIR/CHECKLIST.md"

    if [[ ! -f "$file" ]]; then
        print_status "$RED" "checklist_module7.md not found at: $file"
        echo "Hint: copy from module7/templates/ or edit the file in module7/ directly. Reference: module7/.solutions/."
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

    print_status "$GREEN" "Found checklist_module7.md."
    print_status "$BLUE"  "Checklist items: $total  |  Completed: $checked  |  Remaining: $unchecked"

    if [[ "$unchecked" -gt 0 ]]; then
        print_status "$YELLOW" "There are still unchecked items; review checklist_module7.md."
    else
        print_status "$GREEN" "All checklist items appear to be completed."
    fi
}

main() {
    # Initialize logging
    mkdir -p "$MODULE7_DIR"
    {
        echo "=========================================="
        echo "Module 7 Real-World & VIP Log"
        echo "Started: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Command: $0 $*"
        echo "Project root: $PROJECT_ROOT"
        echo "Module dir : $MODULE7_DIR"
        echo "=========================================="
        echo ""
    } > "$LOG_FILE"

    exec 3>&1
    exec > >(tee -a "$LOG_FILE" >&3)
    exec 2>&1

    print_header "Module 7: Real-World Verification Applications & VIP"

    parse_args "$@"
    check_structure

    local errors=0

    if [[ "$RUN_PROJECTS_STATUS" == true ]]; then
        if ! projects_status; then
            errors=$((errors + 1))
        fi
    fi

    if [[ "$RUN_VIP_STATUS" == true ]]; then
        if ! vip_status; then
            errors=$((errors + 1))
        fi
    fi

    if [[ "$RUN_BEST_PRACTICES_STATUS" == true ]]; then
        if ! best_practices_status; then
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
        print_status "$GREEN" "✓ Module 7 real-world & VIP artifacts look structurally OK."
        echo ""
        print_status "$BLUE" "Next steps:"
        echo "  1. Implement the projects defined in projects.md."
        echo "  2. Build out the VIP structure described in vip_design.md."
        echo "  3. Use best_practices.md and checklist_module7.md to guide production-quality implementation."
    else
        print_status "$YELLOW" "Completed with $errors warning/error(s). See output above for details."
        exit 1
    fi

    {
        echo ""
        echo "=========================================="
        echo "Module 7 Real-World & VIP Log - Completed"
        echo "Finished: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Exit code: $errors"
        echo "Log file: $LOG_FILE"
        echo "=========================================="
    } >> "$LOG_FILE"
}

main "$@"


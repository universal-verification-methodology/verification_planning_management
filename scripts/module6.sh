#!/usr/bin/env bash

# Module 6: Complex Testbench Orchestrator
# This script summarizes and checks the artifacts for Module 6.
# Usage: ./scripts/module6.sh [OPTIONS]

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
MODULE6_DIR="$PROJECT_ROOT/module6"
DOCS_DIR="$MODULE6_DIR"
LOG_FILE="$MODULE6_DIR/run.log"

# Options
RUN_MULTI_AGENT_STATUS=true
RUN_PROTOCOL_STATUS=true
RUN_INTEGRATION_STATUS=true
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

Module 6: Complex Multi-Agent & Protocol Testbenches (SV/UVM)
This script summarizes and checks the planning artifacts for Module 6.

OPTIONS:
    --multi-agent-status   Show status of multi_agent_architecture.md only
    --protocol-status      Show status of protocol_verification_plan.md only
    --integration-status   Show status of integration_plan.md only
    --checklist-status     Show status of checklist_module6.md only
    --summary              Show all statuses (default)
    --help, -h             Show this help message

EXAMPLES:
    # Full summary
    $0

    # Focus only on multi-agent architecture
    $0 --multi-agent-status

EOF
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --multi-agent-status)
                RUN_MULTI_AGENT_STATUS=true
                RUN_PROTOCOL_STATUS=false
                RUN_INTEGRATION_STATUS=false
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --protocol-status)
                RUN_MULTI_AGENT_STATUS=false
                RUN_PROTOCOL_STATUS=true
                RUN_INTEGRATION_STATUS=false
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --integration-status)
                RUN_MULTI_AGENT_STATUS=false
                RUN_PROTOCOL_STATUS=false
                RUN_INTEGRATION_STATUS=true
                RUN_CHECKLIST_STATUS=false
                shift
                ;;
            --checklist-status)
                RUN_MULTI_AGENT_STATUS=false
                RUN_PROTOCOL_STATUS=false
                RUN_INTEGRATION_STATUS=false
                RUN_CHECKLIST_STATUS=true
                shift
                ;;
            --summary)
                RUN_MULTI_AGENT_STATUS=true
                RUN_PROTOCOL_STATUS=true
                RUN_INTEGRATION_STATUS=true
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
    print_status "$BLUE" "Checking basic Module 6 structure..."

    local missing=0

    if [[ ! -d "$MODULE6_DIR" ]]; then
        print_status "$RED" "module6/ directory not found at: $MODULE6_DIR"
        exit 1
    fi

    if [[ ! -d "$DOCS_DIR" ]]; then
        print_status "$YELLOW" "Directory missing: $DOCS_DIR"
        missing=$((missing + 1))
    fi

    if [[ $missing -eq 0 ]]; then
        print_status "$GREEN" "Basic Module 6 structure looks OK."
    else
        print_status "$YELLOW" "Some directories are missing; see messages above."
    fi
}

multi_agent_status() {
    print_header "Multi-Agent Architecture Status"

    local file="$DOCS_DIR/MULTI_AGENT_ARCHITECTURE.md"

    if [[ ! -f "$file" ]]; then
        print_status "$RED" "multi_agent_architecture.md not found at: $file"
        echo "Hint: copy from module6/templates/ or edit the file in module6/ directly. Reference: module6/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$file" || echo 0)
    todos=$(grep -c "TODO" "$file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found multi_agent_architecture.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in multi_agent_architecture.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in multi_agent_architecture.md."
    fi
}

protocol_status() {
    print_header "Protocol Verification Plan Status"

    local file="$DOCS_DIR/PROTOCOL_VERIFICATION_PLAN.md"

    if [[ ! -f "$file" ]]; then
        print_status "$RED" "protocol_verification_plan.md not found at: $file"
        echo "Hint: copy from module6/templates/ or edit the file in module6/ directly. Reference: module6/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$file" || echo 0)
    todos=$(grep -c "TODO" "$file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found protocol_verification_plan.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in protocol_verification_plan.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in protocol_verification_plan.md."
    fi
}

integration_status() {
    print_header "Integration Plan Status"

    local file="$DOCS_DIR/INTEGRATION_PLAN.md"

    if [[ ! -f "$file" ]]; then
        print_status "$RED" "integration_plan.md not found at: $file"
        echo "Hint: copy from module6/templates/ or edit the file in module6/ directly. Reference: module6/.solutions/."
        return 1
    fi

    local lines todos
    lines=$(wc -l < "$file" || echo 0)
    todos=$(grep -c "TODO" "$file" 2>/dev/null)
    todos=${todos:-0}

    print_status "$GREEN" "Found integration_plan.md ($lines lines)."
    if [[ "$todos" -gt 0 ]]; then
        print_status "$YELLOW" "Remaining TODO markers in integration_plan.md: $todos"
    else
        print_status "$GREEN" "No explicit TODO markers found in integration_plan.md."
    fi
}

checklist_status() {
    print_header "Module 6 Checklist Status"

    local file="$DOCS_DIR/CHECKLIST.md"

    if [[ ! -f "$file" ]]; then
        print_status "$RED" "checklist_module6.md not found at: $file"
        echo "Hint: copy from module6/templates/ or edit the file in module6/ directly. Reference: module6/.solutions/."
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

    print_status "$GREEN" "Found checklist_module6.md."
    print_status "$BLUE"  "Checklist items: $total  |  Completed: $checked  |  Remaining: $unchecked"

    if [[ "$unchecked" -gt 0 ]]; then
        print_status "$YELLOW" "There are still unchecked items; review checklist_module6.md."
    else
        print_status "$GREEN" "All checklist items appear to be completed."
    fi
}

main() {
    # Initialize logging
    mkdir -p "$MODULE6_DIR"
    {
        echo "=========================================="
        echo "Module 6 Complex Testbench Log"
        echo "Started: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Command: $0 $*"
        echo "Project root: $PROJECT_ROOT"
        echo "Module dir : $MODULE6_DIR"
        echo "=========================================="
        echo ""
    } > "$LOG_FILE"

    exec 3>&1
    exec > >(tee -a "$LOG_FILE" >&3)
    exec 2>&1

    print_header "Module 6: Complex Multi-Agent & Protocol Testbenches"

    parse_args "$@"
    check_structure

    local errors=0

    if [[ "$RUN_MULTI_AGENT_STATUS" == true ]]; then
        if ! multi_agent_status; then
            errors=$((errors + 1))
        fi
    fi

    if [[ "$RUN_PROTOCOL_STATUS" == true ]]; then
        if ! protocol_status; then
            errors=$((errors + 1))
        fi
    fi

    if [[ "$RUN_INTEGRATION_STATUS" == true ]]; then
        if ! integration_status; then
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
        print_status "$GREEN" "✓ Module 6 complex testbench artifacts look structurally OK."
        echo ""
        print_status "$BLUE" "Next steps:"
        echo "  1. Implement/extend multi-agent env per multi_agent_architecture.md."
        echo "  2. Implement protocol agents/checkers from protocol_verification_plan.md."
        echo "  3. Exercise integration scenarios from integration_plan.md and track progress via checklist_module6.md."
    else
        print_status "$YELLOW" "Completed with $errors warning/error(s). See output above for details."
        exit 1
    fi

    {
        echo ""
        echo "=========================================="
        echo "Module 6 Complex Testbench Log - Completed"
        echo "Finished: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Exit code: $errors"
        echo "Log file: $LOG_FILE"
        echo "=========================================="
    } >> "$LOG_FILE"
}

main "$@"


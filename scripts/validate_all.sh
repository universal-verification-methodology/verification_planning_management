#!/usr/bin/env bash

# Validate All Modules: runs each moduleN.sh and prints a combined report.
# Usage: ./scripts/validate_all.sh [OPTIONS]
#
# Options:
#   --modules 1,2,3     Comma-separated list of module numbers (default: 1 2 3 4 5 6 7 8)
#   --quiet              Only print summary (no per-module output)
#   --help, -h           Show this help

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

MODULES="1 2 3 4 5 6 7 8"
QUIET=false

show_usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Runs each module validation script (module1.sh … module8.sh) and prints
a combined pass/fail summary.

OPTIONS:
    --modules 1,2,3     Comma-separated list of module numbers (default: 1–8)
    --quiet             Only print summary; do not show per-module output
    --help, -h          Show this help

EXAMPLES:
    $0                  # Validate all modules (full output)
    $0 --quiet          # Validate all, summary only
    $0 --modules 1,2    # Validate only Module 1 and Module 2

EOF
}

while [[ $# -gt 0 ]]; do
    case $1 in
        --modules)
            [[ -n "${2:-}" ]] || { echo "Missing value for --modules"; show_usage; exit 1; }
            MODULES=$(echo "$2" | tr ',' ' ')
            shift 2
            ;;
        --quiet)
            QUIET=true
            shift
            ;;
        --help|-h)
            show_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

declare -a RESULTS
FAILED=0

echo ""
echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}Validate All Modules${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""

for n in $MODULES; do
    script="$SCRIPT_DIR/module${n}.sh"
    if [[ ! -f "$script" ]]; then
        echo -e "${YELLOW}Module $n: script not found ($script) — skipped${NC}"
        RESULTS+=("Module $n: SKIP (no script)")
        continue
    fi
    if [[ "$QUIET" == true ]]; then
        if "$script" --summary &>/dev/null; then
            RESULTS+=("Module $n: OK")
        else
            RESULTS+=("Module $n: FAIL")
            FAILED=$((FAILED + 1))
        fi
    else
        echo -e "${CYAN}---------- Module $n ----------${NC}"
        if "$script" --summary 2>&1; then
            RESULTS+=("Module $n: OK")
        else
            RESULTS+=("Module $n: FAIL")
            FAILED=$((FAILED + 1))
        fi
        echo ""
    fi
done

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}Summary${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
for line in "${RESULTS[@]}"; do
    if [[ "$line" == *": OK" ]]; then
        echo -e "${GREEN}$line${NC}"
    elif [[ "$line" == *": FAIL" ]]; then
        echo -e "${RED}$line${NC}"
    else
        echo -e "${YELLOW}$line${NC}"
    fi
done
echo ""

if [[ $FAILED -eq 0 ]]; then
    echo -e "${GREEN}All validated modules passed.${NC}"
    exit 0
else
    echo -e "${RED}$FAILED module(s) reported errors. See output above for details.${NC}"
    exit 1
fi

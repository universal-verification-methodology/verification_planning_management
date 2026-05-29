# Shared --check / --demo / --scaffold handlers for module-to-slides-video.
# Source from scripts/moduleN.sh after MODULE_DIR and MODULE_NUM are set.

media_parse_arg() {
    case "$1" in
        --check)
            MEDIA_RUN_CHECK=true
            media_disable_summary_checks
            return 0
            ;;
        --demo)
            MEDIA_RUN_DEMO=true
            media_disable_summary_checks
            return 0
            ;;
        --scaffold)
            MEDIA_RUN_SCAFFOLD=true
            media_disable_summary_checks
            return 0
            ;;
    esac
    return 1
}

media_disable_summary_checks() {
    # Override in module script if it uses different variable names.
    RUN_PLAN_STATUS=false
    RUN_MATRIX_STATUS=false
    RUN_CHECKLIST_STATUS=false
    RUN_STRUCTURE_CHECK=false
    RUN_TRACEABILITY_CHECK=false
    RUN_TEST_PLAN_STATUS=false
    RUN_REGRESSION_PLAN_STATUS=false
    RUN_COVERAGE_PLAN_STATUS=false
    RUN_COVERAGE_DESIGN_STATUS=false
    RUN_COVERAGE_RUN_STATUS=false
    RUN_ENV_STATUS=false
    RUN_CHECKER_STATUS=false
    RUN_REGRESSION_OPS_STATUS=false
    RUN_DEBUG_FLAKE_STATUS=false
    RUN_ADVANCED_UVM_STATUS=false
    RUN_PROTOCOL_PLAN_STATUS=false
    RUN_MULTI_AGENT_STATUS=false
    RUN_INTEGRATION_STATUS=false
    RUN_VIP_STATUS=false
    RUN_PROJECTS_STATUS=false
    RUN_BEST_PRACTICES_STATUS=false
    RUN_CAPSTONE_STATUS=false
    RUN_CAPSTONE_PROJECT_STATUS=false
}

media_run_check() {
    local failed=0
    echo "Module ${MODULE_NUM}: media self-check"
    if [[ -d "$MODULE_DIR" ]]; then
        echo "  OK: module${MODULE_NUM}/ exists"
    else
        echo "  FAIL: module${MODULE_NUM}/ missing"
        failed=$((failed + 1))
    fi
    if [[ -d "$MODULE_DIR/templates" ]]; then
        echo "  OK: templates/ exists"
    else
        echo "  FAIL: templates/ missing"
        failed=$((failed + 1))
    fi
    if [[ -f "$MODULE_DIR/EXAMPLES.md" ]]; then
        echo "  OK: EXAMPLES.md exists"
    else
        echo "  FAIL: EXAMPLES.md missing"
        failed=$((failed + 1))
    fi
    if [[ -f "$PROJECT_ROOT/docs/MODULE${MODULE_NUM}.md" ]]; then
        echo "  OK: docs/MODULE${MODULE_NUM}.md exists"
    else
        echo "  FAIL: docs/MODULE${MODULE_NUM}.md missing"
        failed=$((failed + 1))
    fi
    if [[ -d "$PROJECT_ROOT/common_dut/rtl" ]]; then
        echo "  OK: common_dut/rtl/ exists"
    else
        echo "  WARN: common_dut/rtl/ not found (optional for planning-only modules)"
    fi
    echo ""
    if [[ $failed -eq 0 ]]; then
        echo "All required checks passed."
        return 0
    fi
    echo "$failed check(s) failed."
    return 1
}

media_run_demo() {
    echo "Module ${MODULE_NUM}: copy-paste demos (see module${MODULE_NUM}/EXAMPLES.md)"
    if [[ -f "$MODULE_DIR/EXAMPLES.md" ]]; then
        grep -E '^```bash$|^```$|^\./scripts/' "$MODULE_DIR/EXAMPLES.md" | head -20 || true
    fi
    echo ""
    echo "Run: ./scripts/module${MODULE_NUM}.sh   # full planning summary"
}

media_run_scaffold() {
    if [[ ! -d "$MODULE_DIR/templates" ]]; then
        echo "No templates/ directory in module${MODULE_NUM}"
        return 1
    fi
    local copied=0
    for src in "$MODULE_DIR/templates"/*.md; do
        [[ -f "$src" ]] || continue
        local base
        base="$(basename "$src")"
        local dest="$MODULE_DIR/$base"
        if [[ ! -f "$dest" ]]; then
            cp "$src" "$dest"
            echo "  Created $dest from templates/"
            copied=$((copied + 1))
        fi
    done
    if [[ $copied -eq 0 ]]; then
        echo "  Workspace files already present (nothing copied)."
    fi
    return 0
}

media_handle_early_exit() {
    if [[ "${MEDIA_RUN_CHECK:-false}" == true ]]; then
        media_run_check
        exit $?
    fi
    if [[ "${MEDIA_RUN_DEMO:-false}" == true ]]; then
        media_run_demo
        exit 0
    fi
    if [[ "${MEDIA_RUN_SCAFFOLD:-false}" == true ]]; then
        media_run_scaffold
        exit $?
    fi
}

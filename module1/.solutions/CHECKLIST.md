# Module 1 Checklist – Verification Planning & Management Foundations

> **Purpose**: Track completion of Module 1 planning tasks.

## 1. Admin and Setup

- [x] DUT chosen (FIFO / UART / AXI-lite / other).  
- [x] DUT spec collected and stored (or linked) for reference.  
- [x] `common_dut/rtl/` contains the DUT RTL (shared across all modules).  
- [x] `common_dut/tb/` exists with testbench structure (shared across all modules).  

## 2. Requirements and Scope

- [x] Requirements extracted from the spec and listed in `requirements_matrix.md`.  
- [x] Each requirement has a unique **Req ID** (e.g., R1, R2, …).  
- [x] In-scope vs out-of-scope items clearly documented in `verification_plan.md`.  
- [x] Assumptions/constraints about environment are written down.  
- [x] A simple **risk matrix** is completed in the plan.  

## 3. Verification Strategy (SV/UVM)

- [x] Overall verification **objectives** are listed.  
- [x] High-level **strategy** (directed vs random vs scenario-based) is described.  
- [x] Planned UVM **env/agent/sequence/scoreboard** structure is outlined.  
- [x] Usage of **assertions** and/or protocol checkers is described.  

## 4. Test Planning

- [x] Test **tiers** (smoke/feature/stress/error) are defined.  
- [x] An initial **test catalogue** (≥ 10 tests) is documented in the plan and/or matrix.  
  - ✅ **Complete**: 12 tests (T1-T12) documented in VERIFICATION_PLAN.md and REQUIREMENTS_MATRIX.md.
- [x] Each test has:
  - [x] ID, name, intent.  
  - [x] Related requirement IDs.  
  - [x] Type and priority.  

## 5. Coverage Planning

- [x] Key **functional coverage** items are identified (covergroups/coverpoints/crosses).  
- [x] Tentative **code coverage** goals are defined.  
- [x] Initial **coverage goals** and closure philosophy are documented.  
- [x] Requirements → coverage mapping exists in `requirements_matrix.md`.  

## 6. Regression and Sign-off (Preview)

- [x] A rough **regression tiering** concept is described (sanity, nightly, full, etc.).  
- [x] Draft **sign-off criteria** bullets are listed (coverage, bugs, stability, docs).  

## 7. Traceability

- [x] Requirements → tests mapping is populated.  
- [x] Requirements → coverage mapping is populated.  
- [x] Requirements → checkers/assertions mapping is started.  
- [x] High-priority requirements have at least one test, coverage item, and checker.  

## 8. Review

- [x] Plan reviewed with a peer/mentor or team (even informally).  
  - ✅ **Complete**: Self-review and informal peer review completed on 2026-02-03. Review findings documented in `VERIFICATION_PLAN.md` Section 8.1.
- [x] Open questions and risks are captured at the end of `verification_plan.md`.  
- [x] Action items from review are recorded.  
  - ✅ **Complete**: Action items documented in `VERIFICATION_PLAN.md` Section 8.2 with 7 items tracked for Module 2-5.

## 9. Ready to Move to Module 2

- [x] You can explain your **verification strategy** for this DUT in 3–5 minutes.  
  - ✅ **Complete**: Verification strategy summary documented in `HIGH_PRIORITY_REQUIREMENTS_TRACEABILITY.md` Section "Verification Strategy Summary (3-5 Minute Explanation)".
- [x] You can show a reviewer where each **high-priority** requirement is:  
  - [x] Tested.  
    - ✅ **Complete**: All high-priority requirements (R1, R2) mapped to tests. R1 has 11 tests (T1-T12), R2 has 4 tests (T2, T3, T7, T11). Documented in `HIGH_PRIORITY_REQUIREMENTS_TRACEABILITY.md`.
  - [x] Covered.  
    - ✅ **Complete**: All high-priority requirements mapped to coverage items. R1 → CG_LEVEL, CG_OPS; R2 → CG_FLAGS, CROSS_LEVEL_FLAGS. Documented in `HIGH_PRIORITY_REQUIREMENTS_TRACEABILITY.md`.
  - [x] Checked.  
    - ✅ **Complete**: All high-priority requirements mapped to checkers. R1 → SB_MAIN (scoreboard); R2 → A_OVERFLOW (SVA assertion). Documented in `HIGH_PRIORITY_REQUIREMENTS_TRACEABILITY.md`.
- [x] You are comfortable that Module 2 can begin focusing on **refining** and **implementing** the plan rather than redefining it.  
  - ✅ **Complete**: Plan is comprehensive with clear traceability. All requirements, tests, coverage, and checkers are defined. Module 2 can proceed with implementation as documented in action items (AI-1 through AI-4).  


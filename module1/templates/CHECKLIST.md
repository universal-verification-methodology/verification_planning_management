# Module 1 Checklist – Verification Planning & Management Foundations

> **Purpose**: Track completion of Module 1 planning tasks.

> **Instructions**: Check off items as you complete them. Copy from `module1/templates/` if needed, or edit the file in `module1/` directly. Reference: `module1/.solutions/`. For guidance see [docs/FILL_GUIDES.md](../../docs/FILL_GUIDES.md#module-1---checklist).

> **How to use**: Work through each section in order. When a task is done, change `- [ ]` to `- [x]`. Run `./scripts/module1.sh` to see how many items are still unchecked.

## 1. Admin and Setup

- [ ] DUT chosen (FIFO / UART / AXI-lite / other).
- [ ] DUT spec collected and stored (or linked) for reference.
- [ ] `common_dut/rtl/` contains the DUT RTL (shared across all modules).
- [ ] `common_dut/tb/` exists with testbench structure (shared across all modules).

## 2. Requirements and Scope

- [ ] Requirements extracted from the spec and listed in `requirements_matrix.md`.
- [ ] Each requirement has a unique **Req ID** (e.g., R1, R2, …).
- [ ] In-scope vs out-of-scope items clearly documented in `verification_plan.md`.
- [ ] Assumptions/constraints about environment are written down.
- [ ] A simple **risk matrix** is completed in the plan.

## 3. Verification Strategy (SV/UVM)

- [ ] Overall verification **objectives** are listed.
- [ ] High-level **strategy** (directed vs random vs scenario-based) is described.
- [ ] Planned UVM **env/agent/sequence/scoreboard** structure is outlined.
- [ ] Usage of **assertions** and/or protocol checkers is described.

## 4. Test Planning

- [ ] Test **tiers** (smoke/feature/stress/error) are defined.
- [ ] An initial **test catalogue** (≥ 10 tests) is documented in the plan and/or matrix.
- [ ] Each test has:
  - [ ] ID, name, intent.
  - [ ] Related requirement IDs.
  - [ ] Type and priority.

## 5. Coverage Planning

- [ ] Key **functional coverage** items are identified (covergroups/coverpoints/crosses).
- [ ] Tentative **code coverage** goals are defined.
- [ ] Initial **coverage goals** and closure philosophy are documented.
- [ ] Requirements → coverage mapping exists in `requirements_matrix.md`.

## 6. Regression and Sign-off (Preview)

- [ ] A rough **regression tiering** concept is described (sanity, nightly, full, etc.).
- [ ] Draft **sign-off criteria** bullets are listed (coverage, bugs, stability, docs).

## 7. Traceability

- [ ] Requirements → tests mapping exists in `requirements_matrix.md`.
- [ ] High-priority requirements have explicit mapping in `HIGH_PRIORITY_REQUIREMENTS_TRACEABILITY.md`.

## 8. Review

- [ ] Plan reviewed (self-review or peer review).
- [ ] Open questions and risks captured in `verification_plan.md`.

## 9. Ready to Move to Module 2

- [ ] Module 1 documents are filled enough to drive test planning in Module 2.

# Module 3 Checklist – Coverage Planning & Analysis in Practice

> **Purpose**: Track completion of Module 3 coverage tasks.

> **Instructions**: Check off items as you complete them. Copy from `module3/templates/` if needed, or edit the file in `module3/` directly. Reference: `module3/.solutions/`.

## 1. Pre-Reqs from Modules 1–2

- [ ] Module 1 verification plan and requirements matrix are reasonably filled.
- [ ] Module 2 test plan and regression plan exist and are at least partially populated.
- [ ] Initial coverage plan exists in `module2/COVERAGE_PLAN.md`.

## 2. Coverage Design

- [ ] `coverage_design.md` created and linked to Modules 1–2 plans.
- [ ] Key covergroups identified (e.g., operations, address, mode, error).
- [ ] For each covergroup:
  - [ ] Placement in UVM hierarchy decided (monitor/scoreboard/env/etc.).
  - [ ] Sampling events and strategy described.
  - [ ] Major coverpoints and crosses defined at a conceptual level.

## 3. Implementation in UVM Environment

- [ ] Covergroups implemented in SV/UVM (in `common_dut/tb/` or equivalent).
- [ ] Sampling integrated with real data paths (transactions, signals, events).
- [ ] No obvious performance issues (e.g., not sampling on every cycle unnecessarily).
- [ ] Coverage IDs and locations captured in `coverage_design.md`.

## 4. Code Coverage Setup

- [ ] Statement/branch coverage enabled in simulator build/run scripts.
- [ ] Any additional relevant coverage types (toggle, condition, FSM) considered/enabled.
- [ ] Known out-of-scope/unreachable regions noted for future exclusion.

## 5. Coverage Runs and Analysis

- [ ] At least one coverage-enabled regression run executed (e.g., CORE tier subset).
- [ ] `coverage_runs.md` updated with at least one **Run N** entry.
- [ ] Key functional and code coverage metrics recorded.
- [ ] At least **5** significant coverage gaps identified and described.
- [ ] Each gap has an initial classification (test/constraint/model/unreachable).

## 6. Closure Actions

- [ ] For at least **3** major gaps, concrete closure actions defined:
  - [ ] New/updated tests in `module2/test_plan.md`.
  - [ ] Constraint adjustments or new sequences described.
  - [ ] Coverage model changes (new/merged/ignored bins) described in `coverage_design.md`.
- [ ] Any proposed waivers documented with rationale (and linked to requirements).

## 7. Traceability and Sign-off Linkage

- [ ] `module1/requirements_matrix.md` updated with:
  - [ ] Coverage IDs for high-priority requirements.
  - [ ] Notes on coverage status (e.g., partial, closed, waived).
- [ ] Coverage implications for sign-off captured (e.g., which coverage targets are mandatory).

## 8. Review

- [ ] Coverage model and first analysis reviewed with peer/mentor or team.
- [ ] Feedback and follow-up actions captured in `coverage_design.md` or `coverage_runs.md`.

## 9. Ready to Move to Module 4

- [ ] Functional and code coverage are **measurable** and can be run in regressions.
- [ ] You can explain:
  - [ ] What your main covergroups measure.
  - [ ] How coverage is used to drive new tests and closure.
  - [ ] How coverage ties back to requirements and sign-off.
- [ ] You are ready to focus on **strengthening UVM components and checkers** in the next module.

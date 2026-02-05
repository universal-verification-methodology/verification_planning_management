# Module 3 Checklist – Coverage Planning & Analysis in Practice

> **Purpose**: Track completion of Module 3 coverage tasks.

## 1. Pre-Reqs from Modules 1–2

- [x] Module 1 verification plan and requirements matrix are reasonably filled.  
- [x] Module 2 test plan and regression plan exist and are at least partially populated.  
- [x] Initial coverage plan exists in `module2/COVERAGE_PLAN.md`.  

## 2. Coverage Design

- [x] `coverage_design.md` created and linked to Modules 1–2 plans.  
- [x] Key covergroups identified (e.g., operations, address, mode, error).  
- [x] For each covergroup:
  - [x] Placement in UVM hierarchy decided (monitor/scoreboard/env/etc.).  
  - [x] Sampling events and strategy described.  
  - [x] Major coverpoints and crosses defined at a conceptual level.  

## 3. Implementation in UVM Environment

- [x] Covergroups implemented in SV/UVM (in `common_dut/tb/` or equivalent).  
- [x] Sampling integrated with real data paths (transactions, signals, events).  
- [x] No obvious performance issues (e.g., not sampling on every cycle unnecessarily).  
- [x] Coverage IDs and locations captured in `coverage_design.md`.  

## 4. Code Coverage Setup

- [x] Statement/branch coverage enabled in simulator build/run scripts.  
- [x] Any additional relevant coverage types (toggle, condition, FSM) considered/enabled.  
- [x] Known out-of-scope/unreachable regions noted for future exclusion.  

## 5. Coverage Runs and Analysis

- [x] At least one coverage-enabled regression run executed (e.g., CORE tier subset).  
- [x] `coverage_runs.md` updated with at least one **Run N** entry.  
- [x] Key functional and code coverage metrics recorded.  
- [x] At least **5** significant coverage gaps identified and described.  
- [x] Each gap has an initial classification (test/constraint/model/unreachable).  

## 6. Closure Actions

- [x] For at least **3** major gaps, concrete closure actions defined:
  - [x] New/updated tests in `module2/test_plan.md`.  
  - [x] Constraint adjustments or new sequences described.  
  - [x] Coverage model changes (new/merged/ignored bins) described in `coverage_design.md`.  
- [x] Any proposed waivers documented with rationale (and linked to requirements).  

## 7. Traceability and Sign-off Linkage

- [x] `module1/requirements_matrix.md` updated with:
  - [x] Coverage IDs for high-priority requirements.  
  - [x] Notes on coverage status (e.g., partial, closed, waived).  
- [x] Coverage implications for sign-off captured (e.g., which coverage targets are mandatory).  

## 8. Review

- [x] Coverage model and first analysis reviewed with peer/mentor or team.  
- [x] Feedback and follow-up actions captured in `coverage_design.md` or `coverage_runs.md`.  

## 9. Ready to Move to Module 4

- [x] Functional and code coverage are **measurable** and can be run in regressions.  
- [x] You can explain:
  - [x] What your main covergroups measure.  
  - [x] How coverage is used to drive new tests and closure.  
  - [x] How coverage ties back to requirements and sign-off.  
- [x] You are ready to focus on **strengthening UVM components and checkers** in the next module.  


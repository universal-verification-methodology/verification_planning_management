# Module 2 Checklist – Test Planning & Strategy in Depth

> **Purpose**: Track completion of Module 2 tasks.

## 1. Pre-Reqs from Module 1

- [x] Module 1 verification plan reasonably filled (not just template).  
- [x] Requirements matrix has at least initial Req/Test/Coverage mappings.  
- [x] UVM env skeleton in `common_dut/tb/` is sketched (even if stubbed).  

## 2. Test Taxonomy and Tiers

- [x] Test **types** defined (smoke, feature, stress, error, etc.).  
- [x] Test **tiers** defined (sanity/core/stress/full or equivalent).  
- [x] Runtime **targets** per tier are documented.  

## 3. Test Catalogue

- [x] Test catalogue in `test_plan.md` created or imported from Module 1.  
- [x] Catalogue expanded to at least **25–40** test intents (as appropriate for project size).  
- [x] Each test has:
  - [x] Test ID and UVM test name.  
  - [x] Intent / description.  
  - [x] Type and tier.  
  - [x] Runtime class and determinism.  
  - [x] Related requirement IDs.  
- [x] Redundant/low-value tests identified and consolidated or removed.  

## 4. Negative and Stress Tests

- [x] At least **3** well-defined negative/error tests planned.  
- [x] At least **3** stress/long-run tests planned.  
- [x] Negative and stress tests have clear expected behavior and checks.  

## 5. Seed and Randomness Policy

- [x] Seed policy defined (which tests use fixed vs varying seeds).  
- [x] Mechanism for passing seeds documented (plusargs/env/config).  
- [x] Reproducibility expectations documented (how to capture and replay failing seeds).  

## 6. Regression Plan

- [x] `regression_plan.md` created and filled with tier definitions.  
- [x] Tests assigned to appropriate tiers.  
- [x] Runtime estimates per test added (at least rough).  
- [x] Aggregate tier runtimes computed and checked against targets.  
- [x] Initial pass/fail and flake policy documented.  

## 7. Coverage Plan Refinement

- [x] `coverage_plan.md` created and linked to Module 1 plan.  
- [x] Key covergroups, coverpoints, and crosses listed with locations.  
- [x] Coverage–test relationships sketched (which tests drive which coverage areas).  
- [x] Early coverage closure tactics described.  

## 8. Traceability and Consistency

- [x] Test catalogue, regression plan, and coverage plan are consistent with:  
  - [x] `module1/VERIFICATION_PLAN.md`  
  - [x] `module1/REQUIREMENTS_MATRIX.md`  
- [x] No high-priority requirement is left with **only one** weak test (where multiple are warranted).  

## 9. Review

- [x] Test and regression plan reviewed with peer/mentor or team.  
- [x] Identified issues and actions recorded in `test_plan.md` / `regression_plan.md`.  

## 10. Ready to Move to Module 3

- [x] You can explain your **test taxonomy and regression tiers** in 3–5 minutes.  
- [x] You can show, for several high-priority requirements, the **set** of tests (happy path + negative + stress) that support them.  
- [x] You are comfortable that the next module can focus on **coverage measurement and analysis** rather than basic test planning.

### 10.1 Readiness Confirmation

- **Test taxonomy and tiers**: Smoke / feature / stress / error / performance types; SANITY (per-commit), CORE (nightly), STRESS (weekly), FULL (ad-hoc) tiers — documented in test_plan.md §2 and regression_plan.md §2.
- **Requirements → tests**: For R1 (in-order transfer): SMK_001, FTR_001–FTR_013, STR_001–STR_013, PERF_001–PERF_003. For R2 (overflow): ERR_001, ERR_003, ERR_005, FTR_013, STR_008. For R3 (underflow): ERR_002, ERR_003, ERR_005, FTR_013, STR_009. See test_plan.md §4.1 and module1 REQUIREMENTS_MATRIX.md.
- **Module 3 focus**: Coverage plan (coverage_plan.md) and test catalogue are aligned; next module can focus on coverage measurement and analysis.  


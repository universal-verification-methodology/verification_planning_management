# Module 2 Checklist – Test Planning & Strategy in Depth

> **Purpose**: Track completion of Module 2 tasks.

> **Instructions**: Check off items as you complete them. Copy from `module2/templates/` if needed, or edit the file in `module2/` directly. Reference: `module2/.solutions/`.

## 1. Pre-Reqs from Module 1

- [ ] Module 1 verification plan reasonably filled (not just template).
- [ ] Requirements matrix has at least initial Req/Test/Coverage mappings.
- [ ] UVM env skeleton in `common_dut/tb/` is sketched (even if stubbed).

## 2. Test Taxonomy and Tiers

- [ ] Test **types** defined (smoke, feature, stress, error, etc.).
- [ ] Test **tiers** defined (sanity/core/stress/full or equivalent).
- [ ] Runtime **targets** per tier are documented.

## 3. Test Catalogue

- [ ] Test catalogue in `test_plan.md` created or imported from Module 1.
- [ ] Catalogue expanded to at least **25–40** test intents (as appropriate for project size).
- [ ] Each test has:
  - [ ] Test ID and UVM test name.
  - [ ] Intent / description.
  - [ ] Type and tier.
  - [ ] Runtime class and determinism.
  - [ ] Related requirement IDs.
- [ ] Redundant/low-value tests identified and consolidated or removed.

## 4. Negative and Stress Tests

- [ ] At least **3** well-defined negative/error tests planned.
- [ ] At least **3** stress/long-run tests planned.
- [ ] Negative and stress tests have clear expected behavior and checks.

## 5. Seed and Randomness Policy

- [ ] Seed policy defined (which tests use fixed vs varying seeds).
- [ ] Mechanism for passing seeds documented (plusargs/env/config).
- [ ] Reproducibility expectations documented (how to capture and replay failing seeds).

## 6. Regression Plan

- [ ] `regression_plan.md` created and filled with tier definitions.
- [ ] Tests assigned to appropriate tiers.
- [ ] Runtime estimates per test added (at least rough).
- [ ] Aggregate tier runtimes computed and checked against targets.
- [ ] Initial pass/fail and flake policy documented.

## 7. Coverage Plan Refinement

- [ ] `coverage_plan.md` created and linked to Module 1 plan.
- [ ] Key covergroups, coverpoints, and crosses listed with locations.
- [ ] Coverage–test relationships sketched (which tests drive which coverage areas).
- [ ] Early coverage closure tactics described.

## 8. Traceability and Consistency

- [ ] Test catalogue, regression plan, and coverage plan are consistent with:
  - [ ] `module1/VERIFICATION_PLAN.md`
  - [ ] `module1/REQUIREMENTS_MATRIX.md`
- [ ] No high-priority requirement is left with **only one** weak test (where multiple are warranted).

## 9. Review

- [ ] Test and regression plan reviewed with peer/mentor or team.
- [ ] Identified issues and actions recorded in `test_plan.md` / `regression_plan.md`.

## 10. Ready to Move to Module 3

- [ ] You can explain your **test taxonomy and regression tiers** in 3–5 minutes.
- [ ] You can show, for several high-priority requirements, the **set** of tests (happy path + negative + stress) that support them.
- [ ] You are comfortable that the next module can focus on **coverage measurement and analysis** rather than basic test planning.

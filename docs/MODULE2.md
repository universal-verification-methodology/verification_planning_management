# Module 2: Test Planning & Strategy in Depth (SV/UVM)

**Duration**: 1–2 weeks  
**Complexity**: Intermediate  
**Goal**: Turn your initial verification plan into a detailed, reviewable **test strategy**, with a structured test catalogue, negative/stress planning, and an initial regression tiering concept for your Verilog DUT and SV/UVM environment.

## Overview

Module 1 gave you a high-level verification plan, scope, and early test catalogue.  
In this module, you will:

- Refine and deepen the **test planning** for your chosen DUT.
- Design a **test taxonomy** (tiers, types, priorities) that maps cleanly into UVM tests/sequences.
- Plan **negative, stress, and corner-case** tests explicitly.
- Define initial **regression tiers** and how tests map into them.
- Begin planning for **test metadata** (seeds, configs, tags) to support automation later.

The emphasis is on making your plan **executable and scalable**: a clear mapping from requirements → test intents → UVM tests/sequences → regression suites.

### Examples and Code Structure (planned)

We continue using the same DUT and SV/UVM skeleton from Module 1.

```text
module2/
├── TEST_PLAN.md              # Detailed test planning and catalogue
├── REGRESSION_PLAN.md        # Initial regression tiering and policies
├── COVERAGE_PLAN.md          # More detailed coverage planning (optional refinement)
├── CHECKLIST.md      # Module 2 self-assessment checklist
└── README.md                 # Module 2 documentation

common_dut/
├── rtl/                      # DUT RTL (shared across all modules)
└── tb/                       # UVM testbench (shared across all modules)
```

> **Note**: `module2/` does **not** duplicate RTL or full testbench.  
> It assumes you are building on top of the DUT and UVM skeleton defined in `common_dut/`.

### Quick Start

> **Self-paced structure**: This module uses a three-folder structure:
> - **`module2/templates/`** — Empty templates to copy from
> - **`module2/.solutions/`** — Reference solutions (opt-in to view)
> - **`module2/*.md`** — Your workspace (edit these files)
> 
> See [`module2/README.md`](../module2/README.md) and [`METHODS.md`](METHODS.md) for details.

1. Re-open your `module1/VERIFICATION_PLAN.md` and `module1/REQUIREMENTS_MATRIX.md`.  
2. **Edit the workspace files** in `module2/`:
   - `module2/TEST_PLAN.md` – expand and sharpen the test catalogue.  
   - `module2/REGRESSION_PLAN.md` – define tiers, runtimes, gating rules.  
   - `module2/COVERAGE_PLAN.md` – refine coverage model and closure tactics.  
   Copy from `module2/templates/` if needed, or reference `module2/.solutions/` for examples.
3. Use `module2/CHECKLIST.md` as your progress tracker.  
4. **Validate your progress**: Run `./scripts/module2.sh` from the repository root.
5. Align your planned tests with concrete UVM artifacts in `common_dut/tb/`: tests, sequences, configuration knobs.

## Topics Covered

### 1. Test Taxonomy and Structure

- **Test Types**
  - Smoke/sanity vs feature vs stress vs error-injection vs performance (if applicable).
  - Directed vs constrained-random vs scenario-based tests.
- **Tiers and Frequency**
  - Per-commit / pre-push tests.
  - Nightly regression suites.
  - Weekly full or long-running suites.
- **Mapping to UVM**
  - How test types relate to UVM tests and sequences.
  - Using configuration objects / plusargs / factory overrides to specialize tests.

### 2. Test Catalogue Refinement

- **From List to Catalogue**
  - Expanding the initial 10–20 test intents into a more complete catalogue.
  - Grouping tests by feature, interface, or requirement group.
- **Naming and Metadata**
  - Test ID conventions (e.g., `SMK_`, `FTR_`, `STR_`, `ERR_` prefixes).
  - Metadata: owner, runtime class (short/medium/long), deterministic vs random, seed handling.
- **Redundancy and Value**
  - Identifying overlapping tests and merging where reasonable.
  - Distinguishing “coverage-driving” tests vs “regression guardrail” tests.

### 3. Negative, Stress, and Corner-Case Planning

- **Negative Testing**
  - Illegal sequences, protocol violations, out-of-range values.
  - Malformed packets/transactions, timing violations (where meaningful).
- **Stress and Long-Run Scenarios**
  - High-load / long-duration tests.
  - Pseudo-random traffic, back-to-back operations, resource exhaustion.
- **Corner Cases**
  - Boundary values, wrap-around conditions, reset-in-the-middle, mode transitions.
- **Instrumentation Needs**
  - What additional checks, monitors, or assertions are needed to support these tests.

### 4. Seeds, Constraints, and Reproducibility

- **Seed Strategy**
  - When to fix seeds vs vary them.
  - How to record seeds for debugging and reproducibility.
- **Constraints and Randomization Control**
  - High-level constraints in sequences vs constraint overrides per test.
  - Guarding against “over-constrained” tests that hide bugs.
- **Test Parameters and Configurations**
  - Using UVM configuration database, plusargs, or config files.
  - Planning for parametrization (e.g., data width, depth, mode).

### 5. Regression Tiering and Policies (Planning Level)

- **Regression Tiers**
  - Tier definitions (e.g., `sanity`, `core_feature`, `stress`, `full`).
  - Target runtimes and approximate test counts for each tier.
- **Test Assignment**
  - Mapping each test in the catalogue to one or more tiers.
  - Deciding which negative/stress tests are safe for frequent runs.
- **Pass/Fail Policies (Preview)**
  - What counts as a pass, fail, flake.
  - Basic quarantine strategy for flaky tests (details in later modules).

### 6. Coordination with Coverage and Requirements

- **Closing Loops with Requirements**
  - Ensuring each high-priority requirement has **enough** tests (not just one).
  - Verifying that tests exercise planned coverage points.
- **Coverage-Driven Test Gaps**
  - Identifying missing tests from coverage perspective (e.g., unhit bins).
  - Planning targeted tests to close meaningful coverage holes.

## Learning Outcomes

By the end of this module, you should be able to:

- Design a **structured test taxonomy** tailored to your DUT and UVM environment.
- Maintain a **rich test catalogue** with clear metadata and priorities.
- Plan explicit **negative, stress, and corner-case** tests.
- Define initial **regression tiers** and assign tests to them.
- Explain how your test plan supports **requirements coverage** and coverage closure.

## Test Cases (Planning Exercises)

### Test Case 2.1: Test Taxonomy Definition

**Objective**: Define clear test categories and tiers.

**Tasks**:
- In `module2/TEST_PLAN.md`, define:
  - Test types with definitions and examples.
  - Tiers (sanity, core, stress, full) with expected runtime budgets.
- For at least **10** existing tests from Module 1, assign:
  - Type, tier, and expected runtime.

### Test Case 2.2: Catalogue Expansion and Cleanup

**Objective**: Expand and de-duplicate the test catalogue.

**Tasks**:
- Grow your catalogue to **25–40** tests (intents), focusing on:
  - Feature coverage.
  - Interface/protocol scenarios.
  - Mode and configuration combinations.
- Identify at least **3** redundant or low-value tests and:
  - Merge or remove them, documenting the decision.

### Test Case 2.3: Negative and Stress Test Design

**Objective**: Design negative and stress tests with clear intention.

**Tasks**:
- Add at least:
  - 3 negative tests (illegal, malformed, or out-of-range behavior).
  - 3 stress or long-run tests.
- For each, define:
  - Preconditions and exact stimuli.
  - Expected behavior (including assertions/flags).
  - Special logging or debug support needed.

### Test Case 2.4: Seed and Reproducibility Policy

**Objective**: Define how you will manage randomness.

**Tasks**:
- Decide:
  - Which tests will run with fixed vs varying seeds.
  - How seeds will be passed (e.g., plusargs, config).
- Document this in `module2/TEST_PLAN.md` and update `module1/REQUIREMENTS_MATRIX.md` if needed.

### Test Case 2.5: Regression Tier Mapping

**Objective**: Create an initial regression plan.

**Tasks**:
- In `module2/REGRESSION_PLAN.md`, define:
  - Tier names, cadence (per-commit, nightly, weekly), and runtime targets.
  - Inclusion criteria for tests in each tier.
- For each test in your catalogue, add a column indicating:
  - Primary tier(s) it belongs to.

## Exercises

1. **Runtime Budgeting**
   - Estimate runtimes for each test (rough order of magnitude).
   - Ensure each tier fits within an acceptable wall-clock time.
2. **Flake-Resistance Design**
   - Identify tests at risk of flakiness (randomness, timing edges, timeouts).
   - Update test designs to reduce non-determinism where possible.
3. **Traceability Check**
   - For a sample of 5–10 high-priority requirements:
     - Verify they have multiple tests where appropriate (happy path + negative + stress).

## Assessment

- [ ] Has a written **test taxonomy** and tier definition.  
- [ ] Test catalogue expanded and de-duplicated with clear metadata.  
- [ ] Negative, stress, and corner-case tests are explicitly planned.  
- [ ] Seed and randomness policy is documented.  
- [ ] A draft **regression plan** exists with test-to-tier mapping.  
- [ ] Requirements and coverage implications are reflected in the updated plan/matrix.  

## Next Steps

After completing this module, proceed to **Module 3: Coverage Planning & Analysis in Practice**, where you will connect the test plan more tightly with functional/code coverage, start measuring coverage on real runs, and perform gap analysis.

## Additional Resources

- Internal or industry **verification test planning** examples or checklists.  
- Articles or talks on **regression strategy** and **flake management** in DV.  
- UVM guidelines for **test/sequences layering** and configurability.


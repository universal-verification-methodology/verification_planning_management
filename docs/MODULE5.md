# Module 5: Regression Management & Advanced UVM Orchestration (SV/UVM)

**Duration**: 2–3 weeks  
**Complexity**: Advanced  
**Goal**: Turn your test, coverage, and environment designs into a **robust regression system** that scales: advanced sequence orchestration (including virtual sequences), flake management, CI integration, performance tuning, and coverage-driven refinement.

## Overview

Modules 1–4 established **what to test**, **how to measure**, and **how to build a solid UVM environment**.  
In Module 5, you focus on **running that environment at scale**:

- Designing and documenting **regression flows** (local, CI, farm).  
- Introducing **advanced UVM orchestration** (virtual sequences, multi-agent coordination).  
- Handling **flaky tests**, timeouts, and debugability.  
- Using coverage and bug data to **prioritize and refine** regression content.

The emphasis is on **operational excellence**: reliable, repeatable regressions that provide actionable feedback to the team.

### Examples and Code Structure (planned)

We continue to reuse the DUT, environment, and coverage infrastructure from earlier modules.

```text
module5/
├── REGRESSION_OPS.md            # Concrete regression flows & CI integration
├── ADVANCED_UVM_PLAN.md         # Virtual sequences, advanced configuration, callbacks
├── DEBUG_FLAKE_PLAN.md          # Flakiness, timeouts, debug and performance strategy
├── CHECKLIST.md         # Module 5 self-assessment checklist
└── README.md                    # Module 5 documentation

common_dut/
├── rtl/                         # DUT RTL (shared across all modules)
└── tb/                          # UVM testbench (shared across all modules)
```

> **Note**: The **actual code** for advanced sequences, virtual sequencers, callbacks, and register model usage lives in your SV/UVM testbench (e.g., `common_dut/tb/…`).  
> `module5/` captures how these features are used to support regression and management.

### Quick Start

> **Self-paced structure**: This module uses a three-folder structure:
> - **`module5/templates/`** — Empty templates to copy from
> - **`module5/.solutions/`** — Reference solutions (opt-in to view)
> - **`module5/*.md`** — Your workspace (edit these files)
> 
> See [`module5/README.md`](../module5/README.md) and [`METHODS.md`](METHODS.md) for details.

1. Re-open:
   - `module2/REGRESSION_PLAN.md` (tiers, runtimes, policies).  
   - `module3/COVERAGE_RUN.md` (coverage + gap analysis).  
   - `module4/ENV_DESIGN.md` and `module4/CHECKER_PLAN.md`.  
2. **Edit the workspace files** in `module5/`:
   - `module5/REGRESSION_OPS.md` – define concrete regression commands, CI jobs, and flows.  
   - `module5/ADVANCED_UVM_PLAN.md` – plan how virtual sequences, callbacks, and config patterns support regressions.  
   - `module5/DEBUG_FLAKE_PLAN.md` – plan for flake detection, triage, and debugging.  
   Copy from `module5/templates/` if needed, or reference `module5/.solutions/` for examples.
3. **Validate your progress**: Run `./scripts/module5.sh` from the repository root.
4. Implement the necessary UVM features and regression scripts in your codebase (`common_dut/tb/`).  
5. Use `module5/CHECKLIST.md` to track progress.

## Topics Covered

### 1. Concrete Regression Flows

- **Local vs CI vs Farm**
  - Developer “inner loop” (fast, focused subsets).  
  - CI per-commit/per-PR runs (sanity + selected CORE tests).  
  - Nightly/weekly farm runs (CORE/STRESS/FULL tiers).  
- **Command-Line Interfaces**
  - Standardizing make/pytest/regression wrapper interfaces.  
  - Passing seeds, tiers, and configuration via plusargs/env/CLI options.  
- **Job Definitions**
  - Defining named regression jobs (e.g., `sanity`, `core_nightly`, `stress_weekly`).  
  - Mapping jobs to tiers, test lists, and resource limits.

### 2. Advanced UVM Orchestration (Virtual Sequences & Multi-Agent)

- **Virtual Sequencers & Virtual Sequences**
  - Coordinating multiple agents (e.g., data + control + sideband).  
  - Layered sequences that correspond to system-level scenarios.  
- **Mapping to Test Plan**
  - Mapping high-level test intents to virtual sequences.  
  - Using virtual sequences to implement complex scenarios (reset-in-flight, multi-channel flows).  
- **Configuration & Callbacks**
  - Using complex configuration objects to parameterize regressions.  
  - Using callbacks to inject debug behavior or temporary instrumentation.

### 3. Flake Management and Stability

- **Flaky Test Identification**
  - Signals of flakiness (non-deterministic failures, timeouts).  
  - Logging and metadata needed to diagnose flakiness (test ID, seed, environment).  
- **Policies**
  - Criteria for marking a test as flaky.  
  - Temporary quarantine vs immediate fix.  
  - Automatic rerun strategies (e.g., N-of-M reruns to confirm flakiness).  
- **Designing Flake-Resistant Tests**
  - Avoiding hidden dependencies on timing or environment.  
  - Ensuring proper resets and deterministic seeding.

### 4. Debug & Observability Strategy

- **Logging**
  - Standardized log formats (prefixes, IDs, levels).  
  - Per-test log collection and retention policies.  
- **Waveforms and Traces**
  - When to dump waves (always for failures, selectively for passes).  
  - How to configure trace windows (e.g., last N microseconds before failure).  
- **Failure Triage Workflow**
  - Quick checks (assertion vs scoreboard vs timeout).  
  - Reproduction steps (same test, same seed, smaller subset).  

### 5. Performance and Scalability

- **Bottleneck Identification**
  - Longest-running tests and why.  
  - Hot spots in sequences, drivers, or reference models.  
- **Optimization Strategies**
  - Reducing redundant work (e.g., fewer warm-up cycles, targeted stress).  
  - Using configuration to scale test depth per tier.  
- **Regression Capacity Planning**
  - Estimating how many tests can run per hour/day.  
  - Planning parallelism and job sharding.

### 6. Coverage-Driven Regression Refinement

- **Using Coverage to Shape Regressions**
  - Prioritizing tests that contribute most to coverage gaps.  
  - Designing “closure suites” for specific coverage areas.  
- **Bug-Driven Refinement**
  - Using bug history to prioritize tests and sequences.  
  - Ensuring that fixed bugs get regression tests and coverage.

## Learning Outcomes

By the end of this module, you should be able to:

- Define and run **repeatable regression flows** across local and CI/farm environments.  
- Use **virtual sequences and advanced UVM patterns** to orchestrate complex scenarios.  
- Detect, triage, and manage **flaky tests** and instability in regressions.  
- Implement a practical **debug and observability strategy** (logs, waves, metadata).  
- Use coverage and bug data to prioritize and refine regression content.

## Test Cases (Planning & Ops Exercises)

### Test Case 5.1: Regression Job Definitions

**Objective**: Define concrete regression jobs based on your tiers.

**Tasks**:
- In `module5/REGRESSION_OPS.md`, define at least:
  - A `sanity` job (fast, per-commit).  
  - A `core_nightly` job.  
  - A `stress_weekly` or `full_release` job.  
- For each job, specify:
  - Tier(s), test selection rules, expected runtime, and invocation commands.

### Test Case 5.2: Virtual Sequence Plan

**Objective**: Plan how virtual sequences will implement complex intents.

**Tasks**:
- In `module5/ADVANCED_UVM_PLAN.md`, map several high-level tests to:
  - Specific virtual sequences and their participating agents/sequencers.  
  - Key configuration parameters (modes, seeds, error-injection toggles).  
- Identify at least **3** scenarios that require multi-agent coordination.

### Test Case 5.3: Flake Policy and Workflow

**Objective**: Define a process for handling flaky tests.

**Tasks**:
- In `module5/DEBUG_FLAKE_PLAN.md`, define:
  - What constitutes a flake in your context.  
  - How many reruns you perform to confirm flakiness.  
  - How you quarantine and track flaky tests.  
  - How/when they must be fixed before sign-off.

### Test Case 5.4: Debug & Observability Checklist

**Objective**: Ensure regressions are debuggable.

**Tasks**:
- Define:
  - Standard log naming and locations.  
  - When and how to generate waveforms.  
  - Minimum metadata required in failure reports (test ID, seed, tier, DUT hash).  
- Verify on at least one failing test that you can reproduce and debug using these artifacts.

## Exercises

1. **Runtime Tuning**
   - Take one long-running test and propose 2–3 ways to reduce runtime without losing verification value.  
2. **Coverage-Driven Job**
   - Design a special job that runs only tests contributing to under-covered areas identified in `COVERAGE_RUN.md`.  
3. **Resilience Drill**
   - Simulate a flaky test scenario and walk through your rerun/quarantine/debug process to validate your plan.

## Assessment

- [ ] Concrete regression jobs and commands captured in `module5/REGRESSION_OPS.md`.  
- [ ] Virtual sequence and advanced UVM usage planned in `module5/ADVANCED_UVM_PLAN.md`.  
- [ ] Flake and debug strategy documented in `module5/DEBUG_FLAKE_PLAN.md`.  
- [ ] Regression flows demonstrably support coverage and sign-off goals.  


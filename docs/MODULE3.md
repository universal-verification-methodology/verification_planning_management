# Module 3: Coverage Planning & Analysis in Practice (SV/UVM)

**Duration**: 2 weeks  
**Complexity**: Intermediate–Advanced  
**Goal**: Design and implement a practical **coverage model** (functional + code), connect it to your UVM environment and test plan, and perform first real **coverage analysis and gap-closing** cycles on your Verilog DUT.

## Overview

Modules 1–2 focused on **what to test** and **how to structure tests and regressions**.  
Module 3 turns coverage from a conceptual plan into a **measured, actionable signal**:

- Implement and integrate **functional coverage** (covergroups, coverpoints, crosses) in your UVM environment.
- Configure and run **code coverage** in your simulator flow.
- Collect coverage from real regressions (even small ones).
- Perform a structured **coverage gap analysis** and plan closure actions.

The emphasis is on **closing the loop**: requirements → tests → coverage → measured results → updated plan.

### Examples and Code Structure (planned)

We continue to reuse the DUT and UVM environment from Modules 1–2.

```text
module3/
├── COVERAGE_DESIGN.md            # Detailed functional coverage model design
├── COVERAGE_RUN.md             # Notes/templates for coverage runs & reports
├── CHECKLIST.md         # Module 3 self-assessment checklist
└── README.md                    # Module 3 documentation

common_dut/
├── rtl/                         # DUT RTL (shared across all modules)
└── tb/                          # UVM testbench (shared across all modules)
```

> **Note**: Implementation of covergroups and code-coverage hooks happens in your **SV/UVM files under `common_dut/tb/` and your simulation scripts**, not in this folder.  
> `module3/` is where you **design and track** the coverage work.

### Quick Start

> **Self-paced structure**: This module uses a three-folder structure:
> - **`module3/templates/`** — Empty templates to copy from
> - **`module3/.solutions/`** — Reference solutions (opt-in to view)
> - **`module3/*.md`** — Your workspace (edit these files)
> 
> See [`module3/README.md`](../module3/README.md) and [`../METHODS.md`](../METHODS.md) for details.

1. Re-open `module1/VERIFICATION_PLAN.md` and `module2/COVERAGE_PLAN.md`.  
2. **Edit the workspace files** in `module3/`:
   - `module3/COVERAGE_DESIGN.md` – concrete covergroup/coverpoint/cross design.  
   - `module3/COVERAGE_RUN.md` – a log of coverage runs and analyses.  
   Copy from `module3/templates/` if needed, or reference `module3/.solutions/` for examples.
3. Implement the designed covergroups and code-coverage settings in your UVM environment (`common_dut/tb/`).  
4. **Validate your progress**: Run `./scripts/module3.sh` from the repository root.
5. Run a small **CORE-tier regression** and capture coverage reports.  
6. Perform an initial **gap analysis** and record closure actions.

## Topics Covered

### 1. From Coverage Plan to Concrete Model

- **Refinement of Coverage Goals**
  - Translating high-level goals into specific covergroups and bins.
  - Deciding which metrics are *must-hit* vs *nice-to-have*.
- **Coverage Model Structure**
  - Organizing covergroups by feature, interface, or component.
  - Choosing the right placement (agent monitor, scoreboard, reference model, etc.).

### 2. Functional Coverage Implementation (SV/UVM)

- **Covergroup Basics**
  - `covergroup` declaration, sampling events (`@`), and options.
  - Coverpoints: bins, ranges, wildcards, ignore/illegal bins.
  - Cross coverage: when and how to cross (and when not to).
- **Sampling Strategy**
  - Sampling on transactions vs clocks vs protocol events.
  - Avoiding oversampling/undersampling.
- **Integration with UVM Components**
  - Embedding covergroups in monitors/scoreboards.
  - Using analysis ports/exports for coverage sampling.

### 3. Code Coverage Setup and Interpretation

- **Enabling Code Coverage**
  - Turning on statement/branch/toggle coverage in your simulator.
  - Handling compile-time options and run-time switches.
- **Interpreting Results**
  - Reading coverage reports and understanding common metrics.
  - Distinguishing real gaps from unreachable or out-of-scope code.
- **Managing Exclusions**
  - Identifying truly unreachable code.
  - Documenting exclusions and waivers with rationale.

### 4. Running Coverage-Enabled Regressions

- **Pilot Regressions**
  - Start with a modest CORE-tier run (not full regression).
  - Ensure coverage data collection is working end-to-end.
- **Merging Coverage**
  - Combining coverage from multiple tests/regressions.
  - Understanding how your tool merges coverage across runs and seeds.
- **Automating Coverage Collection**
  - Hooks in your regression/CI scripts to generate coverage databases/reports.

### 5. Coverage Analysis and Gap Closure

- **Gap Identification**
  - Finding unhit or low-hit coverpoints and crosses.
  - Detecting missing or ineffective coverage (bins that never can be hit).
- **Root-Cause Analysis**
  - Is the gap due to:
    - Missing or mis-specified tests?
    - Overly tight constraints?
    - Incomplete coverage model?
    - Truly unreachable or out-of-scope functionality?
- **Closure Actions**
  - Adding or modifying tests (directed or constrained-random).
  - Adjusting constraints or sequences.
  - Refining or pruning coverage points.
  - Documenting waivers where appropriate.

### 6. Connecting Coverage to Requirements and Sign-off

- **Traceability**
  - Ensuring high-priority requirements are covered by both tests and coverage.
  - Updating `REQUIREMENTS_MATRIX.md` with coverage IDs and status.
- **Interpreting Coverage for Sign-off**
  - Understanding when “100% coverage” is meaningful (and when it isn’t).
  - Combining coverage with bug metrics and expert judgment.
- **Preparing for Later Modules**
  - How coverage insights will influence later regression and sign-off modules.

## Learning Outcomes

By the end of this module, you should be able to:

- Design and implement a **concrete functional coverage model** for your DUT.  
- Enable and collect **code coverage** from your simulator.  
- Run coverage-enabled regressions and **interpret coverage reports**.  
- Perform a structured **coverage gap analysis** and plan closure actions.  
- Tie coverage results back to **requirements and sign-off criteria**.

## Test Cases (Coverage Exercises)

### Test Case 3.1: Implement Initial Covergroups

**Objective**: Implement and integrate the first set of covergroups.

**Tasks**:
- Choose 2–4 key features or interfaces.  
- For each, implement:
  - At least one covergroup with meaningful coverpoints.  
  - At least one useful cross (if warranted).  
- Integrate sampling into your UVM monitor/scoreboard.  
- Verify that bins are being hit in basic tests (e.g., SANITY/CORE tests).

### Test Case 3.2: Enable and Run Code Coverage

**Objective**: Turn on and validate code coverage.

**Tasks**:
- Enable statement/branch coverage in your simulator build/run scripts.  
- Run a small set of tests (e.g., SANITY or a subset of CORE).  
- Generate and inspect the coverage report.  
- Identify:
  - Any obvious coverage gaps in well-understood code.  
  - Any code that appears to be unreachable or out-of-scope.

### Test Case 3.3: Coverage Run Log

**Objective**: Start a repeatable coverage analysis workflow.

**Tasks**:
- In `module3/COVERAGE_RUN.md`, record at least one coverage run:  
  - Date, DUT version, test set/tier, seed policy, simulator version.  
  - Key coverage metrics (summary) and major observations.  
- List at least **5** concrete coverage gaps and your initial hypotheses.

### Test Case 3.4: Targeted Closure Actions

**Objective**: Design closure actions for specific gaps.

**Tasks**:
- For at least **3** significant gaps:
  - Decide whether to: **add tests**, **tune constraints**, **refine coverage**, or **waive**.  
  - Document the chosen action and expected impact.  
- Update:
  - `module2/TEST_PLAN.md` (new/updated tests).  
  - `module2/COVERAGE_PLAN.md` / `module3/COVERAGE_DESIGN.md`.  
  - `module1/REQUIREMENTS_MATRIX.md` (coverage mappings, waivers).

## Exercises

1. **Over-Coverage vs Under-Coverage**
   - Identify any coverpoints or crosses that are too fine-grained or produce noisy metrics.  
   - Simplify them while preserving verification value.  
2. **Coverage vs Bug History (if available)**
   - If you have bug data, check whether past bugs correspond to low coverage areas.  
   - Use this to refine your coverage priorities.  
3. **Tooling Experiment**
   - Try different coverage report formats (text, HTML, GUI).  
   - Decide which views are most useful for your team.

## Assessment

- [ ] Functional coverage model implemented for key features/interfaces.  
- [ ] Code coverage successfully enabled and reports generated.  
- [ ] At least one **coverage run** documented in `COVERAGE_RUN.md`.  
- [ ] Coverage gaps identified and categorized (test/constraint/model/waiver).  
- [ ] Closure actions planned and reflected in test/coverage/requirements docs.  

## Next Steps

After completing this module, proceed to **Module 4: UVM Environment and Checker Maturity**, where you will deepen your UVM component implementations (agents, monitors, scoreboards, protocol checkers) and ensure your environment can support robust checking and long-term regressions.

## Additional Resources

- Simulator documentation for **functional and code coverage** (VCS/Questa/Xcelium/Verilator).  
- UVM/coverage methodology guides and conference papers (DVCon, SNUG, etc.).  
- Internal examples of good coverage reports and closure write-ups (if available).


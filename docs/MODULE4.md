# Module 4: UVM Environment & Checker Maturity (SV/UVM)

**Duration**: 2–3 weeks  
**Complexity**: Intermediate–Advanced  
**Goal**: Design and mature your **UVM environment** (env, agents, drivers, monitors, sequencers) and **checking strategy** (scoreboards, reference models, protocol/functional assertions) so that your test and coverage plans from earlier modules can be executed reliably at scale.

## Overview

Modules 1–3 focused on planning (scope, tests, regressions) and measurement (coverage).  
In Module 4, you focus on the **quality and structure of the verification environment itself**:

- Designing and documenting your **UVM env/agent architecture** for the chosen DUT.  
- Defining and refining **driver, monitor, sequencer, and transaction models**.  
- Building or integrating **scoreboards and reference models**.  
- Designing and placing **protocol and functional assertions**.  

The emphasis is on making your environment **robust, maintainable, and check-rich**, rather than just “able to toggle signals.”

### Examples and Code Structure (planned)

We continue to reuse the DUT and basic UVM skeleton from Module 1, but now focus on the detailed environment and checking design.

```text
module4/
├── ENV_DESIGN.md              # Detailed UVM environment & agent design
├── CHECKER_PLAN.md            # Functional checking, scoreboards, assertions
├── CHECKLIST.md       # Module 4 self-assessment checklist
└── README.md                  # Module 4 documentation

common_dut/
├── rtl/                       # DUT RTL (shared across all modules)
└── tb/                        # UVM testbench (shared across all modules)
```

> **Note**: All actual SV/UVM code lives under `common_dut/tb/` (and any shared TB directories).  
> `module4/` is where you **design and review** the environment & checker strategy.

### Quick Start

> **Self-paced structure**: This module uses a three-folder structure:
> - **`module4/templates/`** — Empty templates to copy from
> - **`module4/.solutions/`** — Reference solutions (opt-in to view)
> - **`module4/*.md`** — Your workspace (edit these files)
> 
> See [`module4/README.md`](../module4/README.md) and [`METHODS.md`](METHODS.md) for details.

1. Re-open:
   - `module1/VERIFICATION_PLAN.md` (env sketch, requirements).  
   - `module2/TEST_PLAN.md` (test catalogue).  
   - `module2/COVERAGE_PLAN.md` and `module3/COVERAGE_DESIGN.md`.  
2. **Edit the workspace files** in `module4/`:
   - `module4/ENV_DESIGN.md` – define your UVM env/agent/transaction architecture.  
   - `module4/CHECKER_PLAN.md` – define scoreboards, reference models, and assertion strategy.  
   Copy from `module4/templates/` if needed, or reference `module4/.solutions/` for examples.
3. **Validate your progress**: Run `./scripts/module4.sh` from the repository root.
4. Implement or refine the corresponding SV/UVM components in `common_dut/tb/`.  
5. Use `module4/CHECKLIST.md` to track progress and review readiness.

## Topics Covered

- Environment and agent architecture (env vs agents vs tests).  
- Transaction and sequence design aligned with your test plan.  
- Driver and monitor behavior, including resets, backpressure, and error handling.  
- Scoreboard and reference model design.  
- Assertion strategy: what to check with SVA vs scoreboards vs tests.  
- Environment configuration and reuse across tiers and DUT variants.

## Learning Outcomes

By the end of this module, you should be able to:

- Describe and justify your **UVM environment and agent architecture**.  
- Implement and maintain **drivers, monitors, sequencers, and transactions** that match your DUT and test plan.  
- Implement or integrate **scoreboards and reference models** for robust checking.  
- Design and place **protocol and functional assertions** that support your verification goals.  
- Configure your environment for different **modes and regression tiers**.

## Assessment

- [ ] UVM env/agent architecture documented in `module4/ENV_DESIGN.md`.  
- [ ] Transaction and sequence designs documented and aligned with `module2/TEST_PLAN.md`.  
- [ ] Scoreboards and reference models specified in `module4/CHECKER_PLAN.md`.  
- [ ] Key protocol/functional assertions listed and placed.  
- [ ] At least one env/checker review (self or peer) completed; action items captured.  


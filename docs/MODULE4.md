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

## Before You Start

1. Re-read `module2/TEST_PLAN.md` and `module3/COVERAGE_DESIGN.md`.
2. Scaffold Module 4 workspace: `./scripts/module4.sh --scaffold`
3. Complete `module4/ENV_DESIGN.md` (agents, transactions, connectivity).
4. Complete `module4/CHECKER_PLAN.md` (scoreboard, reference model, SVA split).
5. Implement or refine UVM components in `module4/tb/` and `common_dut/tb/`.
6. Validate: `./scripts/module4.sh --check`

## Key files to study

- `module4/ENV_DESIGN.md` — env, agent, driver, monitor, sequencer design
- `module4/CHECKER_PLAN.md` — scoreboard, reference model, and assertion strategy
- `module4/tb/stream_pkg.sv` — reference UVM package (env, agents, scoreboard)
- `module4/tb/tb_stream_fifo_uvm.sv` — top-level UVM testbench and DUT hookup
- `common_dut/rtl/stream_fifo.sv` — DUT under verification
- `scripts/module4.sh` — env/checker doc and TB file checks

## Command Reference

### Scaffold and validate Module 4

```bash
./scripts/module4.sh --scaffold
./scripts/module4.sh --check
./scripts/module4.sh --summary
```

### Inspect UVM env and scoreboard

```bash
head -80 module4/tb/stream_pkg.sv
grep -n "class stream_env" module4/tb/stream_pkg.sv
grep -n scoreboard module4/tb/stream_pkg.sv
```

## Design Architecture

### 1. Mature UVM environment (stream_fifo)

- **Env** (`stream_fifo_env`): connects source/sink agents, scoreboard, coverage subscribers.
- **Agents**: driver + sequencer + monitor per interface; active vs passive roles documented in `ENV_DESIGN.md`.
- **Transactions**: item fields mirror DUT handshake semantics (data, valid/ready timing).
- Reference implementation sketch: `module4/tb/tb_stream_fifo_uvm.sv` and `stream_pkg.sv` patterns.

### 2. Checking architecture

- **Scoreboard / reference model** — golden data path and ordering checks (`CHECKER_PLAN.md`).
- **SVA** — protocol and functional assertions on interfaces and internal flags.
- Clear split: what is checked in **SVA** vs **scoreboard** vs **test self-check**.

### 3. UVM phase execution flow

- **build_phase**: create env, agents, scoreboard, coverage subscribers via factory.
- **connect_phase**: connect monitor analysis ports to scoreboard and coverage; tie virtual interfaces.
- **run_phase**: raise objection, start sequences on sequencers, wait for drain, drop objection.
- **report_phase**: summarize errors, assertion failures, and coverage sampling status.
- Top module `module4/tb/tb_stream_fifo_uvm.sv` instantiates DUT and calls `run_test()`.

## Verification & Testing Methods

### 1. Stimulus and checking flow

- Sequences → driver → DUT → monitor → scoreboard compare and assertion sampling.
- Reset, backpressure, and error-injection scenarios exercised per `TEST_PLAN.md`.

### 2. Assertion-based verification (ABV)

- Place assertions close to interfaces; use `assert`/`assume` policy consistent with your simulator flow.
- Document waiver and severity policy for known benign cases.

### 3. Environment review

- Peer/self review of `ENV_DESIGN.md` and `CHECKER_PLAN.md` before expanding regression scope.
- `./scripts/module4.sh --check` validates design docs and TB file presence.

## Topics Covered

### 1. Environment and Agent Architecture

- Environment and agent architecture (env vs agents vs tests).  
- Layered testbench structure and reuse across tiers and DUT variants.

### 2. Transactions and Sequences

- Transaction and sequence design aligned with your test plan.  
- Mapping test intents to UVM sequences and configuration.

### 3. Drivers and Monitors

- Driver and monitor behavior, including resets, backpressure, and error handling.

### 4. Scoreboards and Reference Models

- Scoreboard and reference model design.

### 5. Assertions and Checking Strategy

- Assertion strategy: what to check with SVA vs scoreboards vs tests.

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


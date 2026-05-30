# Module 1: Verification Planning & Management Foundations (SV/UVM)

**Duration**: 1–2 weeks  
**Complexity**: Beginner–Intermediate  
**Goal**: Learn how to turn a DUT specification into a concrete verification plan, with clear strategy, coverage intent, and regression approach, using Verilog DUTs and SystemVerilog/UVM testbenches.

## Overview

This module establishes the foundation for **verification planning and management**.  
Instead of starting from coding UVM components, you will start from the **specification and DUT** and learn how to:

- Capture **verification objectives**.
- Define a **verification strategy** for SystemVerilog/UVM.
- Sketch **coverage planning** (what to measure and why).
- Outline **regression strategy** and basic sign-off thinking.

The emphasis is on **thinking and planning** (what and why) while staying grounded in a realistic Verilog DUT and SV/UVM testbench context.

### Examples and Code Structure (planned)

This course assumes a small but realistic DUT (e.g., AXI-lite register block, FIFO, or UART) and a UVM-style testbench.  
Over the full 8-module course, we recommend the following directory structure:

```text
module1/
├── VERIFICATION_PLAN.md        # Draft verification plan for the chosen DUT
├── REQUIREMENTS_MATRIX.md      # Req ↔ test/coverage traceability (initial)
├── CHECKLIST.md       # Module 1 self-assessment checklist
└── README.md                   # Module 1 documentation (points to this file)

common_dut/
├── rtl/                        # Verilog Design Under Test (shared across all modules)
│   └── <dut_name>.sv           # e.g., stream_fifo.sv
└── tb/                         # SystemVerilog/UVM testbench skeleton (shared)
    ├── env/                    # env, agent, driver, monitor, scoreboard (stubs)
    └── tests/                  # top-level UVM tests (smoke/regression entry points)
```

> **Note**: In Module 1 you do **not** need a fully working environment.  
> Minimal stubs are enough to reason about plan/strategy/coverage and to anchor terminology.

### Quick Start

> **Self-paced structure**: This module uses a three-folder structure:
> - **`module1/templates/`** — Empty templates to copy from
> - **`module1/.solutions/`** — Reference solutions (opt-in to view)
> - **`module1/*.md`** — Your workspace (edit these files)
> 
> See [`module1/README.md`](../module1/README.md) and [`METHODS.md`](METHODS.md) for details.

1. **Select the DUT** you will use for this course (e.g., FIFO, UART, or AXI-lite reg block).
2. **Read the DUT specification** and list all features, modes, interfaces, and constraints.
3. Place or reference the DUT RTL in `common_dut/rtl/` (shared across all modules).
4. **Edit the workspace files** in `module1/` (e.g., `VERIFICATION_PLAN.md`, `REQUIREMENTS_MATRIX.md`). Copy from `module1/templates/` if you need a fresh start, or reference `module1/.solutions/` for examples.
5. Sketch a minimal testbench structure in `common_dut/tb/` (even if files are empty) to reflect your intended UVM architecture.
6. **Validate your progress**: Run `./scripts/module1.sh` from the repository root to check structure and completeness.
7. Review and refine before moving to detailed coverage and regression planning.

## Before You Start

1. Read this module doc and `module1/README.md` for objectives and workspace layout.
2. Scaffold planning files if needed: `./scripts/module1.sh --scaffold`
3. Edit `module1/VERIFICATION_PLAN.md` and `module1/REQUIREMENTS_MATRIX.md` from templates.
4. Inspect shared DUT RTL at `common_dut/rtl/stream_fifo.sv` and the TB skeleton under `common_dut/tb/`.
5. Validate planning artifacts: `./scripts/module1.sh --check`
6. Complete `module1/CHECKLIST.md` before starting Module 2.

## Key files to study

- `module1/VERIFICATION_PLAN.md` — verification strategy, scope, and test intents
- `module1/REQUIREMENTS_MATRIX.md` — requirements-to-test traceability
- `module1/templates/` — empty templates for a fresh start
- `module1/.solutions/` — reference solutions (optional comparison)
- `common_dut/rtl/stream_fifo.sv` — shared course DUT (stream FIFO)
- `common_dut/tb/stream_fifo_env_skeleton.sv` — UVM env stub hierarchy
- `scripts/module1.sh` — validation and scaffold orchestrator

## Command Reference

### Scaffold planning workspace

```bash
./scripts/module1.sh --scaffold
```

### Validate Module 1 artifacts

```bash
./scripts/module1.sh --check
./scripts/module1.sh --summary
./scripts/module1.sh --traceability-status
```

### Inspect templates and shared DUT

```bash
head -30 module1/templates/VERIFICATION_PLAN.md
head -35 common_dut/rtl/stream_fifo.sv
```

## Design Architecture

### 1. Stream FIFO DUT (shared course RTL)

- Course DUT: `common_dut/rtl/stream_fifo.sv` — parameterizable `DEPTH` and `DATA_WIDTH`.
- **Source interface**: `s_valid`, `s_ready`, `s_data` (push when both valid and ready).
- **Sink interface**: `m_valid`, `m_ready`, `m_data` (pop on handshake).
- **Internal storage**: circular buffer (`mem`, `wr_ptr`, `rd_ptr`, `count`).
- **Status outputs**: `level`, sticky `overflow` / `underflow` on illegal handshakes.

### 2. Planning-level verification view (Module 1)

- No full UVM implementation required yet — document **intended** env boundaries in `VERIFICATION_PLAN.md`.
- `REQUIREMENTS_MATRIX.md` traces features → future tests and coverage bins.
- `common_dut/tb/` holds skeleton stubs so architecture decisions are concrete, not abstract.

### 3. Repository layout and planning workflow

- **Inputs**: DUT spec, course README, Module 1 templates and optional solutions.
- **Workspace**: edit `module1/*.md` planning documents directly in the repository.
- **Shared RTL/TB**: `common_dut/` holds the physical DUT and skeleton env reused in later modules.
- **Validation loop**: edit plan → run `./scripts/module1.sh --check` → fix TODOs → checklist sign-off.
- **Outputs**: verification scope, strategy, test catalogue intents, and coverage sketch for Module 2.

## Verification & Testing Methods

### 1. Planning-first methodology

- Start from **spec → scope → strategy** before writing large amounts of testbench code.
- Use **risk-based prioritization** to decide what to verify first in later modules.
- Separate **verification objectives** (quality/risk) from implementation details.

### 2. Test intent and validation (Module 1)

- Capture **test intents** (names, goals, tiers) in the verification plan — not full UVM tests yet.
- **Directed vs constrained-random** choices are documented with rationale for the FIFO DUT.
- **Self-check**: `./scripts/module1.sh --check` validates planning artifacts; simulation is optional.

### 3. Early closure thinking

- Sketch **functional coverage intent** and **regression tiers** (sanity / nightly / full) for later modules.
- Define **sign-off preview** criteria (coverage goals, bug bars) in the plan from day one.

## Topics Covered

### 1. Verification Mindset and Goals

- **Design vs Verification**
  - What verification is responsible for (and what it is not).
  - “Bug-finding” vs “quality and risk management”.
- **Verification Objectives**
  - Proving conformance to spec (as far as practical).
  - Managing risk: focusing on high-impact features and scenarios.
  - Balancing **schedule**, **quality**, and **resources**.
- **UVM/SV Context**
  - Why constrained-random and coverage-driven verification (CDV) matter.
  - Where SV/UVM and Verilog DUTs fit in the overall flow.

### 2. From Specification to Verification Scope

- **Requirements Intake**
  - Extracting **verifiable requirements** from a product/design spec.
  - Identifying interfaces, modes, configurations, and corner cases.
  - Capturing assumptions and dependencies (e.g., upstream/downstream blocks, firmware behavior).
- **In-Scope vs Out-of-Scope**
  - Deciding what this verification effort **will** and **will not** cover.
  - Handling legacy behavior, debug features, and low-priority modes.
- **Risk-Based Prioritization**
  - High-risk vs low-risk features.
  - Safety/criticality, complexity, novelty, and usage frequency.

### 3. Verification Strategy (SV/UVM Focus)

- **Strategy Dimensions**
  - Directed vs constrained-random vs scenario-based testing.
  - Use of reference models, assertions, and protocol checkers.
  - Layered testbench and reuse (block/IP → subsystem → SoC).
- **UVM Testbench Architecture Concepts**
  - How your **env/agent/sequence/scoreboard** choices influence planning.
  - Mapping features and scenarios to sequences and configuration knobs.
- **Choosing Strategies for the DUT**
  - For a FIFO: corner-case heavy, error injection, stress tests.
  - For a bus/reg block: protocol correctness, access patterns, error responses.
  - For a UART: timing, framing/parity errors, flow control.

### 4. Test Planning and Test Catalogue Basics

- **Test Intent vs Test Implementation**
  - Writing test descriptions at the **intent level** (what to prove).
  - Mapping intents to one or more concrete UVM tests/sequences.
- **Test Types and Tiers**
  - Smoke/sanity vs feature tests vs stress/error-injection.
  - Nightly vs weekly regressions (preview; detailed in later modules).
- **Early Test Catalogue**
  - Building a first-pass list of 10–20 key tests/intents from the spec.
  - Tagging each with requirements, priority, and expected coverage impact.

### 5. Coverage Planning Primer

- **Why Coverage is Central to Planning**
  - Functional vs code coverage and their roles.
  - “Coverage as a question”: what do you need to know to sleep at night?
- **Sketching Coverage Models**
  - Listing features, modes, and scenarios that deserve covergroups.
  - Identifying important crosses (e.g., mode × error type, address ranges × operations).
- **Defining Initial Coverage Goals**
  - Setting **measurable** but **realistic** targets.
  - Separating “must cover” from “nice to have”.

### 6. Intro to Regression and Sign-off Thinking

- **Regression at a High Level**
  - Why we need repeatable, automated regressions.
  - Basic tiers (sanity / nightly / full).
- **Sign-off Preview**
  - Types of sign-off criteria: coverage, bug bars, waivers, stability.
  - Why it’s important to think about exit criteria from Day 1.

## Learning Outcomes

By the end of this module, you should be able to:

- Explain the **role of verification** and its relationship to design.
- Turn a DUT specification into a **verification scope** with clear assumptions and boundaries.
- Draft a **verification strategy** for a simple Verilog DUT and SV/UVM environment.
- Create an initial **test catalogue** (test intents) linked to requirements.
- Sketch a **coverage plan** (what to measure and rough coverage goals).
- Describe a basic **regression concept** and outline high-level sign-off ideas.

## Test Cases (Planning Exercises)

### Test Case 1.1: Requirements and Scope Extraction

**Objective**: Derive verifiable requirements and scope from a DUT spec.

**Tasks**:
- Given a short DUT spec (e.g., FIFO or UART), list:
  - Functional requirements (what the DUT must do).
  - Non-functional/quality requirements (throughput, latency constraints, etc.).
  - Assumptions and environment constraints.
- Classify each requirement as **must-have**, **nice-to-have**, or **future**.
- Mark items explicitly as **in-scope** or **out-of-scope** for this project.

### Test Case 1.2: Drafting a Verification Strategy

**Objective**: Write a concise verification strategy for the chosen DUT.

**Tasks**:
- Choose your DUT (FIFO / UART / AXI-lite block / your own).
- In `module1/VERIFICATION_PLAN.md`, add sections for:
  - Objectives and success criteria.
  - High-level SV/UVM environment concept (env, agents, scoreboard, reference model).
  - Use of directed, random, and scenario-based tests.
  - Planned use of assertions and protocol checkers.
- Keep the strategy to **1–2 pages maximum**.

### Test Case 1.3: Initial Test Catalogue

**Objective**: Build a first-pass test catalogue linked to requirements.

**Tasks**:
- Create a table with columns:
  - Test ID
  - Test name
  - Intent / description
  - Related requirement IDs
  - Priority (H/M/L)
  - Type (smoke/feature/stress/error)
- Populate at least **10** test intents for your DUT.

### Test Case 1.4: Coverage Sketch

**Objective**: Identify key coverage points and crosses.

**Tasks**:
- From your requirement list and test catalogue, identify:
  - Signals/fields that deserve coverpoints (e.g., addresses, opcodes, status flags, error types).
  - Crosses that matter (e.g., mode × error_type, burst_length × address_range).
- Write a brief description (no code required yet) of:
  - Where each covergroup would live in the UVM testbench (monitor, scoreboard, etc.).
  - What hitting those bins would tell you about verification completeness.

## Exercises

1. **Scope and Risk Matrix**
   - Build a small risk matrix for your DUT (feature vs risk level vs complexity).
   - Use it to justify your **test priorities** and **coverage focus**.
2. **Assumption Log**
   - Write down all assumptions you are making about the environment, stimuli, and usage.
   - For each assumption, decide whether it needs: (a) a test, (b) an assertion, or (c) documentation only.
3. **UVM Architecture Sketch**
   - Draw (or describe) the planned UVM env structure for your DUT:
     - Components, agents, scoreboards, reference models.
   - Indicate where key checks and coverage will live.

## Assessment

- [ ] Can explain verification’s role and goals in the SV/UVM context.  
- [ ] Has produced a **written verification scope** (in-scope, out-of-scope, assumptions).  
- [ ] Has a concise **verification strategy** document for the chosen DUT.  
- [ ] Has an initial **test catalogue** with traceability to requirements.  
- [ ] Has a high-level **coverage plan** (what to cover and why).  
- [ ] Can articulate a basic **regression and sign-off** concept, even if details come later.

## Next Steps

After completing this module, proceed to **Module 2: Test Planning & Strategy in Depth**, where you will refine the verification plan, expand the test catalogue, and start mapping test intents to actual SV/UVM tests and sequences.

## Additional Resources

- UVM User Guide (IEEE 1800.2) – for terminology around env/agent/sequence/scoreboard.  
- Accellera/IEEE verification methodology papers on coverage-driven verification.  
- Company/internal guidelines or checklists for verification plans and sign-off (if available).

## Troubleshooting (Common Pitfalls in Planning)

- **Issue: Plan feels too “hand-wavy”**
  - Solution: Ground each section with **concrete examples** tied to specific requirements and DUT behaviors.
- **Issue: Too many tests and not enough time**
  - Solution: Apply **risk-based prioritization** and explicitly de-scope or downgrade low-value tests.
- **Issue: Unsure where to place coverage or checks in UVM**
  - Solution: Start with a simple mapping: monitors collect coverage, scoreboards/checkers implement functional checking, tests/sequences drive scenarios.


# Module 7: Real-World Verification Applications & VIP (SV/UVM)

**Duration**: 3 weeks  
**Complexity**: Advanced  
**Goal**: Apply the full methodology (planning, UVM env, coverage, regressions) to **real-world style blocks and protocols** (e.g., DMA, UART/SPI/I2C, custom IP) and design **reusable verification IP (VIP)** ready for production.

## Overview

Modules 1–6 built up your **skills and infrastructure**.  
Module 7 is about **applying** them to realistic verification challenges:

- Building end-to-end verification environments for a non-trivial DUT (e.g., DMA or protocol block).  
- Developing **reusable VIP** (agent + checker + coverage + docs).  
- Practicing **best practices** for code organization, documentation, and maintainability.  
- Executing a **capstone project** that resembles industry verification work.

This module is intentionally **less prescriptive** and more **project-oriented**.

### Examples and Code Structure (planned)

```text
module7/
├── PROJECTS.md              # Real-world style verification projects (DMA, protocols, VIP)
├── VIP_DESIGN.md            # VIP design and documentation plan for chosen protocol/IP
├── BEST_PRACTICES.md        # Code/org/maintenance best practices checklist
├── CHECKLIST.md     # Module 7 self-assessment & final project checklist
└── README.md                # This file

common_dut/
├── rtl/                     # DUT RTL (shared across all modules)
└── tb/                      # UVM testbench (shared across all modules)

```

> **Note**: The actual DUTs/environments/VIP you build can live in dedicated directories  
> (e.g., under `common_dut/tb/` or in dedicated project directories) as long as they are documented here.

### Quick Start

> **Self-paced structure**: This module uses a three-folder structure:
> - **`module7/templates/`** — Empty templates to copy from
> - **`module7/.solutions/`** — Reference solutions (opt-in to view)
> - **`module7/*.md`** — Your workspace (edit these files)
> 
> See [`module7/README.md`](../module7/README.md) and [`METHODS.md`](METHODS.md) for details.

1. Choose a **primary project** (or two smaller ones), for example:
   - A DMA-like controller at block/subsystem level.  
   - A UART/SPI/I2C/AXI-style protocol VIP.  
   - An internal IP block (if you have a spec).  
2. **Edit the workspace files** in `module7/`:
   - `module7/PROJECTS.md` – define scope, requirements, and success criteria.  
   - `module7/VIP_DESIGN.md` – outline VIP structure (agent, checker, coverage, scoreboard, reg model if relevant).  
   - `module7/BEST_PRACTICES.md` – document code/org/maintenance standards.  
   Copy from `module7/templates/` if needed, or reference `module7/.solutions/` for examples.
3. **Validate your progress**: Run `./scripts/module7.sh` from the repository root.
4. Use `module7/CHECKLIST.md` to keep the implementation aligned with industry-quality standards.

## Design Architecture

### 1. Real-world DUT / subsystem

- Choose DMA-style block, bus/register IP, or protocol DUT (UART/SPI/I2C/AXI-lite style).
- Document block diagram, clocks/resets, and interface contracts in `PROJECTS.md`.

### 2. VIP package architecture

- Reusable **VIP**: agent, sequencer, driver, monitor, checker, coverage, config objects.
- `VIP_DESIGN.md` defines public API, sequences, and integration guide for adopters.
- Package boundaries: what integrators configure vs what VIP owns internally.

### 3. Production layout

- Separate `rtl/`, `tb/`, `tests/`, `docs/` with consistent naming for handoff to another team.

## Verification & Testing Methods

### 1. End-to-end IP verification

- Full lifecycle: requirements → env → tests → coverage → regressions → sign-off preview.
- Regression tiers and coverage goals match production expectations.

### 2. VIP validation

- **Self-test** environment for the VIP plus **integrator** tests on a reference DUT.
- Documentation-driven review: another engineer can adopt VIP from docs alone.

### 3. Quality bar

- `BEST_PRACTICES.md` — coding standards, review checklist, maintenance and versioning.
- `./scripts/module7.sh --check` validates project and VIP design documentation.

## Topics Covered

### 1. End-to-End IP Verification

- Applying planning + UVM + coverage + regression to realistic IP.  
- Realistic test planning, coverage closure, and regression operation.

### 2. VIP Design and Reuse

- Designing and documenting **verification IP (VIP)** for protocols or blocks.

### 3. Production Quality and Maintenance

- Best practices for project structure, code quality, docs, and maintenance.

## Learning Outcomes

By the end of this module, you should be able to:

- Design and implement a **complete verification environment** for a realistic DUT.  
- Create and document **reusable VIP** that others could adopt.  
- Operate regressions and coverage closure **as you would in a real team**.  
- Maintain production-quality **code, docs, and tests** over the lifetime of a project.

## Assessment

- [ ] At least one substantial real-world style project is described and partially/fully implemented.  
- [ ] VIP or environment design is documented in `module7/VIP_DESIGN.md` and `module7/PROJECTS.md`.  
- [ ] Best-practices checklist largely satisfied (`module7/BEST_PRACTICES.md` / `module7/CHECKLIST.md`).  
- [ ] You can explain your project and design decisions as if presenting to a review board.  


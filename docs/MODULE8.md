# Module 8: Capstone – End‑to‑End Verification & VIP Delivery (SV/UVM)

**Duration**: 3–4 weeks  
**Complexity**: Advanced  
**Goal**: Plan and execute a **single, substantial capstone project** that exercises the full verification lifecycle (Modules 1–7), from requirements and planning through UVM environment, coverage, regressions, and delivery of a reusable **verification solution or VIP**.

## Overview

Module 8 is not another theory module; it is a **major project** that ties everything together:

- You choose a realistic DUT or protocol (or small subsystem).  
- You apply your planning, UVM, coverage, regression, and architecture skills to it.  
- You produce artifacts that look like a **production verification deliverable**: plans, code, tests, coverage/metrics, and documentation.

Typical capstone options:

- **Capstone A – DMA / Memory Subsystem Verification**  
  Verify a DMA‑style engine or memory subsystem with multiple channels, error handling, and performance goals.  
- **Capstone B – Protocol VIP (UART/SPI/I2C/AXI‑Lite)**  
  Build a reusable VIP (agent + checker + coverage + docs) for a real protocol.  
- **Capstone C – Custom IP or Subsystem from your work**  
  Apply the methodology to an internal or personal IP block/subsystem.

### Capstone Artifacts (High Level)

```text
module8/
├── capstone_project.md         # Detailed description & plan of your chosen capstone
├── checklist_module8.md        # Capstone-specific checklist and acceptance criteria
└── README.md                   # Module 8 overview and links

common_dut/
├── rtl/                        # DUT RTL (shared across all modules)
└── tb/                         # UVM testbench (shared across all modules)

```

All code (RTL, UVM, tests, scripts) can live in `common_dut/` or in dedicated project directories, as long as this module documents it clearly.

### Quick Start

> **Self-paced structure**: This module uses a three-folder structure:
> - **`module8/templates/`** — Empty templates to copy from
> - **`module8/.solutions/`** — Reference solutions (opt-in to view)
> - **`module8/*.md`** — Your workspace (edit these files)
> 
> See [`module8/README.md`](../module8/README.md) and [`METHODS.md`](METHODS.md) for details.

1. Choose your **capstone project** (DMA, protocol VIP, or custom IP).
2. **Edit the workspace files** in `module8/`:
   - `module8/CAPSTONE_PROJECT.md` – define project scope, requirements, architecture, test strategy, coverage, deliverables, and timeline.  
   Copy from `module8/templates/` if needed, or reference `module8/.solutions/` for examples.
3. **Validate your progress**: Run `./scripts/module8.sh` from the repository root.
4. Apply the full verification lifecycle (Modules 1–7) to your capstone.
5. Use `module8/CHECKLIST.md` to track completion and readiness for delivery.

## Learning Outcomes

By the end of this module, you should be able to:

- Drive an end‑to‑end verification effort from **requirements → plan → env → tests → coverage → regressions → sign‑off**.  
- Deliver a coherent, documented **verification package or VIP** that others can understand and use.  
- Reflect on trade‑offs and improvements as if you were preparing for a real project review.

## Assessment (Major Use Case)

- [ ] A clearly defined capstone project documented in `capstone_project.md`.  
- [ ] Evidence that Modules 1–7 have been applied (plans, env, tests, coverage, regressions).  
- [ ] A “deliverable” verification solution or VIP (code + docs) that could be handed to another team.  
- [ ] A short written or presented **retrospective** on what worked, what didn’t, and what you’d improve next.  


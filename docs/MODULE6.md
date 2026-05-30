# Module 6: Complex Multi-Agent & Protocol Testbenches (SV/UVM)

**Duration**: 2–3 weeks  
**Complexity**: Advanced  
**Goal**: Apply your planning, environment, and regression skills to **complex multi-agent, protocol-heavy testbenches** (e.g., AXI-like, multi-channel interfaces), focusing on architecture, protocol checking, and maintainability.

## Overview

By Module 6, you have:

- A DUT + UVM environment (`module1/`).  
- Test, regression, and coverage plans (`module2/`, `module3/`).  
- Matured environment and checkers (`module4/`).  
- Regression operations and advanced orchestration concepts (`module5/`).  

This module focuses on building and documenting **complex, multi-agent environments** and **protocol verification strategies**, including:

- Coordinating multiple agents and channels.  
- Implementing and integrating protocol checkers.  
- Designing layered testbench architectures suitable for system/subsystem-level verification.

### Examples and Code Structure (planned)

We continue to reuse the same DUT context, but now treat it as part of a more complex, protocol-oriented system.

```text
module6/
├── MULTI_AGENT_ARCHITECTURE.md       # Multi-agent & multi-channel env architecture
├── PROTOCOL_VERIFICATION_PLAN.md     # Protocol rules, checkers, and coverage
├── INTEGRATION_PLAN.md               # Integration patterns and system-level scenarios
├── CHECKLIST.md             # Module 6 self-assessment checklist
└── README.md                         # Module 6 documentation

common_dut/
├── rtl/                              # DUT RTL (shared across all modules)
└── tb/                               # UVM testbench (shared across all modules)
```

> **Note**: The **actual SV/UVM code** for multi-agent environments, protocol agents, and complex scoreboards lives in `common_dut/tb/` (or equivalent code dirs).  
> `module6/` is used to document and review these designs.

### Quick Start

> **Self-paced structure**: This module uses a three-folder structure:
> - **`module6/templates/`** — Empty templates to copy from
> - **`module6/.solutions/`** — Reference solutions (opt-in to view)
> - **`module6/*.md`** — Your workspace (edit these files)
> 
> See [`module6/README.md`](../module6/README.md) and [`METHODS.md`](METHODS.md) for details.

1. Re-open:
   - `module4/ENV_DESIGN.md` and `module4/CHECKER_PLAN.md`.  
   - `module5/ADVANCED_UVM_PLAN.md`.  
2. **Edit the workspace files** in `module6/`:
   - `module6/MULTI_AGENT_ARCHITECTURE.md` – describe your multi-agent/multi-channel env.  
   - `module6/PROTOCOL_VERIFICATION_PLAN.md` – define protocol rules, agents, and checkers.  
   - `module6/INTEGRATION_PLAN.md` – describe how components integrate at subsystem/system level.  
   Copy from `module6/templates/` if needed, or reference `module6/.solutions/` for examples.
3. **Validate your progress**: Run `./scripts/module6.sh` from the repository root.
4. Implement/refine corresponding UVM components and protocol checkers in your testbench code (`common_dut/tb/`).  
5. Use `module6/CHECKLIST.md` to track progress.

## Before You Start

1. Re-read `module4/ENV_DESIGN.md` and `module5/REGRESSION_OPS.md`.
2. Scaffold Module 6 workspace: `./scripts/module6.sh --scaffold`
3. Complete `MULTI_AGENT_ARCHITECTURE.md`, `PROTOCOL_VERIFICATION_PLAN.md`, and `INTEGRATION_PLAN.md`.
4. Add or refine multi-agent and protocol checker components in `common_dut/tb/`.
5. Validate: `./scripts/module6.sh --check`

## Key files to study

- `module6/MULTI_AGENT_ARCHITECTURE.md` — multi-channel env and virtual sequence coordination
- `module6/PROTOCOL_VERIFICATION_PLAN.md` — protocol rules, checkers, and coverage
- `module6/INTEGRATION_PLAN.md` — block-to-subsystem integration strategy
- `module4/tb/stream_pkg.sv` — monitor and agent patterns to extend
- `scripts/module6.sh` — multi-agent and protocol doc checks

## Command Reference

### Scaffold and validate Module 6

```bash
./scripts/module6.sh --scaffold
./scripts/module6.sh --check
```

### Review multi-agent architecture template

```bash
head -40 module6/templates/MULTI_AGENT_ARCHITECTURE.md
head -35 module6/templates/PROTOCOL_VERIFICATION_PLAN.md
```

## Design Architecture

### 1. Multi-agent / multi-channel TB

- Multiple **agents** (per interface or channel) coordinated by env and virtual sequences.
- **Layered architecture**: block agents → fabric/scoreboard → subsystem scenarios (`MULTI_AGENT_ARCHITECTURE.md`).

### 2. Protocol verification layer

- Dedicated **protocol checker** (SVA or monitor-based) separate from scoreboard data checks.
- `PROTOCOL_VERIFICATION_PLAN.md` lists rules, coverage, and integration with agents.

### 3. System integration view

- `INTEGRATION_PLAN.md` describes how block-level env connects to subsystem tests.
- Reuse agents/VIP across DUT variants via configuration and factory overrides.

## Verification & Testing Methods

### 1. Protocol rule testing

- Each protocol rule maps to checker fires, coverpoints, and at least one directed or random test.
- Illegal sequences and corner timing documented with expected checker behavior.

### 2. Multi-agent scenario testing

- Virtual sequences stress **cross-agent** ordering, arbitration, and backpressure.
- System scoreboard validates end-to-end data and sideband signals.

### 3. Maintainability reviews

- Architecture review before adding agents — avoid duplicate monitors and conflicting checkers.
- `./scripts/module6.sh --check` validates multi-agent and protocol planning artifacts.

## Topics Covered

### 1. Multi-Agent Environment Design

- Multi-agent and multi-channel environment design.  
- Layered and reusable testbench architecture patterns.

### 2. Protocol Agents and Checkers

- Protocol agent and protocol checker design.

### 3. Scoreboards and Integration

- Integration of complex scoreboards and time-based matching.

### 4. Debug and Analysis

- Debugging and analyzing complex, protocol-heavy simulations.

## Learning Outcomes

By the end of this module, you should be able to:

- Design and document **multi-agent UVM environments** for protocol-based DUTs.  
- Implement and integrate **protocol agents and protocol checkers**.  
- Apply **layered architecture patterns** to keep complex benches maintainable.  
- Analyze and debug **multi-channel, protocol-level behavior** in simulations.  

## Assessment

- [ ] Multi-agent/multi-channel environment design documented in `module6/MULTI_AGENT_ARCHITECTURE.md`.  
- [ ] Protocol verification strategy documented in `module6/PROTOCOL_VERIFICATION_PLAN.md`.  
- [ ] Integration patterns and system-level scenarios documented in `module6/INTEGRATION_PLAN.md`.  
- [ ] Complex bench design reviewed; action items captured in the docs.  


# Real-World Verification Projects (Module 7)

> **Purpose**: Describe one or more real-world style verification projects you will implement (DMA, protocols, custom IP, etc.).  
> **Module**: 7 – Real-World Verification Applications & VIP (SV/UVM)

## 1. Project Overview

For each project, capture a short summary and status.

### Project P1 – Stream FIFO Verification

- **DUT / IP**: stream_fifo — parameterizable streaming FIFO with ready/valid handshakes (common_dut/rtl/stream_fifo.sv).  
- **Scope**:
  - Level: block.  
  - Features: In-order transfer (R1), overflow/underflow flags (R2, R3), backpressure, simultaneous push/pop, parameterized DATA_WIDTH and DEPTH.  
- **Goals**:
  - Functional correctness for R1–R3.  
  - Protocol adherence (ready/valid handshake, flag semantics).  
  - Coverage (CG_LEVEL, CG_OPS, CG_FLAGS, CG_BACKPRESSURE) and regression (sanity/core/stress) targets.  
- **Status**:
  - Initial version: UVM env (module4/tb), coverage design (module3), regression and debug plans (module5–6) in place; implementation and runs ongoing.  

### Project P2 – Stream VIP (Ready/Valid Streaming)

- **DUT / IP**: Reusable VIP for ready/valid streaming protocol (no specific DUT; used by stream_fifo and potentially other FIFOs/streaming blocks).  
- **Scope & goals**:
  - Level: VIP component set.  
  - Features: stream_if, stream_item, stream_driver, stream_monitor, stream_scoreboard, protocol checker (assertions), coverage model.  
  - Goals: Reuse across block-level verification; clear config and sequences; documentation for integration.  
- **Status**:
  - Initial version: Implemented in module4/tb and common_dut/tb (stream_if, stream_pkg, stream_fifo_coverage); VIP design documented in vip_design.md.  

Add more projects as needed.

## 2. Requirements and Use Cases

For each project, list key requirements and use cases (link to `module1/REQUIREMENTS_MATRIX.md` if you use it).

Example for P1:

| Req ID     | Description                                | Priority (H/M/L) | Notes |
|------------|--------------------------------------------|------------------|-------|
| R1         | In-order data transfer                     | H                | module1 REQUIREMENTS_MATRIX |
| R2         | Overflow flag set/retain when write when full | H             | module1 REQUIREMENTS_MATRIX |
| R3         | Underflow flag set/retain when read when empty | M             | module1 REQUIREMENTS_MATRIX |

Fill with your actual requirements:

- **P1**: R1, R2, R3 from module1/REQUIREMENTS_MATRIX.md; test catalogue in module2/TEST_PLAN.md (SMK_001–SMK_003, FTR_001–FTR_013, ERR_001–ERR_006, STR_001–STR_013, PERF_001–PERF_003).  
- **P2**: VIP requirements = protocol compliance (handshake, ordering), configurable (active/passive, coverage on/off), reusable sequences.  

## 3. Planned Verification Approach

Summarize how you'll verify each project, referencing earlier module docs.

### P1 – Approach

- **Environment**:
  - Reuse of base env from `common_dut/tb/` and `module4/ENV_DESIGN.md`: stream_env (driver, monitor, scoreboard); stream_if, stream_pkg.  
  - Coverage: stream_fifo_coverage (common_dut/tb); assertions via bind (module4/CHECKER_PLAN).  
- **Tests**:
  - Link to test IDs in `module2/TEST_PLAN.md`: smoke (SMK_001–003), feature (FTR_001–013), error (ERR_001–006), stress (STR_001–013), performance (PERF_001–003).  
  - Scenarios: basic push/pop, boundary fill/drain, simultaneous push/pop, overflow/underflow injection, backpressure, random/stress.  
- **Coverage**:
  - CG_LEVEL, CG_OPS, CG_FLAGS, CG_BACKPRESSURE (module3/COVERAGE_DESIGN.md); closure via directed and random sequences; logs in module3/COVERAGE_RUN.md.  
- **Regressions**:
  - sanity (SANITY tier), core_nightly (CORE tier), stress_weekly (STRESS/FULL); see module5/REGRESSION_OPS.md.  

Document your concrete plan:

- **P1**: Implement remaining sequences (boundary_seq, overflow_seq, underflow_seq, backpressure_seq) and full scoreboard compare; add assertion bind file; run sanity/core/stress jobs and collect coverage; track in checklist and run logs.  

### P2 – Approach

Similarly describe for P2:

- **P2**: Package stream_if, stream_item, stream_driver, stream_monitor, base sequences, and optional stream_scoreboard/checker/coverage as a reusable VIP; document config (vif, seed, coverage enable), integration steps, and example tests in VIP_DESIGN.md and README.  

## 4. Risks and Constraints

Identify major risks or constraints:

- **Schedule**: Module-based planning complete; implementation and regression runs are the next focus.  
- **Tools**: Simulator (Verilator or commercial) must support UVM and coverage; bind files and coverage options may vary.  
- **Specs**: stream_fifo spec is stable (R1–R3); no incomplete specs.  
- **Complexity**: Single block, two interfaces; complexity is low; main risk is flaky stress tests (addressed in module5 DEBUG_FLAKE_PLAN).  

Document:

- **Mitigation**: Use fixed seeds for sanity/core where possible; document tool-specific options in README; quarantine flaky tests per module5.  

## 5. Milestones

Define key milestones for each project.

| Project | Milestone ID | Description                      | Target Date | Status |
|---------|--------------|----------------------------------|-------------|--------|
| P1      | P1_M1        | Basic env + smoke tests running | Done        | Done   |
| P1      | P1_M2        | Core features verified (FTR/ERR subset) | TBD    | In progress |
| P1      | P1_M3        | Coverage and regression stable   | TBD         | Planned |
| P2      | P2_M1        | VIP skeleton implemented        | Done        | Done   |
| P2      | P2_M2        | VIP doc and reuse recipe         | Done        | Done   |

## 6. Notes and Lessons Learned

Use this section to jot down real-world insights:

- **What went well**: Modular planning (modules 1–6) gave clear traceability from requirements to tests to coverage to regression; stream_fifo is a good teaching DUT (simple protocol, clear R1–R3).  
- **Harder than expected**: Scoreboard expected queue (source-side data) requires driver callback or source monitor; initially only sink monitor was implemented.  
- **Helpful**: Consistent naming (stream_*, SMK_*, FTR_*, etc.); single checklist and run scripts per module.  

Free-form notes:

- Lessons will be updated as implementation and regressions progress.  

## 7. Revision History

| Date       | Version | Author | Changes                         |
|------------|---------|--------|---------------------------------|
| 2026-02-05 | 0.1     | Yongfu | Initial projects overview for P1 (stream_fifo), P2 (stream VIP); requirements, approach, milestones |

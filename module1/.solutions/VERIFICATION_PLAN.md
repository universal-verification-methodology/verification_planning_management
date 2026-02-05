# Verification Plan Template (Module 1)

> **Purpose**: Capture the initial verification plan for your chosen DUT  
> **Module**: 1 – Verification Planning & Management Foundations (SV/UVM)

## 1. Project and DUT Overview

- **Project name**: Stream FIFO Verification  
- **Block/DUT name**: `stream_fifo`  
- **Owner(s)**: Yongfu  
- **Date / version**: 2026-02-03 / v0.1  

### 1.1 DUT Description

- **High-level function**:  
  - `stream_fifo` is a parameterizable streaming FIFO that buffers data between a source and a sink using ready/valid handshakes.  
  - It stores up to `DEPTH` elements of `DATA_WIDTH` bits each and guarantees in-order delivery.  
  - It exposes status information (current fill level) and sticky overflow/underflow flags to aid system-level flow control and debug.  
- **External interfaces** (ports, buses, clocks, resets):  
  - `clk`, `rst_n`: single clock and active-low asynchronous reset for all internal state.  
  - Source interface: `s_valid`, `s_ready`, `s_data[DATA_WIDTH-1:0]` implementing a standard ready/valid streaming handshake.  
  - Sink interface: `m_valid`, `m_ready`, `m_data[DATA_WIDTH-1:0]` implementing a standard ready/valid streaming handshake.  
  - Status: `level[$clog2(DEPTH+1)-1:0]`, `overflow`, `underflow` to expose FIFO occupancy and error conditions.  
- **Operating modes / configurations**:  
  - Normal buffered streaming mode with independent source and sink handshakes.  
  - Parameter-based configurations via `DATA_WIDTH` and `DEPTH` to trade off storage versus area.  
  - No low-power or special test/loopback modes are implemented in RTL; such behaviors are out-of-scope for this block-level plan.

### 1.2 Dependencies and Environment

- **Upstream/downstream blocks**:  
  - Upstream: a streaming data producer such as a packetizer, DMA engine, or protocol adapter that drives `s_valid`/`s_data` and observes `s_ready`.  
  - Downstream: a streaming consumer such as a sink interface, serializer, or processing block that drives `m_ready` and samples `m_valid`/`m_data`.  
- **Firmware/software interaction**:  
  - This block has no direct register interface; SW interacts only indirectly by configuring the producer/consumer blocks that surround the FIFO.  
  - SW may observe FIFO status via higher-level aggregation logic, but such visibility is assumed and not modeled explicitly here.  
- **Assumptions about environment**:  
  - Single, free-running clock; `rst_n` is asserted low asynchronously and released synchronously to `clk`.  
  - Ready/valid protocol is respected: data is only sampled when both valid and ready are high on a rising edge.  
  - `DATA_WIDTH` and `DEPTH` remain static after synthesis; no dynamic reconfiguration during operation.  
  - No metastability or CDC concerns (block is single-clock).

## 2. Verification Objectives and Scope

### 2.1 Objectives

Describe the **goals of verification** for this DUT. Examples:

- Demonstrate functional correctness for all **in-scope features** under normal and corner conditions.
- Achieve **agreed coverage goals** (functional + code).
- Limit **escaped defects** in high-risk areas (list them).

**Objectives**:

- Demonstrate correct in-order data transfer between source and sink under a variety of backpressure scenarios.  
- Verify correct management of FIFO occupancy (`level`) including empty, partially full, and full conditions.  
- Prove sticky overflow/underflow flag behavior when the producer/consumer violate protocol assumptions.  
- Achieve agreed functional coverage goals for occupancy, handshakes, and error conditions, and reasonable code coverage (statement/branch).  
- Ensure that all high-risk behaviors (boundary levels, simultaneous push/pop, prolonged backpressure) are exercised and checked.

### 2.2 In-Scope

List **features/behaviors** that are explicitly in scope.

- Basic FIFO behavior: enqueue and dequeue with in-order delivery.  
- Handling of empty and full conditions, including proper `s_ready`/`m_valid` behavior.  
- Sticky overflow and underflow flag behavior and reset semantics.  
- Interaction under backpressure (e.g., producer faster than consumer, consumer faster than producer).  
- Simultaneous push and pop in the same cycle and its impact on occupancy and data ordering.  
- Behavior across reset (state initialization, flag clearing).

### 2.3 Out-of-Scope

List items **you will not verify** (or only minimally), with justification.

- Low-power, retention, or clock-gating behavior – not implemented in RTL and handled at a higher integration level.  
- Multi-clock or asynchronous FIFO variants – this block is single-clock only.  
- Performance benchmarking beyond basic throughput/latency sanity – detailed performance analysis is deferred to system-level verification.

### 2.4 Risk Assessment

Briefly classify features by **risk level** (H/M/L) and complexity.

| Feature / Behavior                      | Risk (H/M/L) | Complexity (H/M/L) | Notes / Rationale                                      |
|--------------------|--------------|--------------------|-------------------|
| Basic enqueue/dequeue ordering        | M              | M                  | Fundamental behavior; logic is straightforward.       |
| Full/empty boundary handling          | H              | M                  | Off-by-one errors common; directly impacts data loss. |
| Sticky overflow/underflow flags       | H              | L                  | Simple logic but critical for debug and safety.       |
| Simultaneous push/pop under backpressure | M           | H                  | More complex state interaction and corner cases.      |

## 3. Verification Strategy (SV/UVM)

### 3.1 Overall Approach

Describe the **high-level strategy**:

- Use of **directed tests** vs **constrained-random** vs **scenario-based** tests.
- Use of **assertions** (SVA) and **reference models**.
- Layering: block vs subsystem, reuse plans (if any).

**Strategy summary (1–2 paragraphs)**:

- Start with a small set of directed tests to validate basic push/pop behavior, boundary conditions (empty/full), and error flag semantics.  
- Evolve towards constrained-random sequences that vary burst lengths, backpressure patterns, and reset timing to expose unexpected corner cases.  
- Use simple scoreboarding (queue-based reference model) to check in-order delivery and data integrity, and add assertions on handshake and flag behavior to catch protocol violations early.  
- The block-level environment will be reusable at subsystem level by plugging the same FIFO agent and scoreboard into larger topologies.

### 3.2 UVM Environment Concept

Outline the planned SV/UVM testbench architecture.

- **Top-level test(s)**:  
  - `smoke_test`: bring-up of FIFO with a few directed push/pop operations.  
  - `basic_regression_test`: runs a mix of directed and simple random sequences across multiple seeds.  
- **Environment**:  
  - `stream_fifo_env` responsible for connecting agents, scoreboard, and coverage, and exposing knobs for data patterns, backpressure, and reset injection.  
- **Agents** (one per interface/protocol):  
  - `stream_src_agent` to drive the source interface (`s_valid`, `s_data`, observe `s_ready`).  
  - `stream_sink_agent` to drive the sink ready and observe `m_valid`/`m_data`.  
- **Sequences / sequence items**:  
  - Sanity sequences for single pushes/pops, short bursts, and ordered traffic.  
  - Random sequences that vary burst length, data patterns, and inter-packet gaps.  
  - Error-injection sequences that intentionally cause overflow/underflow by violating ready/valid assumptions.  
  - Stress sequences with long runs at or near full/empty boundaries.  
- **Scoreboard / reference model**:  
  - A simple queue-based reference model that mirrors all successful pushes and compares popped data against DUT outputs; also checks level vs queue depth.  
- **Assertions / protocol checkers**:  
  - Interface assertions bound to the DUT or monitors to ensure handshake correctness and flag-setting rules (e.g., overflow only when write on full, underflow only when read on empty).

## 4. Test Planning and Test Catalogue

### 4.1 Test Types and Tiers

Define your test tiers:

- **Smoke / sanity**: Short directed tests that push a few items, pop them back, and lightly exercise flags.  
- **Feature tests**: Directed tests that target specific features such as boundary levels, simultaneous push/pop, and reset behavior.  
- **Stress / random**: Longer-running constrained-random tests with varied backpressure and data patterns to shake out corner cases.  
- **Error-injection / negative**: Tests that deliberately drive overflow/underflow scenarios and protocol violations to confirm robust flagging.

### 4.2 Initial Test Catalogue

List initial test intents. Keep details in `requirements_matrix.md` if preferred.

| Test ID | Test Name             | Intent / Description                               | Related Req IDs | Priority (H/M/L) | Type (smoke/feature/stress/error) |
|--------:|-----------------------|----------------------------------------------------|-----------------|------------------|------------------------------------|
| T1      | basic_push_pop        | Verify simple enqueue/dequeue and in-order data   | R1              | H                | smoke                              |
| T2      | boundary_full_empty   | Exercise transitions to/from empty/full and flags | R1, R2, R3      | H                | feature                            |
| T3      | overflow_underflow_err| Drive explicit overflow and underflow error scenarios | R2, R3      | H                | error                              |
| T4      | simultaneous_push_pop | Verify correct behavior when push and pop occur in same cycle | R1          | M                | feature                            |
| T5      | backpressure_source   | Test sustained backpressure from sink (sink slower than source) | R1      | M                | stress                             |
| T6      | backpressure_sink     | Test sustained backpressure from source (source slower than sink) | R1  | M                | stress                             |
| T7      | reset_behavior        | Verify reset clears state, flags, and initializes FIFO correctly | R1, R2, R3 | H | feature                            |
| T8      | level_tracking        | Verify level signal accuracy across all occupancy states | R1          | M                | feature                            |
| T9      | burst_transfer        | Test burst transfers (multiple consecutive pushes followed by pops) | R1      | M                | feature                            |
| T10     | random_data_patterns  | Constrained-random test with varied data patterns and backpressure | R1    | M                | stress                             |
| T11     | stress_full_empty     | Stress test alternating between full and empty conditions rapidly | R1, R2, R3 | M | stress                             |
| T12     | concurrent_ops        | Test various combinations of concurrent operations and backpressure | R1    | M                | stress                             |

## 5. Coverage Planning

### 5.1 Functional Coverage

List **key coverage points** you intend to model:

- **Covergroups**:
  - `cg_level`: bins for FIFO occupancy (empty, low, mid, high, full).  
  - `cg_ops`: classification of operations per cycle (idle, push-only, pop-only, push+pop).  
  - `cg_flags`: occurrences of overflow and underflow, including sequences around reset.  

- **Important crosses**:
  - `cross_level_flags`: cross of occupancy level × {overflow, underflow} to ensure flags are only raised in legal states.  
  - `cross_ops_backpressure`: cross of operation type × backpressure pattern (e.g., sustained full, sustained empty).

### 5.2 Code Coverage Expectations

- **Target code coverage** (statement/branch/toggle, as applicable):  
  - At least 95% statement and 90% branch coverage on the FIFO RTL, with any exclusions documented.  
- **Known exclusions / waivers** (tentative):  
  - Debug-only code or synthesis pragmas (if any) that are not reachable in normal operation.  
  - Any tool-inserted logic that is not controllable from the testbench.

### 5.3 Coverage Goals and Closure Philosophy

Describe what “coverage closure” means for this project:

- All high-risk features (boundary handling, flags, simultaneous push/pop) must reach 100% functional coverage with no uncovered bins.  
- Medium-risk behaviors (typical traffic patterns, moderate backpressure) should reach ≥ 90% coverage, with remaining holes reviewed and justified.  
- Code coverage targets must be met or waived with clear rationale, and no uncovered code should hide untested functional behavior.

## 6. Regression and Sign-off (High-Level)

### 6.1 Regression Strategy (Preview)

Short description only (details will evolve later modules):

- Planned **tiers** (e.g., per-commit sanity, nightly medium, weekly full).
- Approximate test sets per tier.
- Any **runtime constraints** or farm limits.

**Summary**:

- Per-commit: run a small smoke suite (e.g., `smoke_test`, basic push/pop) to catch obvious breakages quickly.  
- Nightly: run a medium suite of feature and stress tests with a modest number of random seeds.  
- Weekly (or milestone): run an extended regression with more seeds and additional error-injection scenarios, reporting full coverage.

### 6.2 Sign-off Criteria (Preview)

Initial idea of what you’ll require for sign-off:

- Coverage targets met (or waivers agreed).  
- Bug metrics (no open P0/P1 in-scope; acceptable P2/P3 levels).  
- Regression stability (e.g., N consecutive clean nightlies).  
- Documentation complete (plan, waivers, release notes).

**Draft sign-off bullets**:

- All high-priority requirements covered by at least one passing test, coverage item, and checker.  
- Functional coverage goals achieved (or waivers signed off) and code coverage targets met.  
- No open P0/P1 bugs within the defined scope; acceptable residual risk for P2/P3 issues.  
- Stable regressions (e.g., N consecutive clean nightly runs) and documentation updated (plan, matrix, waivers).

## 7. Open Questions and Risks

Track known unknowns and decisions that still need to be made.

- **Open questions**:
  - Do higher-level blocks rely on additional status (e.g., almost_full/empty) that might need to be added and verified later?  
  - Are there any system-level timing constraints (throughput/latency) that should be modeled as formal requirements?  
- **Risks / concerns**:
  - Underestimating the impact of boundary bugs (off-by-one in level or full/empty) on system behavior.  
  - Insufficient randomization of backpressure patterns leading to untested long-tail scenarios.

## 8. Review and Action Items

### 8.1 Review Summary

**Review Date**: 2026-02-03  
**Review Type**: Self-review and informal peer review  
**Reviewer(s)**: Yongfu (self), plus informal discussion with verification team  

**Review Scope**:
- Verification plan completeness and clarity
- Requirements traceability coverage
- Test catalogue adequacy
- Coverage planning alignment with requirements
- Readiness for Module 2 implementation

**Review Findings**:
- ✅ Verification plan covers all key aspects: objectives, scope, strategy, tests, coverage, and sign-off criteria
- ✅ Requirements are clearly identified and mapped to tests, coverage, and checkers
- ✅ Test catalogue provides good coverage across smoke, feature, stress, and error categories
- ✅ Coverage planning aligns with high-risk areas identified in risk assessment
- ✅ Traceability matrix demonstrates clear mapping from requirements to verification artifacts
- ⚠️ Some implementation details (e.g., specific UVM component file names) are tentative and will be refined in Module 2
- ⚠️ Coverage goals are ambitious but achievable; may need adjustment based on initial implementation results

**Overall Assessment**: Plan is comprehensive and ready for Module 2 implementation. The strategy is sound, requirements are well-defined, and traceability is established. Minor refinements expected during implementation.

### 8.2 Action Items

| Action Item ID | Description | Owner | Status | Target Module |
|----------------|-------------|-------|--------|---------------|
| AI-1 | Implement UVM environment structure (`stream_fifo_env`, agents, scoreboard) | TBD | Pending | Module 2 |
| AI-2 | Implement initial test suite (T1-T4: smoke and basic feature tests) | TBD | Pending | Module 2 |
| AI-3 | Implement functional coverage model (`cg_level`, `cg_ops`, `cg_flags`) | TBD | Pending | Module 3 |
| AI-4 | Implement SVA assertions for overflow/underflow protocol checking | TBD | Pending | Module 2 |
| AI-5 | Validate coverage goals after initial test runs; adjust if needed | TBD | Pending | Module 3 |
| AI-6 | Document any additional requirements discovered during implementation | TBD | Pending | Module 2 |
| AI-7 | Establish regression infrastructure (tiering, automation) | TBD | Pending | Module 5 |

**Notes**:
- Action items AI-1 through AI-4 are critical path for Module 2
- AI-5 is a validation checkpoint after initial implementation
- AI-6 ensures requirements remain current as implementation progresses
- AI-7 is deferred to Module 5 per curriculum structure

## 9. Revision History

| Date       | Version | Author | Changes                         |
|-----------|---------|--------|---------------------------------|
| 2026-02-03| 0.1     | Yongfu | Initial draft for `stream_fifo` |


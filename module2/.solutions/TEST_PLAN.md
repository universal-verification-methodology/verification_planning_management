# Detailed Test Plan (Module 2)

> **Purpose**: Refine and expand the test catalogue and test strategy for your DUT.  
> **Module**: 2 – Test Planning & Strategy in Depth (SV/UVM)

## 1. Context

- **Project name**: Stream FIFO Verification  
- **Block/DUT name**: `stream_fifo`  
- **Module 1 artifacts**:
  - Verification plan: `module1/VERIFICATION_PLAN.md`
  - Requirements matrix: `module1/REQUIREMENTS_MATRIX.md`

Summarize any key decisions from Module 1 that affect test planning:

- DUT is a parameterizable streaming FIFO with ready/valid handshakes, supporting DATA_WIDTH=8 and DEPTH=16 by default.
- Three core requirements identified: R1 (in-order transfer), R2 (overflow flag), R3 (underflow flag).
- Initial test catalogue of 12 tests (T1-T12) established covering smoke, feature, stress, and error categories.
- Coverage model planned with CG_LEVEL, CG_OPS, CG_FLAGS, and CROSS_LEVEL_FLAGS.
- Scoreboard (SB_MAIN) and SVA assertions (A_OVERFLOW, A_UNDERFLOW) planned for checking.
- Strategy emphasizes directed tests first, evolving to constrained-random with error injection.

## 2. Test Taxonomy

### 2.1 Test Types

Define your test types and their intent. Example:

- **Smoke/Sanity**: Very short tests that validate basic bring-up, clock/reset, and primary use-cases.  
- **Feature**: Tests that target specific DUT features or requirement groups.  
- **Stress**: High-load, long-running, or extreme-parameter tests.  
- **Error/Negative**: Tests that deliberately inject illegal/invalid conditions.  
- **Performance** (if applicable): Tests focused on throughput/latency or similar metrics.

Fill in your definitions:

- Smoke/Sanity: Very short tests (typically < 1 minute) that validate basic bring-up, clock/reset, and primary use-cases. These tests verify fundamental FIFO operations (push, pop, empty, full) with minimal complexity. Examples: basic push/pop, reset behavior, simple boundary checks.
- Feature: Tests that target specific DUT features or requirement groups. These are directed tests focusing on particular behaviors such as simultaneous push/pop, level tracking accuracy, burst transfers, and flag behavior. Runtime typically 1-5 minutes. Examples: boundary_full_empty, simultaneous_push_pop, level_tracking.
- Stress: High-load, long-running, or extreme-parameter tests designed to exercise corner cases and boundary conditions under sustained operation. These tests use constrained-random sequences with varied backpressure patterns, data patterns, and extended durations. Runtime typically 5-30 minutes. Examples: backpressure scenarios, random data patterns, stress_full_empty, concurrent operations.
- Error/Negative: Tests that deliberately inject illegal/invalid conditions to verify robust error handling and flag behavior. These tests violate protocol assumptions (e.g., write when full, read when empty) to ensure overflow/underflow flags are set correctly and remain sticky until reset. Runtime typically 1-5 minutes. Examples: overflow_underflow_err, protocol violations, illegal state transitions.
- Performance/Other: Tests focused on throughput/latency or similar metrics. For this FIFO, performance tests verify sustained throughput under various backpressure scenarios and measure latency from push to pop. Runtime typically 5-15 minutes. Examples: throughput_measurement, latency_analysis, sustained_transfer_rate.  

### 2.2 Test Tiers

Define where and how often tests will run:

| Tier Name | Description                         | Cadence          | Target Runtime | Notes                      |
|----------:|-------------------------------------|------------------|----------------|----------------------------|
| SANITY    | Quick bring-up / health checks     | per-commit       | < 5 minutes    | Smoke tests only, fast feedback |
| CORE      | Main feature and corner tests      | nightly          | < 2 hours      | Majority of feature coverage    |
| STRESS    | Long-run / heavy-load tests        | weekly/on-demand | < 4 hours      | Extended random and stress tests |
| FULL      | Everything, including experiments  | ad-hoc/release   | < 8 hours      | Complete regression with coverage |

Adjust or rename tiers as needed for your project.

## 3. Test Metadata and Conventions

### 3.1 Naming and IDs

Define conventions for:

- **Test IDs**: e.g., `SMK_XXX`, `FTR_XXX`, `STR_XXX`, `ERR_XXX`.  
- **UVM test class names**: e.g., `smoke_basic_test`, `fifo_overflow_stress_test`.  
- **Sequences**: e.g., `basic_rw_seq`, `random_burst_seq`, `illegal_access_seq`.

Document your scheme:

- Test ID prefix mapping: 
  - `SMK_` for smoke/sanity tests (e.g., SMK_001, SMK_002)
  - `FTR_` for feature tests (e.g., FTR_001, FTR_002)
  - `STR_` for stress tests (e.g., STR_001, STR_002)
  - `ERR_` for error/negative tests (e.g., ERR_001, ERR_002)
  - `PERF_` for performance tests (e.g., PERF_001)
- UVM test naming conventions: 
  - Lowercase with underscores: `smoke_basic_test`, `fifo_boundary_test`, `overflow_error_test`
  - Pattern: `<category>_<feature>_test` or `<category>_<scenario>_test`
  - Examples: `smoke_basic_test`, `fifo_simultaneous_push_pop_test`, `stress_backpressure_source_test`
- Sequence naming conventions:
  - Lowercase with underscores: `basic_rw_seq`, `random_burst_seq`, `illegal_access_seq`
  - Pattern: `<intent>_seq` or `<operation>_<pattern>_seq`
  - Examples: `basic_push_pop_seq`, `random_burst_seq`, `overflow_injection_seq`, `backpressure_source_seq`  

### 3.2 Runtime and Stability

For each test, plan to track:

- **Runtime class**: short / medium / long.  
- **Determinism**: deterministic vs random.  
- **Flake risk**: low / medium / high (based on design, randomness, environment).

## 4. Test Catalogue

Use this section to maintain your detailed test catalogue. You can also mirror or summarize this in `requirements_matrix.md`.

### 4.1 Catalogue Table

| Test ID | UVM Test Name            | Intent / Description                              | Type     | Tier   | Runtime | Determinism | Related Req IDs | Notes |
|--------:|--------------------------|---------------------------------------------------|----------|--------|---------|-------------|-----------------|-------|
| SMK_001 | smoke_basic_test         | Basic push/pop operations, verify in-order data   | smoke    | SANITY | short   | deterministic| R1              | Foundation test |
| SMK_002 | smoke_reset_test         | Verify reset clears state, flags, initializes FIFO| smoke    | SANITY | short   | deterministic| R1, R2, R3      | Reset validation |
| SMK_003 | smoke_empty_full_test    | Quick check of empty and full boundary conditions | smoke    | SANITY | short   | deterministic| R1, R2, R3      | Boundary sanity |
| FTR_001 | fifo_boundary_test       | Exercise transitions to/from empty/full and flags | feature  | CORE   | medium  | deterministic| R1, R2, R3      | T2 equivalent |
| FTR_002 | fifo_simultaneous_test   | Verify push and pop in same cycle                 | feature  | CORE   | medium  | deterministic| R1              | T4 equivalent |
| FTR_003 | fifo_level_tracking_test | Verify level signal accuracy across all states   | feature  | CORE   | medium  | deterministic| R1              | T8 equivalent |
| FTR_004 | fifo_burst_transfer_test | Test burst transfers (multiple pushes then pops) | feature  | CORE   | medium  | deterministic| R1              | T9 equivalent |
| FTR_005 | fifo_single_entry_test   | Test FIFO behavior with DEPTH=1                  | feature  | CORE   | medium  | deterministic| R1, R2, R3      | Edge case |
| FTR_006 | fifo_wrap_around_test    | Test pointer wrap-around at DEPTH boundary         | feature  | CORE   | medium  | deterministic| R1              | Pointer logic |
| FTR_007 | fifo_data_width_test     | Test with different DATA_WIDTH values              | feature  | CORE   | medium  | deterministic| R1              | Parameterization |
| FTR_008 | fifo_depth_variation_test| Test with different DEPTH values                  | feature  | CORE   | medium  | deterministic| R1, R2, R3      | Parameterization |
| FTR_009 | fifo_rapid_toggle_test   | Rapidly toggle between push and pop operations    | feature  | CORE   | medium  | deterministic| R1              | State transitions |
| FTR_010 | fifo_level_accuracy_test | Detailed level tracking at every occupancy state  | feature  | CORE   | medium  | deterministic| R1              | Level verification |
| ERR_001 | overflow_error_test      | Drive explicit overflow error scenarios           | error    | CORE   | medium  | deterministic| R2              | T3 overflow part |
| ERR_002 | underflow_error_test     | Drive explicit underflow error scenarios           | error    | CORE   | medium  | deterministic| R3              | T3 underflow part |
| ERR_003 | overflow_underflow_test  | Combined overflow and underflow error injection   | error    | CORE   | medium  | deterministic| R2, R3          | T3 equivalent |
| ERR_004 | protocol_violation_test  | Test various ready/valid protocol violations      | error    | CORE   | medium  | deterministic| R2, R3          | Protocol checks |
| ERR_005 | flag_sticky_test         | Verify overflow/underflow flags remain sticky     | error    | CORE   | medium  | deterministic| R2, R3          | Flag persistence |
| STR_001 | backpressure_source_test | Sustained backpressure from sink (sink slower)   | stress   | STRESS | long    | random      | R1              | T5 equivalent |
| STR_002 | backpressure_sink_test   | Sustained backpressure from source (source slower)| stress   | STRESS | long    | random      | R1              | T6 equivalent |
| STR_003 | stress_full_empty_test   | Stress test alternating full/empty rapidly         | stress   | STRESS | long    | random      | R1, R2, R3      | T11 equivalent |
| STR_004 | random_data_patterns_test| Constrained-random with varied patterns           | stress   | STRESS | long    | random      | R1              | T10 equivalent |
| STR_005 | concurrent_ops_test      | Various concurrent operations and backpressure    | stress   | STRESS | long    | random      | R1              | T12 equivalent |
| STR_006 | long_duration_test       | Extended duration test with random traffic         | stress   | STRESS | long    | random      | R1              | Stability check |
| STR_007 | high_throughput_test     | Maximum throughput scenario with minimal gaps     | stress   | STRESS | long    | random      | R1              | Performance |
| STR_008 | near_full_stress_test    | Sustained operation near full capacity            | stress   | STRESS | long    | random      | R1, R2          | Boundary stress |
| STR_009 | near_empty_stress_test   | Sustained operation near empty capacity            | stress   | STRESS | long    | random      | R1, R3          | Boundary stress |
| STR_010 | random_reset_test        | Random reset injection during active operation    | stress   | STRESS | long    | random      | R1, R2, R3      | Reset robustness |
| STR_011 | mixed_backpressure_test  | Mixed backpressure patterns with random data      | stress   | STRESS | long    | random      | R1              | Complex scenario |
| STR_012 | extreme_burst_test       | Very long bursts with varying backpressure        | stress   | STRESS | long    | random      | R1              | Burst stress |
| PERF_001 | throughput_measurement_test| Measure sustained throughput under various loads | performance| STRESS | long    | deterministic| R1              | Performance metric |
| PERF_002 | latency_analysis_test    | Measure latency from push to pop                   | performance| STRESS | medium  | deterministic| R1              | Performance metric |
| PERF_003 | sustained_rate_test      | Sustained transfer rate over extended period       | performance| STRESS | long    | deterministic| R1              | Performance metric |
| FTR_011 | fifo_occupancy_states_test| Exercise all occupancy states (0 to DEPTH)        | feature  | CORE   | medium  | deterministic| R1              | Coverage driver |
| FTR_012 | fifo_op_combinations_test| Test all operation combinations (idle/push/pop/both)| feature  | CORE   | medium  | deterministic| R1              | Coverage driver |
| FTR_013 | fifo_flag_combinations_test| Test overflow/underflow flag combinations        | feature  | CORE   | medium  | deterministic| R2, R3          | Flag coverage |
| ERR_006 | illegal_state_test      | Test illegal state transitions and recovery        | error    | CORE   | medium  | deterministic| R2, R3          | State machine |
| STR_013 | coverage_closure_test   | Long random test targeting coverage closure        | stress   | FULL   | long    | random      | R1, R2, R3      | Coverage driver |

Grow this table to at least **25–40** entries over time, with a focus on:

- High-risk requirements and features.  
- Interfaces/protocol scenarios.  
- Mode/configuration combinations.  
- Negative, stress, and corner cases.

### 4.2 Redundancy and Consolidation Notes

Identify and document any redundant/low-value tests:

- **ERR_001 and ERR_002 vs ERR_003**: ERR_001 and ERR_002 are focused single-error tests, while ERR_003 combines both. All three are valuable for different purposes: ERR_001/ERR_002 for focused debugging, ERR_003 for combined scenarios. **Decision**: Keep all three.
- **FTR_005 (single_entry_test)**: Tests DEPTH=1 edge case. While valuable, this could be parameterized into FTR_008 (depth_variation_test). **Decision**: Keep FTR_005 as explicit test for clarity, but ensure FTR_008 covers DEPTH=1 as well.
- **STR_008 and STR_009 vs STR_003**: STR_008/STR_009 focus on sustained near-boundary operation, while STR_003 alternates rapidly. **Decision**: Keep all - different stress patterns serve different purposes.
- **PERF_001, PERF_002, PERF_003**: Performance tests may overlap with stress tests. **Decision**: Keep performance tests separate for explicit performance sign-off, but ensure they don't duplicate stress test scenarios unnecessarily.  

## 5. Negative and Stress Test Planning

### 5.1 Negative Tests

List and describe negative/error tests:

| Test ID | Name                     | Negative Scenario Type        | Expected Behavior / Checks                   |
|--------:|--------------------------|-------------------------------|----------------------------------------------|
| ERR_001 | overflow_error_test      | Write when FIFO is full       | Overflow flag set, flag remains sticky, no data corruption |
| ERR_002 | underflow_error_test     | Read when FIFO is empty       | Underflow flag set, flag remains sticky, no invalid data |
| ERR_003 | overflow_underflow_test  | Combined overflow/underflow   | Both flags set independently, sticky behavior verified |
| ERR_004 | protocol_violation_test  | Ready/valid protocol violations| Flags set appropriately, no undefined behavior |
| ERR_005 | flag_sticky_test         | Flag persistence until reset  | Flags remain set through normal operations, cleared only on reset |
| ERR_006 | illegal_state_test       | Illegal state transitions      | Graceful handling, flags set, no data corruption |

### 5.2 Stress and Long-Run Tests

Plan stress tests for sustained or extreme usage:

| Test ID | Name                     | Stress Type                   | Duration / Load Level       | Notes      |
|--------:|--------------------------|-------------------------------|-----------------------------|------------|
| STR_001 | backpressure_source_test | Sustained backpressure from sink | 10-30 minutes, sink 10x slower | High fill level |
| STR_002 | backpressure_sink_test   | Sustained backpressure from source | 10-30 minutes, source 10x slower | Low fill level |
| STR_003 | stress_full_empty_test   | Rapid full/empty alternation  | 15-30 minutes, 1000+ cycles | Boundary stress |
| STR_004 | random_data_patterns_test| Constrained-random patterns   | 20-40 minutes, 10K+ transactions | Wide exploration |
| STR_006 | long_duration_test       | Extended duration random      | 30-60 minutes, 50K+ transactions | Stability |
| STR_007 | high_throughput_test     | Maximum throughput            | 15-30 minutes, minimal gaps | Performance stress |
| STR_008 | near_full_stress_test    | Sustained near-full operation | 20-40 minutes, 95%+ occupancy | Boundary stress |
| STR_009 | near_empty_stress_test   | Sustained near-empty operation| 20-40 minutes, <5% occupancy | Boundary stress |
| STR_010 | random_reset_test        | Random reset injection         | 15-30 minutes, 100+ resets | Reset robustness |
| STR_011 | mixed_backpressure_test  | Mixed backpressure patterns   | 20-40 minutes, varied patterns | Complex scenario |
| STR_012 | extreme_burst_test       | Very long bursts              | 15-30 minutes, bursts up to DEPTH*2 | Burst stress |
| STR_013 | coverage_closure_test    | Coverage-driven random        | 30-60 minutes, targeted bins | Coverage closure |

## 6. Seed and Randomness Policy

### 6.1 Seed Strategy

Document how you will handle seeds:

- Which tests use **fixed seeds** (for reproducible regression).  
- Which tests use **varying seeds** (for wider exploration).  
- How seeds are passed (plusargs, env vars, config file, etc.).

Example table:

| Test ID | Seed Policy        | Mechanism (plusarg/env/config) | Notes |
|--------:|--------------------|---------------------------------|-------|
| SMK_001-SMK_003 | fixed (1001-1003) | `+UVM_SEED=<test_id>`           | Deterministic smoke tests |
| FTR_001-FTR_013 | fixed (2001-2013) | `+UVM_SEED=<test_id>`           | Deterministic feature tests |
| ERR_001-ERR_006 | fixed (3001-3006) | `+UVM_SEED=<test_id>`           | Deterministic error tests |
| STR_001-STR_013 | varied             | `+UVM_SEED=<seed>` or random   | Random stress tests, seed logged |
| PERF_001-PERF_003 | fixed (4001-4003) | `+UVM_SEED=<test_id>`           | Deterministic performance tests |
| Default (if not specified) | random | System time or random generator | Seed logged in test log |

### 6.2 Reproducibility

Define expectations for:

- How to capture failing seeds (logs, CI artifacts).  
- How to reproduce failures locally.  
- How long to keep known-bad seeds around for regression.

## 7. Mapping to Regression Tiers

Summarize the mapping between tests and tiers (can be a view of your main catalogue).

| Tier   | Included Test Types           | Example Tests (IDs)      | Approx. Count | Target Runtime |
|--------|------------------------------|--------------------------|---------------|----------------|
| SANITY | Smoke + a few key features   | SMK_001, SMK_002, SMK_003 | 3            | < 5 minutes    |
| CORE   | Most feature + some error    | FTR_001-FTR_013, ERR_001-ERR_006 | 19 | < 2 hours      |
| STRESS | Stress + long negative       | STR_001-STR_012, PERF_001-PERF_003 | 15 | < 4 hours      |
| FULL   | All of the above             | All tests including STR_013 | 38 | < 8 hours      |

## 8. Open Issues and Actions

Use this section to track unresolved questions and follow-ups around test planning.

- Open questions:  
  - Should performance tests (PERF_*) be part of CORE tier for regular monitoring, or kept only in STRESS/FULL?
  - Decision: Keep in STRESS tier initially; move to CORE if performance regressions become frequent.
  - Are there additional edge cases for very small DEPTH (DEPTH=2, DEPTH=4) that need explicit tests?
  - Decision: Covered by FTR_008 (depth_variation_test) with parameterization.
- Action items:  
  - Implement UVM test classes for all 38 tests (AI-1).
  - Create sequences for each test category (AI-2).
  - Establish seed logging and reproducibility mechanism (AI-3).
  - Validate runtime estimates after initial implementation runs (AI-4).

### 8.1 Review Record

- **Review date**: 2026-02-03  
- **Review type**: Self-review (peer/mentor review optional for solo work).  
- **Outcome**: Test taxonomy, tiers, and 38-test catalogue aligned with Module 1 verification plan and requirements matrix.  
- **Identified issues and actions**: Captured in Section 8 (Open Issues and Actions) above; no blocking issues. Ready to proceed to Module 3 coverage measurement and analysis.

## 9. Revision History

| Date       | Version | Author | Changes                         |
|-----------|---------|--------|---------------------------------|
| 2026-02-03| 0.1     | Yongfu | Initial draft                   |
| 2026-02-03| 0.2     | Yongfu | Expanded test catalogue to 38 tests, completed all items |
| 2026-02-03| 0.3     | Yongfu | Added review record (Section 8.1) |


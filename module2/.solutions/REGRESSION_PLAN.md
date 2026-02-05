# Regression Plan (Module 2)

> **Purpose**: Define initial regression tiers, policies, and test-to-tier mapping.  
> **Module**: 2 – Test Planning & Strategy in Depth (SV/UVM)

## 1. Regression Goals

- **Primary goals**:
  - Detect regressions quickly on mainline branches through fast per-commit sanity checks.
  - Keep nightly regressions within 2 hours to provide timely feedback for development.
  - Provide enough depth to support coverage and sign-off goals through comprehensive weekly runs.
  - Maintain regression stability with <5% flake rate across all tiers.  

## 2. Regression Tiers

Define each tier’s purpose, content, and cadence.

| Tier   | Purpose                                 | Typical Contents                         | Cadence          | Target Runtime |
|--------|-----------------------------------------|------------------------------------------|------------------|----------------|
| SANITY | Fast health checks                      | Smoke tests, very short feature tests   | per-commit       | < 5 minutes    |
| CORE   | Main functional/regression guardrail    | Key feature + negative tests            | nightly          | < 2 hours      |
| STRESS | Stability and corner-case exploration   | Stress + long-run + heavy random tests  | weekly / on-demand | < 4 hours   |
| FULL   | Comprehensive pre-signoff/regression    | All tests, including experimental       | ad-hoc / release | < 8 hours      |

Adjust tier names/definitions for your environment as needed.

## 3. Test Assignment to Tiers

Summarize how tests from your catalogue (see `test_plan.md`) map into tiers.

| Test ID | UVM Test Name         | Type      | Primary Tier | Additional Tier(s) | Notes |
|--------:|-----------------------|-----------|-------------:|--------------------:|-------|
| SMK_001 | smoke_basic_test      | smoke     | SANITY       | CORE                | Foundation |
| SMK_002 | smoke_reset_test      | smoke     | SANITY       | CORE                | Reset check |
| SMK_003 | smoke_empty_full_test | smoke     | SANITY       | CORE                | Boundary sanity |
| FTR_001 | fifo_boundary_test    | feature   | CORE         | FULL                | Critical feature |
| FTR_002 | fifo_simultaneous_test| feature   | CORE         | FULL                | Critical feature |
| FTR_003 | fifo_level_tracking_test| feature | CORE         | FULL                | Feature coverage |
| FTR_004 | fifo_burst_transfer_test| feature | CORE         | FULL                | Feature coverage |
| FTR_005 | fifo_single_entry_test| feature   | CORE         | FULL                | Edge case |
| FTR_006 | fifo_wrap_around_test | feature   | CORE         | FULL                | Pointer logic |
| FTR_007 | fifo_data_width_test  | feature   | CORE         | FULL                | Parameterization |
| FTR_008 | fifo_depth_variation_test| feature | CORE         | FULL                | Parameterization |
| FTR_009 | fifo_rapid_toggle_test| feature   | CORE         | FULL                | State transitions |
| FTR_010 | fifo_level_accuracy_test| feature | CORE         | FULL                | Level verification |
| FTR_011 | fifo_occupancy_states_test| feature | CORE         | FULL                | Coverage driver |
| FTR_012 | fifo_op_combinations_test| feature | CORE         | FULL                | Coverage driver |
| FTR_013 | fifo_flag_combinations_test| feature | CORE         | FULL                | Flag coverage |
| ERR_001 | overflow_error_test   | error     | CORE         | FULL                | Error injection |
| ERR_002 | underflow_error_test  | error     | CORE         | FULL                | Error injection |
| ERR_003 | overflow_underflow_test| error     | CORE         | FULL                | Combined errors |
| ERR_004 | protocol_violation_test| error     | CORE         | FULL                | Protocol checks |
| ERR_005 | flag_sticky_test      | error     | CORE         | FULL                | Flag behavior |
| ERR_006 | illegal_state_test   | error     | CORE         | FULL                | State machine |
| STR_001 | backpressure_source_test| stress   | STRESS       | FULL                | Stress scenario |
| STR_002 | backpressure_sink_test| stress    | STRESS       | FULL                | Stress scenario |
| STR_003 | stress_full_empty_test| stress    | STRESS       | FULL                | Boundary stress |
| STR_004 | random_data_patterns_test| stress  | STRESS       | FULL                | Random exploration |
| STR_005 | concurrent_ops_test  | stress    | STRESS       | FULL                | Concurrent ops |
| STR_006 | long_duration_test    | stress    | STRESS       | FULL                | Stability |
| STR_007 | high_throughput_test | stress    | STRESS       | FULL                | Performance stress |
| STR_008 | near_full_stress_test| stress    | STRESS       | FULL                | Boundary stress |
| STR_009 | near_empty_stress_test| stress   | STRESS       | FULL                | Boundary stress |
| STR_010 | random_reset_test    | stress    | STRESS       | FULL                | Reset robustness |
| STR_011 | mixed_backpressure_test| stress  | STRESS       | FULL                | Complex scenario |
| STR_012 | extreme_burst_test   | stress    | STRESS       | FULL                | Burst stress |
| STR_013 | coverage_closure_test| stress    | FULL         |                     | Coverage closure |
| PERF_001 | throughput_measurement_test| performance | STRESS | FULL                | Performance |
| PERF_002 | latency_analysis_test| performance | STRESS       | FULL                | Performance |
| PERF_003 | sustained_rate_test  | performance | STRESS       | FULL                | Performance |

Guidelines:

- SANITY tier should remain **small and very fast**.  
- CORE tier should contain the majority of your **feature coverage**.  
- STRESS tier should be **selective**, focusing on high-risk areas.  
- FULL tier may be large and long-running; run less frequently.

## 4. Runtime Budgeting

Estimate runtimes and ensure tiers fit within acceptable bounds.

### 4.1 Per-Test Estimates

| Test ID | Runtime Estimate (min) | Notes                         |
|--------:|------------------------|------------------------------|
| SMK_001 | 0.5                   | Quick smoke test              |
| SMK_002 | 0.5                   | Quick reset test              |
| SMK_003 | 0.5                   | Quick boundary test           |
| FTR_001-FTR_013 | 2-5 each            | Feature tests vary by complexity |
| ERR_001-ERR_006 | 2-4 each            | Error tests with setup        |
| STR_001-STR_012 | 10-30 each          | Stress tests vary by duration |
| STR_013 | 30-60                | Extended coverage closure     |
| PERF_001-PERF_003 | 15-30 each         | Performance measurement       |

### 4.2 Tier Totals

| Tier   | Number of Tests | Aggregate Runtime (approx) | Within Target? (Y/N) | Notes |
|--------|-----------------|----------------------------|----------------------|-------|
| SANITY | 3               | ~1.5 minutes               | Y                    | Well within 5 min target |
| CORE   | 19              | ~60-90 minutes             | Y                    | Within 2 hour target |
| STRESS | 15              | ~3-4 hours                 | Y                    | Within 4 hour target |
| FULL   | 38              | ~6-8 hours                 | Y                    | Within 8 hour target |

If a tier exceeds its runtime target, note which tests could be:

- Moved to a slower tier.  
- Split into shorter variants.  
- Optimized (e.g., fewer iterations, smaller data sets).

## 5. Pass/Fail, Flakes, and Quarantine (Planning-Level)

### 5.1 Pass/Fail Rules

Define high-level rules:

- A **regression pass** means:
  - No failing tests in SANITY or CORE tiers.  
  - Flake policy is satisfied (see below).  
  - All high-priority requirements (R1, R2, R3) have at least one passing test.
- **Allowed failures** (if any) and their handling:
  - Known-bad tests quarantined and not counted in pass/fail determination.
  - Quarantined tests documented with issue tracking ID and expected fix date.
  - STRESS tier failures are warnings but don't block development; investigate within 48 hours.
  - FULL tier failures are informational; address before sign-off milestone.  

### 5.2 Flake Policy

Plan how to handle flaky tests (non-deterministic failures):

- Criteria for labeling a test as **flaky**.  
- Short-term handling (e.g., quarantine, rerun logic).  
- Long-term handling (e.g., test redesign, environmental fixes).

Document initial thoughts:

- **Criteria for labeling a test as flaky**:
  - Test fails intermittently (<50% failure rate) with same seed and environment.
  - Failure is non-deterministic and not reproducible consistently.
  - Root cause is environmental (timing, race conditions) rather than design bug.
- **Short-term handling**:
  - Quarantine flaky test after 3+ intermittent failures.
  - Rerun failed tests once automatically before marking as failure.
  - Log seed and environment details for analysis.
- **Long-term handling**:
  - Redesign test to reduce non-determinism (e.g., add explicit synchronization).
  - Fix environmental issues (timing constraints, race conditions).
  - Consider converting to deterministic directed test if randomness not essential.
  - Target: <5% flake rate across all tiers.

### 5.3 Quarantine and Waivers

Decide how you will:

- Quarantine problematic tests (while keeping visibility).  
- Track waivers for known issues.  
- Reflect quarantined/waived items in sign-off discussions.

## 6. CI / Automation Considerations

Describe how you intend to integrate regressions with CI or farm infrastructure:

- Which tiers run:
  - On developer machines.  
  - On CI (per-push, per-PR, nightly).  
  - On dedicated farms/servers.  
- Any environment-specific constraints:
  - License limits, farm queue behavior, resource caps, etc.

Summarize:

- **SANITY tier**:
  - Runs on developer machines before commit (pre-commit hook optional).
  - Runs on CI per-push/PR for fast feedback.
  - No license constraints (quick tests).
  - Expected runtime: <5 minutes, suitable for interactive use.
- **CORE tier**:
  - Runs on CI nightly (scheduled job).
  - Can run on developer machines but may take 1-2 hours.
  - May require simulator licenses; plan for 2-4 concurrent runs.
  - Results reported via CI dashboard and email notifications.
- **STRESS tier**:
  - Runs on dedicated farm/servers weekly (scheduled).
  - On-demand runs for milestone validation.
  - Requires simulator licenses; plan for 4-8 concurrent runs.
  - Results aggregated and reported weekly.
- **FULL tier**:
  - Runs on dedicated farm/servers ad-hoc (pre-release, milestone).
  - Requires full simulator license allocation.
  - Results reported with coverage metrics for sign-off review.
- **Environment constraints**:
  - Simulator license limits: plan for 4-8 concurrent runs max.
  - Farm queue behavior: STRESS/FULL may queue during peak hours.
  - Resource caps: Monitor memory/disk usage for long-running tests.

## 7. Monitoring and Reporting

Decide what you want to see from regression dashboards:

- Key metrics:
  - Pass/fail counts by tier.  
  - Flake rate.  
  - Average runtimes.  
  - Test-level failure history.  
- Preferred views:
  - Per-branch, per-commit, per-build.  
  - Per-feature or per-requirement group.

Optional: sketch a simple example of a regression report layout you’d like.

## 8. Open Items

Track unresolved questions around regression strategy:

- Should STRESS tier failures block releases, or only CORE tier?
  - **Decision**: STRESS failures are warnings; CORE failures block releases.
- How to handle coverage regression (coverage drops between runs)?
  - **Decision**: Track coverage trends; investigate drops >2% in CORE tier.
- Should we implement automatic test retry for flaky tests?
  - **Decision**: Yes, single retry before marking as failure; log retry attempts.
- What is the policy for adding new tests to tiers?
  - **Decision**: New tests start in FULL tier; promote to CORE/STRESS after stability validation.

### 8.1 Review Record

- **Review date**: 2026-02-03  
- **Review type**: Self-review (peer/mentor review optional for solo work).  
- **Outcome**: Regression tiers (SANITY/CORE/STRESS/FULL), test-to-tier mapping, runtime budgets, and policies are consistent with test_plan.md and Module 1.  
- **Identified issues and actions**: Captured in Section 8 (Open Items) above; decisions documented. Ready for Module 3.

## 9. Revision History

| Date       | Version | Author | Changes                         |
|-----------|---------|--------|---------------------------------|
| 2026-02-03| 0.1     | Yongfu | Initial draft                   |
| 2026-02-03| 0.2     | Yongfu | Completed tier definitions, test assignments, runtime budgets, policies |
| 2026-02-03| 0.3     | Yongfu | Added review record (Section 8.1) |


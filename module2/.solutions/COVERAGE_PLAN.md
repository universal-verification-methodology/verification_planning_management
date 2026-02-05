# Coverage Plan Refinement (Module 2)

> **Purpose**: Refine your coverage model and connect it more tightly to tests and regression.  
> **Module**: 2 – Test Planning & Strategy in Depth (SV/UVM)

## 1. Context

- Base coverage concepts and high-level goals are in `module1/verification_plan.md`.  
- This document goes deeper into:
  - Functional coverage structure and ownership.  
  - Coverage–test relationships.  
  - Early coverage closure tactics.

## 2. Functional Coverage Model

### 2.1 Covergroups and Placement

List planned covergroups and where they live in the UVM env:

| Coverage ID | Location (component/file)     | Purpose / What it measures                      |
|-------------|-------------------------------|-------------------------------------------------|
| CG_LEVEL    | monitor/stream_fifo_monitor.sv | FIFO occupancy levels (empty/low/mid/high/full) |
| CG_OPS      | monitor/stream_fifo_monitor.sv | Operation types per cycle (idle/push/pop/both)  |
| CG_FLAGS    | monitor/stream_fifo_monitor.sv | Overflow/underflow flag set/clear behavior     |
| CG_BACKPRESSURE | monitor/stream_fifo_monitor.sv | Backpressure patterns (source/sink/both/none) |

### 2.2 Coverpoints and Crosses

For each key covergroup, describe major coverpoints and crosses:

- **CG_LEVEL**:
  - Coverpoints: `cp_level` = {empty (0), low (1-25%), mid (26-75%), high (76-99%), full (100%)}
  - Crosses: `level × ops` to ensure all operations at all occupancy levels
- **CG_OPS**:
  - Coverpoints: `cp_op` = {idle, push_only, pop_only, push_and_pop}
  - Crosses: `op × backpressure` to ensure operations under various backpressure scenarios
- **CG_FLAGS**:
  - Coverpoints: `cp_overflow` = {set, clear_on_reset}, `cp_underflow` = {set, clear_on_reset}
  - Crosses: `level × flags` to ensure flags only set at appropriate occupancy levels
- **CG_BACKPRESSURE**:
  - Coverpoints: `cp_backpressure` = {none, source_slow, sink_slow, both_slow}
  - Crosses: `backpressure × ops` to ensure operations under all backpressure patterns  

## 3. Code Coverage Expectations (Planning)

Describe your initial expectations for:

- **Statement/Branch**: ≥ 95% statement coverage, ≥ 90% branch coverage on stream_fifo RTL.
- **Toggle/Condition**: ≥ 85% toggle coverage on critical signals (pointers, count, flags).
- **Known Exclusions**:
  - Debug-only code paths (if any) that are not reachable in normal operation.
  - Synthesis pragmas or tool-inserted logic that is not controllable from testbench.
  - Unreachable code paths identified through static analysis (document with rationale).
  - Reset assertion paths (covered separately in reset tests).

Note: Detailed exclusion lists may be maintained in tool-specific configs; here, capture the **intent** and rationale.

## 4. Coverage Goals by Requirement / Feature

Use this section to express more concrete goals than in Module 1.

| Req/Feature ID | Description                       | Coverage Targets (func/code) | Notes |
|----------------|-----------------------------------|------------------------------|-------|
| R1             | In-order data transfer            | 100% func (CG_LEVEL, CG_OPS), ≥95% code | Critical |
| R2             | Overflow flag behavior            | 100% func (CG_FLAGS, CROSS_LEVEL_FLAGS), ≥95% code | Critical |
| R3             | Underflow flag behavior           | 100% func (CG_FLAGS, CROSS_LEVEL_FLAGS), ≥95% code | Critical |
| F1             | Boundary handling (empty/full)    | 100% func (CG_LEVEL bins), ≥95% code | High risk |
| F2             | Simultaneous push/pop             | 100% func (CG_OPS push+pop bin), ≥95% code | Medium risk |
| F3             | Backpressure scenarios            | ≥90% func (CG_BACKPRESSURE), ≥90% code | Medium risk |

Examples:

- “All legal opcodes must be hit in every operating mode.”  
- “All error conditions for FIFO overflow/underflow must be exercised at least once.”  

## 5. Coverage–Test Relationships

### 5.1 Which Tests Drive Which Coverage

Summarize the mapping (high level):  
You may mirror a more detailed per-bin mapping in `requirements_matrix.md`.

| Coverage ID | Primary Tests (IDs)          | Notes                           |
|-------------|------------------------------|---------------------------------|
| CG_LEVEL    | FTR_001, FTR_003, FTR_010, FTR_011, STR_003, STR_008, STR_009 | Occupancy state coverage |
| CG_OPS      | FTR_002, FTR_012, STR_004, STR_005 | Operation type coverage |
| CG_FLAGS    | ERR_001, ERR_002, ERR_003, ERR_005, FTR_013 | Flag behavior coverage |
| CG_BACKPRESSURE | STR_001, STR_002, STR_011 | Backpressure pattern coverage |
| CROSS_LEVEL_FLAGS | ERR_001, ERR_002, ERR_003, FTR_001 | Cross coverage for flags vs level |
| CROSS_OPS_BACKPRESSURE | STR_001, STR_002, STR_011 | Cross coverage for ops vs backpressure |

### 5.2 Planned Closure Tactics

For each coverage area, describe how you intend to close it:

- Adjust constraints / sequences?  
- Add targeted directed tests?  
- Add new coverpoints or refine bins?

Example bullets:

- **CG_LEVEL gaps**: If empty/full bins not hit, add FTR_001 (boundary test) or STR_003 (stress full/empty).
- **CG_OPS gaps**: If push+pop bin not hit, add FTR_002 (simultaneous test) or adjust sequence constraints.
- **CG_FLAGS gaps**: If overflow/underflow bins not hit, add ERR_001/ERR_002 (error injection tests).
- **CG_BACKPRESSURE gaps**: If backpressure patterns not covered, add STR_001/STR_002 (backpressure tests).
- **Cross coverage gaps**: Review cross bins; add targeted tests or adjust sequence constraints to hit missing combinations.
- **Code coverage gaps**: Review uncovered statements/branches; add directed tests or adjust random constraints to exercise missing paths.
- **General closure**: Run STR_013 (coverage_closure_test) with targeted constraints to hit remaining bins.

## 6. Coverage in Regression Tiers

Decide how you will **observe and act on coverage** in each tier:

- SANITY:
  - Expected coverage focus: smoke/sanity bins only.  
  - Use for trend sanity, not for closure.  
- CORE:
  - Main functional coverage driver.  
  - Use as primary coverage dashboard.  
- STRESS/FULL:
  - Additional corner/stress coverage.  
  - Useful for discovering gaps not visible in CORE.

Summarize:

- **SANITY tier**:
  - Expected coverage focus: Basic bins only (empty, full, push, pop, basic flags).
  - Use for trend sanity, not for closure.
  - Coverage reporting: Summary only, no detailed analysis.
- **CORE tier**:
  - Main functional coverage driver.
  - Use as primary coverage dashboard.
  - Coverage reporting: Detailed report with bin-level analysis.
  - Target: ≥90% functional coverage, ≥95% code coverage.
- **STRESS tier**:
  - Additional corner/stress coverage.
  - Useful for discovering gaps not visible in CORE.
  - Coverage reporting: Detailed report, focus on uncovered bins.
  - Target: Fill remaining coverage gaps.
- **FULL tier**:
  - Comprehensive coverage closure.
  - All coverage goals must be met or waived.
  - Coverage reporting: Complete report with waiver documentation.
  - Target: 100% functional coverage (or waived), ≥95% code coverage (or waived).

## 7. Early Gap Analysis Workflow (Planning)

Define a lightweight process you will follow once you start collecting coverage:

1. Run a baseline regression (e.g., CORE tier).  
2. Export coverage report from your simulator/tool.  
3. Identify:
   - Completely unhit covergroups/coverpoints.  
   - Partially hit but important bins.  
4. For each gap, decide:
   - Add/modify tests.  
   - Adjust constraints.  
   - Waive (with justification).  
5. Update:
   - This coverage plan (if structural changes).  
   - `test_plan.md` and `requirements_matrix.md` (if test-level changes).  

## 8. Open Questions

List any unresolved coverage-related questions:

- Should coverage be tracked per-commit or only in nightly runs?
  - **Decision**: Track coverage trends in nightly CORE runs; detailed analysis in FULL tier.
- How to handle coverage waivers (unreachable bins)?
  - **Decision**: Document waivers in coverage plan with rationale; review during sign-off.
- What is the policy for coverage regression (coverage drops)?
  - **Decision**: Investigate coverage drops >2% in CORE tier; require explanation and fix plan.
- Should we implement coverage-driven test generation?
  - **Decision**: Use STR_013 (coverage_closure_test) with targeted constraints; consider formal tools if gaps persist.

## 9. Revision History

| Date       | Version | Author | Changes                         |
|-----------|---------|--------|---------------------------------|
| 2026-02-03| 0.1     | Yongfu | Initial draft                   |
| 2026-02-03| 0.2     | Yongfu | Completed covergroup definitions, coverage-test mappings, closure tactics |


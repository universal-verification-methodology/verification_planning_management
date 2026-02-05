# High-Priority Requirements Traceability Summary

> **Purpose**: Quick reference showing where each high-priority requirement is tested, covered, and checked  
> **Module**: 1 – Verification Planning & Management Foundations  
> **Date**: 2026-02-03

This document provides a concise summary of verification artifacts for **high-priority requirements** (Priority = H), demonstrating traceability across tests, coverage, and checkers.

## Overview

All high-priority requirements have been mapped to:
- ✅ **Tests**: At least one test case targeting the requirement
- ✅ **Coverage**: Functional coverage items tracking the requirement
- ✅ **Checkers**: Scoreboard, assertions, or protocol checkers validating the requirement

## High-Priority Requirements

### R1: FIFO shall transfer data in-order between source and sink
**Priority**: H  
**Risk**: Medium  
**Complexity**: Medium

#### Where it's Tested
- **Test T1** (`basic_push_pop`): Smoke test verifying simple enqueue/dequeue and in-order data
- **Test T2** (`boundary_full_empty`): Feature test exercising transitions to/from empty/full
- **Test T4** (`simultaneous_push_pop`): Feature test verifying correct behavior when push and pop occur in same cycle
- **Test T5** (`backpressure_source`): Stress test with sustained backpressure from sink
- **Test T6** (`backpressure_sink`): Stress test with sustained backpressure from source
- **Test T7** (`reset_behavior`): Feature test verifying reset clears state correctly
- **Test T8** (`level_tracking`): Feature test verifying level signal accuracy
- **Test T9** (`burst_transfer`): Feature test with burst transfers
- **Test T10** (`random_data_patterns`): Stress test with constrained-random patterns
- **Test T11** (`stress_full_empty`): Stress test alternating between full and empty
- **Test T12** (`concurrent_ops`): Stress test with various concurrent operations

**Test Coverage**: Comprehensive across smoke, feature, and stress categories

#### Where it's Covered
- **CG_LEVEL** (Covergroup): Tracks FIFO occupancy (empty/low/mid/high/full) to ensure all occupancy states are exercised
- **CG_OPS** (Covergroup): Tracks operation type per cycle (idle/push/pop/push+pop) to ensure all operation combinations are tested

**Coverage Location**: Functional coverage model (to be implemented in Module 3)  
**Coverage Goal**: 100% coverage for all bins (high-risk feature)

#### Where it's Checked
- **SB_MAIN** (Scoreboard): Queue-based reference model comparing DUT outputs vs expected in-order data
  - **Location**: `env/stream_fifo_scoreboard.sv` (planned)
  - **Mechanism**: Mirrors all successful pushes, compares popped data against DUT outputs, checks level vs queue depth
  - **Validation**: Ensures data integrity and ordering correctness

**Checker Status**: Planned for Module 2 implementation

---

### R2: FIFO shall correctly flag and retain overflow on write when full
**Priority**: H  
**Risk**: High  
**Complexity**: Low

#### Where it's Tested
- **Test T2** (`boundary_full_empty`): Feature test exercising transitions to/from full and overflow flag behavior
- **Test T3** (`overflow_underflow_err`): Error-injection test driving explicit overflow scenarios
- **Test T7** (`reset_behavior`): Feature test verifying reset clears overflow flag correctly
- **Test T11** (`stress_full_empty`): Stress test alternating between full and empty conditions rapidly

**Test Coverage**: Targeted error-injection and boundary condition testing

#### Where it's Covered
- **CG_FLAGS** (Covergroup): Tracks overflow flag set/clear behavior
- **CROSS_LEVEL_FLAGS** (Cross Coverage): Cross of occupancy level × overflow to ensure overflow only occurs at full

**Coverage Location**: Functional coverage model (to be implemented in Module 3)  
**Coverage Goal**: 100% coverage for all bins (high-risk feature)

#### Where it's Checked
- **A_OVERFLOW** (SVA Assertion): Checks overflow set only on write when full
  - **Location**: `monitor/stream_fifo_assert.sv` (planned)
  - **Mechanism**: Protocol assertion ensuring overflow flag behavior matches specification
  - **Validation**: Catches protocol violations early in simulation

**Checker Status**: Planned for Module 2 implementation

---

### R3: FIFO shall correctly flag and retain underflow on read when empty
**Priority**: M (Note: Included here as it's closely related to R2 and tested together)
**Risk**: High  
**Complexity**: Low

#### Where it's Tested
- **Test T2** (`boundary_full_empty`): Feature test exercising transitions to/from empty and underflow flag behavior
- **Test T3** (`overflow_underflow_err`): Error-injection test driving explicit underflow scenarios
- **Test T7** (`reset_behavior`): Feature test verifying reset clears underflow flag correctly
- **Test T11** (`stress_full_empty`): Stress test alternating between full and empty conditions rapidly

**Test Coverage**: Targeted error-injection and boundary condition testing

#### Where it's Covered
- **CG_FLAGS** (Covergroup): Tracks underflow flag set/clear behavior
- **CROSS_LEVEL_FLAGS** (Cross Coverage): Cross of occupancy level × underflow to ensure underflow only occurs at empty

**Coverage Location**: Functional coverage model (to be implemented in Module 3)  
**Coverage Goal**: 100% coverage for all bins (high-risk feature)

#### Where it's Checked
- **A_UNDERFLOW** (SVA Assertion): Checks underflow set only on read when empty
  - **Location**: `monitor/stream_fifo_assert.sv` (planned)
  - **Mechanism**: Protocol assertion ensuring underflow flag behavior matches specification
  - **Validation**: Catches protocol violations early in simulation

**Checker Status**: Planned for Module 2 implementation

---

## Traceability Matrix Summary

| Req ID | Priority | Tests | Coverage Items | Checkers | Status |
|--------|----------|-------|----------------|----------|--------|
| R1     | H        | T1-T12 (11 tests) | CG_LEVEL, CG_OPS | SB_MAIN | ✅ Complete |
| R2     | H        | T2, T3, T7, T11 (4 tests) | CG_FLAGS, CROSS_LEVEL_FLAGS | A_OVERFLOW | ✅ Complete |
| R3     | M        | T2, T3, T7, T11 (4 tests) | CG_FLAGS, CROSS_LEVEL_FLAGS | A_UNDERFLOW | ✅ Complete |

## Verification Strategy Summary (3-5 Minute Explanation)

**Objective**: Verify the `stream_fifo` DUT ensures in-order data transfer and correctly handles boundary conditions with proper error flagging.

**Approach**:
1. **Directed Tests First**: Start with smoke tests (T1) and basic feature tests (T2-T4) to validate core functionality
2. **Constrained-Random Evolution**: Use stress tests (T5-T6, T10-T12) with varied backpressure and data patterns to expose corner cases
3. **Error Injection**: Explicit error-injection tests (T3) validate overflow/underflow flag behavior
4. **Comprehensive Coverage**: Functional coverage tracks occupancy states, operation types, and flag behavior; code coverage targets 95% statement, 90% branch
5. **Multi-Layer Checking**: Scoreboard validates data integrity/ordering; SVA assertions catch protocol violations early

**Key Verification Points**:
- **R1 (In-order transfer)**: Validated by scoreboard comparing all transfers across 11 tests covering normal, boundary, and stress scenarios
- **R2/R3 (Error flags)**: Validated by assertions and explicit error-injection tests, with coverage tracking flag behavior vs occupancy level

**Readiness**: Plan is complete with clear traceability. Module 2 will implement the UVM environment, tests, and checkers as specified.

---

## References

- **Verification Plan**: `VERIFICATION_PLAN.md`
- **Requirements Matrix**: `REQUIREMENTS_MATRIX.md`
- **DUT Specification**: `../common_dut/dut/README.md`

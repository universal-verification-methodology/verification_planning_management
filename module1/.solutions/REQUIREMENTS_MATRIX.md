# Requirements–Verification Traceability Matrix (Module 1)

> **Purpose**: Track mapping from requirements → tests → coverage items → checks  
> **Module**: 1 – Verification Planning & Management Foundations (SV/UVM)

## 1. Instructions

- Use this file to capture **traceability** between:
  - Requirements (from spec or internal doc).
  - Test cases / UVM tests / sequences.
  - Coverage points (covergroups / coverpoints / crosses).
  - Checkers (scoreboards, reference models, assertions).
- Keep IDs **stable**. Do not reuse IDs for different meanings.
- This matrix will evolve across modules; start simple in Module 1.

## 2. Requirement List

List all **requirements** with unique IDs.

| Req ID | Description                                                      | Priority (H/M/L) | Notes                          |
|--------|------------------------------------------------------------------|------------------|--------------------------------|
| R1     | FIFO shall transfer data in-order between source and sink.      | H                | Basic functional behavior      |
| R2     | FIFO shall correctly flag and retain overflow on write when full.| H               | Protocol violation detection   |
| R3     | FIFO shall correctly flag and retain underflow on read when empty.| M              | Protocol violation detection   |

## 3. Requirement → Test Mapping

Map requirements to one or more **tests**.

| Req ID | Test ID(s)              | Notes                                                   |
|--------|-------------------------|---------------------------------------------------------|
| R1     | T1, T2, T4, T5, T6, T7, T8, T9, T10, T11, T12 | Basic push/pop, boundaries, simultaneous ops, backpressure, reset, level tracking, bursts, random patterns, stress. |
| R2     | T2, T3, T7, T11        | Boundary_full_empty, overflow error, reset behavior, stress full/empty. |
| R3     | T2, T3, T7, T11        | Boundary_full_empty, underflow error, reset behavior, stress full/empty. |

## 4. Requirement → Coverage Mapping

Map requirements to **coverage items** (functional coverage preferred).

| Req ID | Coverage Item ID(s)     | Type (cg/cp/cross/code) | Notes                                      |
|--------|-------------------------|--------------------------|---------------------------|
| R1     | CG_LEVEL, CG_OPS       | cg                      | Occupancy and op-type distribution.       |
| R2     | CG_FLAGS, CROSS_LEVEL_FLAGS | cg, cross          | Overflow events vs occupancy level.       |
| R3     | CG_FLAGS, CROSS_LEVEL_FLAGS | cg, cross          | Underflow events vs occupancy level.      |

> **Tip**: Use a simple naming scheme, e.g.:
> - `CG_*` for covergroups  
> - `CP_*` for coverpoints  
> - `X_*` or `CROSS_*` for crosses

## 5. Requirement → Checkers / Assertions

Map requirements to **checkers**: scoreboards, assertions, protocol checkers, etc.

| Req ID | Checker / Assertion ID | Type (SB/A/SVA/Other) | Location (file / component) | Notes |
|--------|------------------------|------------------------|-----------------------------|-------|
| R1     | SB_MAIN                | SB                     | env/stream_fifo_scoreboard.sv | Compares DUT vs reference queue. |
| R2     | A_OVERFLOW             | A (SVA)                | monitor/stream_fifo_assert.sv | Checks overflow set only on write when full. |
| R3     | A_UNDERFLOW            | A (SVA)                | monitor/stream_fifo_assert.sv | Checks underflow set only on read when empty. |

## 6. Test Definitions (Summary)

Summarize your tests (can be copied from the plan).

| Test ID | Test Name             | Intent / Description                                   | Type  | Related Req IDs |
|--------:|-----------------------|--------------------------------------------------------|-------|-----------------|
| T1      | basic_push_pop        | Verify simple enqueue/dequeue and in-order data       | smoke | R1              |
| T2      | boundary_full_empty   | Exercise transitions to/from empty/full and flags     | feat  | R1, R2, R3      |
| T3      | overflow_underflow_err| Drive explicit overflow and underflow error scenarios | err   | R2, R3          |
| T4      | simultaneous_push_pop | Verify correct behavior when push and pop occur in same cycle | feat | R1          |
| T5      | backpressure_source   | Test sustained backpressure from sink (sink slower than source) | stress | R1      |
| T6      | backpressure_sink     | Test sustained backpressure from source (source slower than sink) | stress | R1  |
| T7      | reset_behavior        | Verify reset clears state, flags, and initializes FIFO correctly | feat | R1, R2, R3 |
| T8      | level_tracking        | Verify level signal accuracy across all occupancy states | feat | R1          |
| T9      | burst_transfer        | Test burst transfers (multiple consecutive pushes followed by pops) | feat | R1      |
| T10     | random_data_patterns  | Constrained-random test with varied data patterns and backpressure | stress | R1    |
| T11     | stress_full_empty     | Stress test alternating between full and empty conditions rapidly | stress | R1, R2, R3 |
| T12     | concurrent_ops        | Test various combinations of concurrent operations and backpressure | stress | R1    |

## 7. Coverage Item Definitions (Summary)

Provide short descriptions of coverage items.

| Coverage ID        | Description                                          | Owner | Notes |
|--------------------|------------------------------------------------------|-------|-------|
| CG_LEVEL           | FIFO occupancy (empty/low/mid/high/full)            | TBD   |       |
| CG_OPS             | Operation type per cycle (idle/push/pop/push+pop)   | TBD   |       |
| CG_FLAGS           | Overflow/underflow flag set/clear behavior          | TBD   |       |
| CROSS_LEVEL_FLAGS  | Cross of occupancy level × {overflow, underflow}    | TBD   |       |

## 8. Traceability Checklist

- [x] All **high-priority** requirements have:
  - [x] At least one **test**.  
  - [x] At least one **coverage item**.  
  - [x] At least one **checker** (scoreboard or assertion).  
- [x] All tests list the requirements they cover.  
- [x] All coverage items list the requirements they support.  
- [x] Waived or out-of-scope requirements are tagged and justified in the plan.


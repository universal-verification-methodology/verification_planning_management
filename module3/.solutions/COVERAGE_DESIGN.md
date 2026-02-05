# Coverage Design (Module 3)

> **Purpose**: Define the concrete functional coverage model (covergroups/coverpoints/crosses) and how it is integrated into your UVM environment.  
> **Module**: 3 – Coverage Planning & Analysis in Practice (SV/UVM)

## 1. Context and Scope

- **DUT**: `stream_fifo` — parameterizable streaming FIFO with ready/valid handshakes on source (push) and sink (pop) interfaces; configurable DATA_WIDTH (default 8) and DEPTH (default 16). Exposes `level`, `overflow`, and `underflow` status signals.  
- **Main interfaces / protocols**: Source (push) and sink (pop) ready/valid streaming interfaces; no address space.  
- **Reference docs**:
  - `module1/VERIFICATION_PLAN.md`  
  - `module2/COVERAGE_PLAN.md`  
  - `module1/REQUIREMENTS_MATRIX.md`

Summarize which **features/requirements** this coverage design targets first:

- **R1** (in-order transfer): Occupancy levels (CG_LEVEL), operation types (CG_OPS), and backpressure (CG_BACKPRESSURE).  
- **R2** (overflow flag): Overflow set/clear and level×overflow cross (CG_FLAGS, CROSS_LEVEL_FLAGS).  
- **R3** (underflow flag): Underflow set/clear and level×underflow cross (CG_FLAGS, CROSS_LEVEL_FLAGS).

## 2. Coverage Components and Placement

Decide where covergroups will live in your UVM environment.

| Coverage ID     | UVM Component / File           | Sampling Event             | Notes                       |
|-----------------|---------------------------------|----------------------------|-----------------------------|
| CG_LEVEL        | stream_fifo_monitor (common_dut/tb) | @(posedge vif.clk)       | FIFO occupancy levels       |
| CG_OPS          | stream_fifo_monitor             | @(posedge vif.clk)         | Operation types per cycle   |
| CG_FLAGS        | stream_fifo_monitor             | @(posedge vif.clk) or on flag change | Overflow/underflow behavior |
| CG_BACKPRESSURE | stream_fifo_monitor             | on transaction boundary    | Backpressure patterns       |

For each component, note:

- **Data source**: Monitor observes `vif` (source/sink valid/ready) and DUT outputs `level`, `overflow`, `underflow`. Sampling on posedge clk when at least one handshake occurs, or on transaction end.  
- **Shared trigger**: CG_LEVEL, CG_OPS, and CG_FLAGS can share `@(posedge vif.clk)`; CG_BACKPRESSURE can sample at transaction end to avoid double-counting.

## 3. Covergroup Specifications

For each major coverage area, define the covergroup and its key coverpoints/crosses.

### 3.1 Operations Coverage (`CG_OPS`)

**Goal**: Ensure all relevant operation types per cycle are exercised.

- **Covergroup**: `covergroup cg_ops @(posedge vif.clk);`  
- **Coverpoints** (conceptual; actual SV code in `common_dut/tb/`):
  - `cp_op_type`: idle / push_only / pop_only / push_and_pop (same-cycle push and pop).  
  - No `cp_size` for this FIFO (single data beat per cycle); burst length covered by sequences.  
- **Crosses**:
  - `cp_op_type × cp_backpressure` (in CG_BACKPRESSURE cross) — see Section 3.4.  

**Requirements covered**: R1.

### 3.2 Occupancy / Level Coverage (`CG_LEVEL`)

**Goal**: Hit all occupancy levels and boundary conditions (empty, full, and bands in between).

- **Covergroup**: `covergroup cg_level @(posedge vif.clk);`  
- **Coverpoints**:
  - `cp_level`: bins for empty (0), low (1 to 25% of DEPTH), mid (26–75%), high (76–99%), full (DEPTH).  
  - `cp_boundary`: bins for level==0, level==1, level==DEPTH-1, level==DEPTH.  
- **Crosses**:
  - `cp_level × cp_op_type` (CROSS_LEVEL_OPS) — ensure all operations at all occupancy levels.  

**Requirements covered**: R1, R2, R3 (boundary behavior for flags).

### 3.3 Backpressure Coverage (`CG_BACKPRESSURE`)

**Goal**: Ensure tests exercise relevant backpressure patterns (source/sink/both/none).

- **Covergroup**: `covergroup cg_backpressure` — sample on transaction end or on sampling event.  
- **Coverpoints**:
  - `cp_backpressure`: none / source_slow (s_ready=0) / sink_slow (m_ready=0) / both_slow.  
  - Optionally `cp_fill_level_at_end`: empty / low / mid / high / full at transaction end.  
- **Crosses**:
  - `cp_backpressure × cp_op_type` (if both sampled at same granularity).  

**Requirements covered**: R1.

### 3.4 Error / Status Coverage (`CG_FLAGS`)

**Goal**: Exercise overflow and underflow flag set/clear and their relationship to level.

- **Covergroup**: `covergroup cg_flags @(posedge vif.clk);` or on flag transition.  
- **Coverpoints**:
  - `cp_overflow`: { set, clear_on_reset }.  
  - `cp_underflow`: { set, clear_on_reset }.  
  - `cp_level_at_overflow`: level when overflow is set (e.g., full).  
  - `cp_level_at_underflow`: level when underflow is set (e.g., empty).  
- **Crosses**:
  - `cp_level × cp_overflow` (CROSS_LEVEL_FLAGS) — overflow only when full.  
  - `cp_level × cp_underflow` (CROSS_LEVEL_FLAGS) — underflow only when empty.  

**Requirements covered**: R2, R3.

Add additional coverage groups as needed for your DUT (e.g., performance, latency buckets, QoS levels).

## 4. Sampling Strategy and Performance Considerations

Describe **when** and **how often** covergroups will sample:

- **Sampling**: On every posedge clk where at least one of (s_valid&s_ready, m_valid&m_ready) is true, to avoid sampling idle cycles excessively. Optionally sample CG_LEVEL/CG_OPS every cycle if DEPTH is small and cost is acceptable.  
- **Transaction-level**: CG_BACKPRESSURE can sample once per transaction (e.g., when a push or pop transaction completes) to characterize backpressure over the transaction.  
- **Avoid**: Double-counting same event in multiple covergroups; sampling uninitialized or X state (sample after reset deassertion).

Document decisions:

- CG_LEVEL, CG_OPS, CG_FLAGS sample on `@(posedge vif.clk)` when `rst_n` is high.  
- CG_BACKPRESSURE samples at end of each push or pop transaction (driver/monitor boundary).  
- No sampling in reset; ignore_bins or disable during reset if needed.

If there are performance concerns:

- For large DEPTH or long runs, consider sampling CG_LEVEL every N cycles or only on level change.  
- Enable/disable CG_BACKPRESSURE per test tier (e.g., STRESS only) if needed.

## 5. Integration Hooks in UVM Environment

For each coverage area, specify:

- **Instantiation**: In `stream_fifo_monitor` (or a dedicated `stream_fifo_coverage` component that receives analysis traffic from the monitor).  
- **Connection**: Monitor has virtual interface to DUT; it drives `cg_level.sample()`, `cg_ops.sample()`, `cg_flags.sample()` with `level`, `overflow`, `underflow`, and derived `op_type`/`backpressure` from vif.  
- **Configuration**: Coverage enable/disable via UVM config or plusarg (e.g., `+COVERAGE=1`); no per-bin enable for initial implementation.

Example (conceptual):

- `stream_fifo_monitor.sv` (or `stream_fifo_coverage.sv`):
  - Instantiate `cg_level`, `cg_ops`, `cg_flags`, `cg_backpressure`.  
  - In `run_phase`, on posedge clk sample level/op/flags; on transaction end sample backpressure.  
- Optionally `scoreboard.sv`: sample `cg_flags` on error events if flag transitions are detected there.

Fill in your specifics:

- Covergroups are implemented in `common_dut/tb/stream_fifo_coverage.sv`, instantiated inside `stream_fifo_monitor` or as a sibling component that receives analysis export from the monitor. Coverage IDs and file locations are captured in this document (Section 2).

## 6. Coverage–Requirements Mapping

Tie coverage items back to requirements (also update `module1/REQUIREMENTS_MATRIX.md`).

| Coverage ID        | Req ID(s) | Notes                                |
|--------------------|-----------|--------------------------------------|
| CG_LEVEL           | R1, R2, R3| Occupancy and boundary behavior      |
| CG_OPS             | R1        | All operation types per cycle        |
| CG_FLAGS           | R2, R3    | Overflow/underflow set/clear         |
| CG_BACKPRESSURE    | R1        | Backpressure patterns                |
| CROSS_LEVEL_FLAGS  | R2, R3    | Flags only at correct level          |
| CROSS_LEVEL_OPS    | R1        | Ops at all levels                    |

Add or refine this table as your coverage model evolves.

## 7. Early Closure Strategy

Describe how you plan to **close** each coverage area:

- **CG_LEVEL**: Random sequences with varied push/pop counts; directed tests FTR_001, FTR_010, FTR_011 for boundary levels; stress tests STR_008, STR_009 for sustained near-full/near-empty.  
- **CG_OPS**: FTR_002 (simultaneous push/pop), FTR_012 (op combinations); random sequences with unconstrained valid/ready to hit idle/push/pop/both.  
- **CG_FLAGS**: ERR_001, ERR_002, ERR_003, ERR_005 (overflow/underflow/sticky); FTR_001 boundary tests.  
- **CG_BACKPRESSURE**: STR_001, STR_002, STR_011 (source/sink/mixed backpressure); constraint adjustments to hold s_ready or m_ready low for multiple cycles.

Note any **known unreachable bins** and plan to:

- Mark as `ignore_bins` with comment (e.g., illegal op combinations if any).  
- Document for waivers if tool or design restricts certain combinations.

## 8. Open Questions and Future Extensions

Track any unresolved design decisions:

- **Additional coverage**: Latency (cycles from push to pop) or throughput buckets can be added in a later iteration.  
- **Tool limits**: Large crosses (e.g., level × op × backpressure) may be split or sampled less frequently if report size or runtime is an issue.  
- **Module 4**: Protocol checkers and scoreboard can feed coverage (e.g., error coverage on checker events).

List open items:

- None blocking. Optional: add coverpoint for DATA_WIDTH/DEPTH parameterization (different configs) in a future run.

## 9. Revision History

| Date       | Version | Author | Changes                         |
|------------|---------|--------|---------------------------------|
| 2026-02-05 | 0.1     | Yongfu | Initial coverage design for stream_fifo (CG_LEVEL, CG_OPS, CG_FLAGS, CG_BACKPRESSURE); aligned with module2 coverage plan |

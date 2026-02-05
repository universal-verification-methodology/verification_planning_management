# Checker, Scoreboard & Assertion Plan (Module 4)

> **Purpose**: Define the functional checking strategy for the DUT: scoreboards, reference models, and assertions.  
> **Module**: 4 – UVM Environment & Checker Maturity (SV/UVM)

## 1. Context

- **DUT**: `stream_fifo` — parameterizable streaming FIFO with ready/valid handshakes; status signals level, overflow, underflow.  
- **Key correctness concerns**: In-order data transfer (R1); overflow flag set only on write when full and sticky until reset (R2); underflow flag set only on read when empty and sticky until reset (R3).  
- **Related documents**:
  - `module1/VERIFICATION_PLAN.md` (requirements and success criteria).  
  - `module2/TEST_PLAN.md` (test intents).  
  - `module3/COVERAGE_DESIGN.md` (coverage model).  

Summarize the **overall checking philosophy** (e.g., "assertions for protocol safety, scoreboards for functional correctness"):

- **Assertions** for protocol and safety: valid/ready handshake rules; overflow/underflow set only at correct level.  
- **Scoreboard** for functional correctness: compare popped data (from monitor) with expected order (reference queue).  
- **Reference model**: Internal FIFO queue (push on source beat, pop expected on sink beat); scoreboard uses it to check ordering.  

## 2. Scoreboards and Reference Models

### 2.1 Scoreboards

List each scoreboard and what it checks.

| Scoreboard ID   | Component/Class         | Inputs (analysis ports/streams)          | Purpose                                      | Notes |
|-----------------|-------------------------|-------------------------------------------|----------------------------------------------|-------|
| SB_MAIN         | `stream_scoreboard`     | stream_item from sink-side monitor        | In-order data correctness (popped data vs expected queue) | Single scoreboard for stream_fifo |

For each scoreboard, document:

- **Matching strategy**: Order-based. Expected queue is FIFO: push expected data when driver sends (or when sequence is known); pop expected when monitor reports sink transaction; compare monitor data with queue front.  
- **Data structures**: Queue (or mailbox) of expected data (e.g., `logic [DATA_WIDTH-1:0] expected_q[$]`).  
- **Mismatch**: If popped data ≠ expected front, report error (e.g., `uvm_error`) and optionally dump expected vs actual.  

Details:

- Current `stream_scoreboard` in module4/tb/stream_pkg.sv counts transactions only; full compare requires expected queue populated from sequence/driver side (e.g., analysis export from driver or mirror of sequence items).  

### 2.2 Reference Models

List reference models and their abstraction level.

| Ref Model ID   | Implementation (SV/SystemVerilog or external) | Abstraction Level (cycle/transaction/algorithmic) | Used By (scoreboards/tests) | Notes |
|----------------|-----------------------------------------------|---------------------------------------------------|------------------------------|-------|
| RM_MAIN        | Internal to stream_scoreboard (queue)         | Transaction (one expected value per pop)          | SB_MAIN                      | Queue: push on expected push, pop on monitor pop; compare. |

For each reference model, define:

- **Inputs**: Expected data from sequence/driver (e.g., analysis port from driver or from test that mirrors sequence items).  
- **Outputs**: Expected value for next pop; scoreboard compares with monitor transaction.  
- **Assumptions**: Perfect handshake (no protocol violations in ref model); backpressure only delays transactions, does not change order.  

## 3. Assertions and Protocol/Functional Checkers

### 3.1 Assertion Inventory

List key assertions by ID, intent, and location.

| Assertion ID   | Intent / Property Description                     | Location (file/module)      | Type (safety/liveness/protocol/functional) | Related Req IDs | Notes |
|----------------|---------------------------------------------------|-----------------------------|---------------------------------------------|-----------------|-------|
| A_HANDSHAKE_SRC | Source: valid may not depend on ready in illegal way; ready from DUT | common_dut/tb or bind to stream_fifo | protocol/safety                            | R1              | Valid/ready handshake |
| A_HANDSHAKE_SNK | Sink: ready from TB; valid from DUT              | common_dut/tb or bind       | protocol/safety                            | R1              | Handshake |
| A_OVERFLOW     | Overflow flag set only when s_valid=1 and FIFO full (s_ready=0) | DUT or bind                | safety/functional                           | R2              | No overflow without flag |
| A_UNDERFLOW    | Underflow flag set only when m_ready=1 and FIFO empty (m_valid=0) | DUT or bind                | safety/functional                           | R3              | No underflow without flag |
| A_LEVEL_CONSIST | level matches count of entries (optional)        | DUT or bind                | functional                                  | R1              | Consistency |

Extend this table as needed.

### 3.2 Assertion Placement Strategy

Describe where assertions live and why:

- **Interface-level**: In or bound to `stream_if` or DUT: handshake rules (valid/ready), overflow/underflow conditions.  
- **Internal**: If RTL is instrumented, level consistency; otherwise bind to DUT ports.  
- **Monitor-based**: Optional procedural checks in monitor (e.g., flag sampling) for coverage; primary checks are SVA.  

Document decisions:

- Place A_OVERFLOW, A_UNDERFLOW in a bind file (e.g., `stream_fifo_asserts.sv`) bound to `stream_fifo` so they see s_valid, s_ready, m_valid, m_ready, level, overflow, underflow.  
- Handshake assertions can live in interface or bind.  

### 3.3 Assertion Enablement & Control

Plan how to enable/disable or configure assertions:

- **Global**: Simulator +define or plusarg to enable/disable assertion block.  
- **Tier**: Full set in CORE/STRESS; optional reduced set in SANITY for speed.  
- **Plusargs**: e.g., `+ASSERT_OFF` to disable, or `+SEVERITY_OVF=warning` for early bring-up.  

Document key controls:

- Default: all assertions on. Optional: `+DISABLE_ASSERTIONS` to turn off for long stress runs if needed.  

## 4. Relationship to Tests and Coverage

### 4.1 Requirements → Checks Mapping

Map high-priority requirements to their checks (also see `requirements_matrix.md`).

| Req ID | Scoreboard(s)      | Assertion(s)      | Notes                             |
|--------|--------------------|-------------------|-----------------------------------|
| R1     | SB_MAIN            | A_HANDSHAKE_*     | In-order transfer; handshake      |
| R2     | (SB_MAIN overflow check optional) | A_OVERFLOW  | Overflow flag behavior             |
| R3     | (SB_MAIN underflow check optional) | A_UNDERFLOW | Underflow flag behavior            |

Ensure no important requirement relies **only** on unasserted "visual inspection."

### 4.2 Checks and Coverage

Identify where checks and coverage interact:

- **Coverage when checks pass**: Functional coverage (CG_LEVEL, CG_OPS, CG_FLAGS) is meaningful when assertions are enabled; failures should not be counted as coverage success.  
- **Assertion coverage**: Tool-specific; A_OVERFLOW/A_UNDERFLOW can be tied to coverage bins (e.g., flag set).  
- **Scoreboard**: Error/mismatch events can drive CG_ERROR or similar (e.g., scoreboard error count).  

Document examples:

- CG_FLAGS (overflow/underflow) should be sampled only when assertions are enabled so that coverage reflects correct behavior.  
- Scoreboard mismatch can increment an error counter used for reporting or coverage.  

## 5. Debugging and Reporting Strategy

Describe how your environment will help debug failures:

- **Logging**: UVM IDs (e.g., `[stream_scoreboard]`, `[stream_monitor]`); transaction count and data in convert2string.  
- **Mismatch**: Scoreboard reports expected vs actual (e.g., `uvm_error` with expected queue front vs observed data).  
- **Assertions**: On failure, simulator dumps signal values and assertion context; bind file should be named for easy location.  

Plan for:

- Standardizing messages: `[SB_MAIN][MISMATCH] expected=0x%0h actual=0x%0h at txn #%0d`.  
- Keeping log volume low in pass runs (UVM_LOW for per-txn); increase verbosity for failure analysis.  

Notes:

- Current scoreboard logs each txn at UVM_LOW; add explicit mismatch message when compare is implemented.  

## 6. Open Issues and Action Items

Track outstanding work.

- **Open questions**:
  - Whether to add source-side analysis to scoreboard for expected queue (driver callback or analysis port).  
- **Planned additions**:
  - Implement expected queue and compare in stream_scoreboard.  
  - Add bind file with A_OVERFLOW, A_UNDERFLOW (and optional A_HANDSHAKE, A_LEVEL_CONSIST).  

## 7. Revision History

| Date       | Version | Author | Changes                         |
|------------|---------|--------|---------------------------------|
| 2026-02-05 | 0.1     | Yongfu | Initial checker plan for stream_fifo; SB_MAIN, A_OVERFLOW, A_UNDERFLOW, mapping to R1–R3 |

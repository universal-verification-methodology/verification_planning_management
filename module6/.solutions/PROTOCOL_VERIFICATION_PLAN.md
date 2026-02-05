# Protocol Verification Plan (Module 6)

> **Purpose**: Define how you will verify protocol correctness (e.g., AXI-like, custom bus) using agents, checkers, coverage, and tests.  
> **Module**: 6 – Complex Multi-Agent & Protocol Testbenches (SV/UVM)

## 1. Protocol Overview

- **Protocol Name**: Ready/Valid streaming (source and sink).  
- **Key Characteristics**:
  - **Channels**: Source (s_valid, s_ready, s_data); sink (m_valid, m_ready, m_data).  
  - **Handshakes**: Transfer on clock edge when valid && ready; one beat per handshake.  
  - **Ordering**: FIFO order — first-in first-out.  
  - **Error/response semantics**: Overflow (write when full) and underflow (read when empty) set sticky flags; flags clear on reset.  

Summarize how the protocol is used by the DUT (roles, typical traffic patterns):

- **DUT roles**: stream_fifo is sink on source interface (accepts push) and source on sink interface (drives pop). TB driver is master on source (drives s_valid, s_data); TB drives m_ready on sink. Monitor observes m_valid, m_ready, m_data and samples on handshake.  
- **Traffic**: Single-beat transfers; backpressure via ready deassertion; typical patterns = sustained push, sustained pop, simultaneous push+pop, fill-then-drain.  

## 2. Protocol Agent Strategy

Describe how you will model the protocol with UVM agents.

| Agent Name      | Role (master/slave/passive) | Channels Handled        | Notes                         |
|-----------------|-----------------------------|-------------------------|-------------------------------|
| source_agent (stream_driver) | master                      | Source (s_valid, s_ready, s_data) | Drives push to DUT        |
| sink_agent (stream_monitor) | passive                     | Sink (m_valid, m_ready, m_data)   | Observes pop for checking/coverage |

Document:

- **Active vs passive**: Source agent active (driver); sink agent passive (monitor). No slave driver for sink — m_ready driven by TB logic (e.g., always ready or stimulus).  
- **Reuse**: stream_if and stream_driver/stream_monitor are generic for ready/valid streaming; stream_fifo-specific coverage and assertions in common_dut/tb and module4.  

## 3. Protocol Rules and Checkers

### 3.1 Rule Inventory

List key protocol rules you will check (link to requirements where possible).

| Rule ID | Description                                      | Type (safety/order/timing) | Related Req IDs | Notes |
|---------|--------------------------------------------------|----------------------------|------------------|-------|
| PR_001  | Valid/ready handshake: transfer only when valid && ready | safety/handshake           | R1               | No transfer without handshake |
| PR_002  | In-order transfer: popped data matches push order       | ordering                   | R1               | Scoreboard check |
| PR_003  | Overflow set only when s_valid=1 and FIFO full (s_ready=0) | safety/functional        | R2               | A_OVERFLOW assertion |
| PR_004  | Underflow set only when m_ready=1 and FIFO empty (m_valid=0) | safety/functional      | R3               | A_UNDERFLOW assertion |
| PR_005  | Flags sticky until reset                          | safety                     | R2, R3           | Assertion or monitor check |

### 3.2 Checker Design

Describe protocol checker components/modules.

| Checker ID     | Location (component/file)          | Inputs (signals/transactions)      | Rules Enforced (IDs) |
|----------------|------------------------------------|------------------------------------|----------------------|
| CHK_PROTO_MAIN | Bind to stream_fifo or in stream_if | s_valid, s_ready, m_valid, m_ready, level, overflow, underflow | PR_001, PR_003, PR_004, PR_005 |
| SB_MAIN        | stream_scoreboard                  | stream_item from monitor           | PR_002 (ordering)    |

For each checker:

- **CHK_PROTO_MAIN**: SVA assertions (A_OVERFLOW, A_UNDERFLOW, optional handshake); state = level, overflow, underflow; errors via assertion failure or UVM report.  
- **SB_MAIN**: Expected queue vs monitor transactions; mismatch reported via uvm_error.  

Notes:

- **Placement**: Assertions in bind file (e.g., stream_fifo_asserts.sv) bound to stream_fifo; scoreboard in stream_scoreboard.  

## 4. Protocol Coverage

Describe how you will measure protocol coverage (complementary to `module3/COVERAGE_DESIGN.md`).

### 4.1 Functional Coverage for Protocol

| Coverage ID     | Purpose                            | Placement / Sampling              |
|-----------------|------------------------------------|-----------------------------------|
| CG_OPS          | Operation types (idle/push/pop/both) | stream_fifo_coverage, monitor   |
| CG_LEVEL        | Occupancy levels                   | stream_fifo_coverage               |
| CG_FLAGS        | Overflow/underflow set/clear       | stream_fifo_coverage               |
| CG_BACKPRESSURE | Backpressure patterns              | stream_fifo_coverage               |

Document:

- **Coverpoints**: See module3/COVERAGE_DESIGN.md; protocol-specific = handshake combinations, flag transitions.  
- **Tests**: FTR_002 (simultaneous), ERR_001/ERR_002 (flags), STR_001/STR_002 (backpressure).  

### 4.2 Code/Assertion Coverage

If applicable:

- **Assertion coverage**: Simulator assertion coverage for A_OVERFLOW, A_UNDERFLOW; ensure overflow/underflow branches hit.  
- **Code coverage**: RTL statement/branch on stream_fifo; protocol-related = handshake and pointer logic.  

Notes:

- **Interpretation**: Assertion hit = rule exercised; code coverage on RTL = protocol paths exercised.  

## 5. Test Mapping for Protocol Verification

Map tests (from `module2/TEST_PLAN.md`) to protocol verification goals.

| Test ID       | Scenario Description                         | Protocol Focus (rules/areas)      | Notes |
|---------------|----------------------------------------------|-----------------------------------|-------|
| SMK_001       | Basic legal push/pop                         | PR_001, PR_002                    | Sanity |
| FTR_002       | Simultaneous push and pop                    | PR_001 (both channels)            | Same-cycle handshake |
| ERR_001       | Overflow (push when full)                    | PR_003 (negative: flag set)      | |
| ERR_002       | Underflow (pop when empty)                   | PR_004 (negative: flag set)       | |
| ERR_005       | Flag sticky until reset                     | PR_005                            | |
| STR_001       | Backpressure from sink                       | PR_001 under backpressure         | |

Ensure you have:

- **Positive**: SMK_001, FTR_001–FTR_013 (legal behavior).  
- **Negative**: ERR_001–ERR_006 (protocol/flag violations).  
- **Stress**: STR_001–STR_013 (long/complex sequences, backpressure).  

## 6. Integration with Multi-Agent Env and Scoreboards

Describe how protocol verification integrates with:

- **Multi-agent architecture** (from `MULTI_AGENT_ARCHITECTURE.md`): Source driver and sink monitor feed protocol checker (assertions) and scoreboard (ordering).  
- **Scoreboards and reference models** (from `module4/CHECKER_PLAN.md`): SB_MAIN enforces PR_002; protocol checker enforces PR_001, PR_003, PR_004, PR_005.  

Examples:

- **Protocol checker**: Bind file sees DUT signals; assertions fire on violation; no transaction input.  
- **Scoreboard**: Consumes monitor transactions; compare is "valid" only if protocol is respected (no assertion failure); optional: disable scoreboard compare if assertion fired.  

Document specifics:

- **Integration**: Assertions run in parallel with UVM env; scoreboard runs in UVM. Failure handling: assertion failure fails simulation; scoreboard mismatch reports uvm_error. Both feed same regression and debug workflow.  

## 7. Open Issues and Next Steps

Track remaining protocol verification questions and planned enhancements:

- **Open**: Optional protocol checker component (UVM) that samples signals and reports violations for tighter integration with UVM reporting.  
- **Next steps**: Implement bind file with PR_003, PR_004, PR_005 assertions; add PR_001 handshake checks if needed.  

## 8. Revision History

| Date       | Version | Author | Changes                             |
|------------|---------|--------|-------------------------------------|
| 2026-02-05 | 0.1     | Yongfu | Initial protocol verification plan for stream_fifo (ready/valid, PR_001–PR_005, agents, coverage, test mapping) |

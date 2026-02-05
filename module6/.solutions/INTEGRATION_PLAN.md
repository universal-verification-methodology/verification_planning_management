# Integration & System-Level Scenarios (Module 6)

> **Purpose**: Describe how your components, agents, and protocols integrate at block, subsystem, and (optionally) system level, and define key end-to-end verification scenarios.  
> **Module**: 6 – Complex Multi-Agent & Protocol Testbenches (SV/UVM)

## 1. Integration Levels

Define the relevant integration levels for your project:

| Level       | Description                            | Scope / Components Included                |
|------------|----------------------------------------|--------------------------------------------|
| Block      | Single IP/DUT (stream_fifo)            | stream_fifo RTL, stream_env (driver, monitor, scoreboard), protocol checker (assertions) |
| Subsystem  | Multiple blocks interacting            | N/A for current project                    |
| System/SoC | Full-chip or top-level integration     | N/A for current project                    |

Summarize which levels are **in-scope** for this module:

- **Block level only**: stream_fifo is a single block; verification is block-level. Integration here = integration of source agent, sink agent, scoreboard, and protocol assertions within the block testbench. No subsystem or SoC in scope.  

## 2. Integration Architecture

Describe how agents and components connect at the chosen integration level.

- **Agents**: Source driver and sink monitor belong to stream_fifo block; both connect to DUT via stream_if (source modport to s_*, sink modport to m_*).  
- **Cross-block**: N/A — single block.  
- **Reuse**: stream_if and base driver/monitor could be reused if another block uses same protocol.  

Provide a textual diagram or description, for example:

```text
stream_env (block level)
├── stream_driver   — drives source interface (push)
├── stream_monitor — observes sink interface (pop)
├── stream_scoreboard — compares expected vs actual (order)
└── (protocol checker via bind: assertions on DUT ports)
```

Adapt to your actual integration.

- **Connections**: Driver and monitor get virtual interfaces from config DB; scoreboard receives analysis port from monitor; assertions in bind file see DUT signals directly.  

## 3. System-Level Scenarios

Define key end-to-end scenarios that exercise integration behavior. (For block level, these are "block-level end-to-end" scenarios: stimulus → DUT → observation → check.)

| Scenario ID     | Description                               | Level (block/subsystem/system) | Agents/Interfaces Involved      | Notes |
|-----------------|-------------------------------------------|--------------------------------|---------------------------------|-------|
| INTG_FILL_DRAIN | Fill FIFO to full, then drain to empty   | block                           | source, sink                    | FTR_001, boundary |
| INTG_SIMUL      | Simultaneous push and pop same cycle      | block                           | source, sink                    | FTR_002 |
| INTG_OVERFLOW   | Fill, hold sink slow, push when full      | block                           | source, sink, status (overflow) | ERR_001 |
| INTG_UNDERFLOW  | Drain to empty, then pop                  | block                           | source, sink, status (underflow)| ERR_002 |
| INTG_BACKPRESSURE | Sustained backpressure source/sink      | block                           | source, sink                    | STR_001, STR_002 |
| INTG_STRESS     | Long random traffic, mixed backpressure   | block                           | source, sink                    | STR_004, STR_005 |

For each scenario, document:

- **Preconditions**: Reset done; DUT in default config (DATA_WIDTH, DEPTH).  
- **Sequence**: Virtual or concrete sequence (e.g., boundary_seq, overflow_seq); which sequences from module4/5.  
- **Expected outcomes**: Scoreboard match (in-order); assertions pass; overflow/underflow set only when expected.  

## 4. Cross-Block / Cross-Agent Checking

Describe how you verify **end-to-end correctness** across multiple components:

- **Combined scoreboard**: stream_scoreboard sees only sink (monitor) transactions; expected data comes from sequence/driver side. End-to-end = push sequence → DUT → pop sequence; scoreboard verifies pop order matches expected.  
- **Cross-checks**: Protocol assertions (overflow/underflow) and scoreboard (ordering) together ensure correctness; assertion failure or scoreboard mismatch fails the test.  
- **Time-based**: Not required for single FIFO; order is sufficient.  

Example table:

| Check ID    | Description                                 | Inputs (streams/monitors)        | Notes |
|-------------|---------------------------------------------|-----------------------------------|-------|
| INTG_SB_01  | In-order data from push to pop              | stream_monitor.ap → scoreboard    | PR_002, SB_MAIN |
| INTG_PROTO_01 | Overflow/underflow only when correct      | DUT signals (bind assertions)     | PR_003, PR_004 |

## 5. Configuration Across Levels

Explain how configuration is managed across blocks/subsystems:

- **Block level**: Env config (stream_env_cfg or equivalent): seed, coverage enable, verbosity. Set from test or plusargs.  
- **Consistency**: Single block — no address map or cross-block config; DATA_WIDTH and DEPTH are RTL parameters, matched in TB interface.  
- **Subsystem/system**: N/A.  

Notes:

- **Config**: Same as module4/5; no additional integration-level config for single block.  

## 6. Regression & Coverage at Integration Level

Tie integration scenarios into:

- **Regression jobs** (from `module5/REGRESSION_OPS.md`): INTG_FILL_DRAIN, INTG_SIMUL, INTG_OVERFLOW, INTG_UNDERFLOW covered by CORE tier (FTR_001, FTR_002, ERR_001, ERR_002); INTG_BACKPRESSURE and INTG_STRESS by STRESS tier.  
- **Coverage** (from `module3/COVERAGE_DESIGN.md` and protocol coverage): Integration scenarios drive CG_LEVEL, CG_OPS, CG_FLAGS, CG_BACKPRESSURE; no separate "integration coverage" for single block — same coverage model.  

Document:

- **Tagging**: Integration scenarios map to existing test IDs; no separate tag.  
- **Coverage**: Block-level coverage suffices; cross-block bins N/A.  

## 7. Open Issues and Future Extensions

Track remaining integration concerns and ideas:

- **Open**: None blocking for block-level only.  
- **Extensions**: If stream_fifo is later integrated into a subsystem (e.g., with DMA or CPU), add subsystem-level env and scenarios (multi-block traffic, cross-block scoreboard).  

## 8. Revision History

| Date       | Version | Author | Changes                                |
|------------|---------|--------|----------------------------------------|
| 2026-02-05 | 0.1     | Yongfu | Initial integration plan for stream_fifo (block level, scenarios INTG_*, cross-agent checks) |

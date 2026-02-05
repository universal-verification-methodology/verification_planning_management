# Multi-Agent & Multi-Channel Architecture (Module 6)

> **Purpose**: Describe the architecture and coordination of multi-agent, multi-channel UVM environments for your DUT.  
> **Module**: 6 – Complex Multi-Agent & Protocol Testbenches (SV/UVM)

## 1. Context

- **DUT / System**: stream_fifo — single streaming FIFO with source (push) and sink (pop) interfaces; parameterizable DATA_WIDTH and DEPTH.  
- **Interfaces / Channels**: Source channel (s_valid, s_ready, s_data); sink channel (m_valid, m_ready, m_data); status (level, overflow, underflow).  
- **Existing env**: `module4/tb/stream_pkg.sv` and `common_dut/tb/`; refined in `module4/ENV_DESIGN.md`.  

Summarize why a **multi-agent** design is required (e.g., multiple independent masters/slaves, multiple protocols, separate clock/voltage domains):

- **Two logical sides**: Source (push) and sink (pop) are independent handshake interfaces; driver acts as source master, monitor observes sink. Treating them as two "agents" (source-side driver + optional sequencer, sink-side monitor) allows clear separation of stimulus vs observation and future extension (e.g., second monitor on source for expected data).  
- **Single clock domain**; one protocol (ready/valid streaming). Multi-agent here = two interface roles, not multiple physical agents.  

## 2. High-Level Environment Diagram

Describe the multi-agent environment. Example:

```text
uvm_test_top (stream_test or variant)
└── env (stream_env)
    ├── drv (stream_driver)        — source-side agent (drives push)
    ├── mon (stream_monitor)       — sink-side agent (observes pop)
    └── sb  (stream_scoreboard)    — compares expected vs observed (order-based)
```

Replace with your actual structure and annotate:

- **Agents**: Source-side = driver (active); sink-side = monitor (passive).  
- **Instances**: One driver, one monitor.  
- **Coordination**: No virtual sequencer in current impl; sequence started on driver's seq_item_port. Optional: virtual sequencer to run reset + traffic phases.  

Describe your actual hierarchy:

- **Current** (module4/tb): stream_env contains stream_driver, stream_monitor, stream_scoreboard. Driver drives source interface; monitor observes sink interface and writes to scoreboard via analysis port. Single stream; "multi-channel" = source channel (push) and sink channel (pop) feeding one scoreboard that matches expected (from sequence) vs actual (from monitor).  

## 3. Agent Inventory and Roles

List all agents and their key characteristics.

| Agent Name       | Role (master/slave/passive) | Interface / Channel(s)      | Active/Passive Modes | Notes |
|------------------|-----------------------------|-----------------------------|----------------------|-------|
| source_agent     | master (driver)             | Source (s_valid, s_ready, s_data) | active               | Drives push transactions |
| sink_agent       | passive (monitor)           | Sink (m_valid, m_ready, m_data)   | passive              | Observes pop transactions |

Adapt and fill this table for your design.

- **Naming**: In code, "source" = stream_driver; "sink" = stream_monitor. No separate agent wrapper in current impl; driver and monitor are top-level components in env.  

## 4. Coordination Strategy

Explain how agents are coordinated:

- **Virtual sequencers**: Optional; if added, vsys_stream would hold reference to source sequencer and run virtual sequences (e.g., reset_then_traffic_vs) that start sub-sequences on source.  
- **Scenarios**: (1) Concurrent push (source) and pop (sink) — driver and DUT/sink interact via backpressure; (2) reset while traffic — driver/monitor see reset; (3) error injection (overflow/underflow) — driver holds back sink ready or pushes when full.  

Document:

- **Coordination**: Single sequencer (source); monitor independent. Traffic patterns controlled by sequence (num_items, delays). Backpressure naturally from DUT (s_ready, m_ready). No cross-agent locking; scoreboard receives only sink transactions and matches vs expected queue (populated from sequence knowledge or future source monitor).  

## 5. Multi-Channel Scoreboarding

Describe your multi-channel scoreboard design (see also `module4/CHECKER_PLAN.md`).

| Channel / Stream   | Source Monitor / Analysis Port         | Scoreboard Input Port / Imp      | Matching Strategy           |
|--------------------|----------------------------------------|----------------------------------|-----------------------------|
| Sink (pop) data    | stream_monitor.ap                      | stream_scoreboard.imp_in         | Order-based: expected queue vs actual pop |

Describe:

- **Channels**: One logical stream (push in, pop out). Scoreboard receives sink transactions only; expected data comes from sequence/driver side (currently inferred or from future source analysis export).  
- **Matching**: FIFO order — each pop compared to front of expected queue; mismatch reported.  
- **Time-based**: Not required for single FIFO; order is sufficient.  

Notes:

- **Enhancement**: Add source-side analysis (driver callback or monitor) to push expected data into scoreboard for robust compare.  

## 6. Layered Architecture & Reuse

Explain how your complex env is layered for maintainability:

- **Base**: stream_item, stream_driver, stream_monitor, stream_scoreboard, stream_env — reusable for any ready/valid streaming DUT.  
- **Protocol**: stream_if (modport master/slave) — reusable for other FIFO-like interfaces.  
- **Extension**: Add coverage collector (stream_fifo_coverage), protocol checker (handshake/overflow/underflow assertions); new sequences without changing base components.  

Document patterns and decisions:

- **Reuse**: common_dut/tb holds DUT-agnostic coverage skeleton and FIFO-specific coverage class; module4/tb holds stream_fifo UVM env. New agents (e.g., second monitor) can be added by extending env and connecting analysis ports.  

## 7. Integration with Tests and Sequences

Map key tests (from `module2/TEST_PLAN.md`) to this multi-agent architecture:

| Test ID        | Scenario Description                   | Agents / Channels Used               | Virtual Sequence / Sequences      |
|----------------|----------------------------------------|--------------------------------------|-----------------------------------|
| SMK_001        | Basic push/pop                         | source (drv), sink (mon)             | stream_seq                         |
| FTR_001        | Boundary fill/drain                    | source, sink                         | boundary_seq (fill then drain)     |
| FTR_002        | Simultaneous push/pop                 | source, sink                         | simultaneous_seq                  |
| ERR_001        | Overflow injection                     | source (hold sink slow), sink        | overflow_seq                       |
| STR_001        | Backpressure from sink                 | source, sink                         | backpressure_source_seq           |
| STR_002        | Backpressure from source               | source, sink                         | backpressure_sink_seq             |

Fill in with your actual tests and sequences.

- **Multi-agent usage**: All tests use both source (driver) and sink (monitor); coordination is implicit (driver drives, monitor observes). No multi-master contention; single stream.  

## 8. Open Issues and Future Enhancements

Track open architecture questions:

- **Open**: Whether to add source-side monitor for expected data to scoreboard.  
- **Enhancements**: Virtual sequencer for multi-phase scenarios; protocol checker component wrapping assertions; second stream (e.g., second FIFO) for cross-FIFO scenarios if DUT expands.  

## 9. Revision History

| Date       | Version | Author | Changes                                   |
|------------|---------|--------|-------------------------------------------|
| 2026-02-05 | 0.1     | Yongfu | Initial multi-agent architecture for stream_fifo (source/sink agents, scoreboard, test mapping) |

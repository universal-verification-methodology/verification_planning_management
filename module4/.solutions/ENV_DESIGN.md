# UVM Environment & Agent Design (Module 4)

> **Purpose**: Define the detailed UVM environment, agent, transaction, and sequence design for your DUT.  
> **Module**: 4 – UVM Environment & Checker Maturity (SV/UVM)

## 1. Context

- **DUT**: `stream_fifo` — parameterizable streaming FIFO with ready/valid handshakes on source (push) and sink (pop); configurable DATA_WIDTH (default 8) and DEPTH (default 16). Exposes `level`, `overflow`, and `underflow` status.  
- **Key Interfaces / Protocols**: Source interface (s_valid, s_ready, s_data); sink interface (m_valid, m_ready, m_data); status (level, overflow, underflow). No address bus; single data beat per handshake.  
- **Prior artifacts**:
  - `module1/VERIFICATION_PLAN.md` (high-level env & strategy).  
  - `module2/TEST_PLAN.md` (test catalogue and types/tiers).  
  - `module3/COVERAGE_DESIGN.md` (coverage placement and IDs).  

Summarize the **main verification concerns** that drive your env design (e.g., throughput, ordering, error handling):

- **In-order transfer (R1)**: Scoreboard must compare popped data with expected order (reference queue).  
- **Overflow/underflow flags (R2, R3)**: Assertions and scoreboard must verify flags set only when appropriate (write when full / read when empty) and sticky until reset.  
- **Backpressure and protocol**: Driver and monitor must respect valid/ready handshake; tests must exercise backpressure (source/sink slow).  

## 2. Environment Block Diagram

Describe or sketch your environment. Example structure:

```text
uvm_test_top (stream_test or test variant)
└── env (stream_env)
    ├── drv (stream_driver)        — source-side driver
    ├── mon (stream_monitor)      — sink-side monitor (observes DUT output)
    ├── sb  (stream_scoreboard)   — compares expected vs observed
    └── (optional: sequencer; current impl starts seq on driver's seq_item_port)
```

Adapt to your DUT and describe your actual hierarchy:

- **Current implementation** (`module4/tb/stream_pkg.sv`): `stream_env` contains `stream_driver`, `stream_monitor`, and `stream_scoreboard`. No separate agent wrappers; driver receives sequences via `seq_item_port`. Monitor observes sink interface (m_valid, m_ready, m_data) and writes `stream_item` to scoreboard via analysis port.  
- **Optional refinement**: Introduce `stream_agent` (driver + sequencer) for clarity and reuse; keep monitor and scoreboard in env.  

## 3. Component Responsibilities

Define clear responsibilities to avoid overlap and confusion.

| Component          | Type               | Responsibilities                                    | Notes                  |
|--------------------|--------------------|-----------------------------------------------------|------------------------|
| stream_env         | `uvm_env`          | Owns driver, monitor, scoreboard; connects TLM (mon.ap → sb.imp_in); gets vif_src/vif_snk from config DB | Single-stream FIFO env |
| stream_driver      | `uvm_driver #(stream_item)` | Drives source interface (s_valid, s_data); waits for s_ready; one beat per transaction | No separate sequencer in current code |
| stream_monitor     | `uvm_monitor`      | Samples sink interface on valid&&ready; builds stream_item; writes to analysis port | Sink-side only          |
| stream_scoreboard | `uvm_component`    | Receives stream_item from monitor; compares vs reference queue (in-order); reports mismatch | SB_MAIN                 |
| (ref model)        | Internal to SB or separate | Reference queue: push on driver txn (if available) or infer from monitor stream; pop expected vs actual | Can be queue inside scoreboard |

Extend/modify this table to match your design.

## 4. Transaction Models

List your main transaction classes and their key fields.

| Transaction Class     | Purpose                       | Key Fields (name:type)                         | Notes              |
|-----------------------|-------------------------------|------------------------------------------------|--------------------|
| stream_item (extends `uvm_sequence_item`) | Single data beat (push or pop) | data: bit [7:0] (or DATA_WIDTH-1:0)           | Used for both source-driven and sink-observed data |

For each transaction type, document:

- **Constraints**: data unconstrained (or constrained for directed tests).  
- **Helper methods**: `convert2string()` for logging; `do_copy`/`do_compare` optional for scoreboard.  
- **Mapping to DUT**: `data` maps to `s_data` / `m_data`; one transaction per handshake (valid && ready).  

Document details:

- `stream_item` is minimal (data only). No address, cmd, or burst_len; FIFO is single-beat. Scoreboard maintains expected queue: on each sink-side transaction, compare popped data with expected queue front and pop.  

## 5. Sequence Design

Map sequences to test intents from `test_plan.md`.

### 5.1 Base Sequences

| Sequence Class   | Purpose / Intent                       | Uses Transaction(s) | Notes                  |
|------------------|----------------------------------------|---------------------|------------------------|
| stream_seq       | Common flow: push N random items       | stream_item         | num_items configurable; used by stream_test |

### 5.2 Feature / Negative / Stress Sequences

| Sequence Class       | Intent / Linked Tests (IDs)                       | Type (feature/stress/error) | Notes |
|----------------------|----------------------------------------------------|-----------------------------|-------|
| stream_seq           | SMK_001, basic push flow                           | smoke/feature               | Base  |
| boundary_seq         | FTR_001, FTR_003 — fill then drain, boundary levels| feature                     | Push until full, pop until empty |
| simultaneous_seq     | FTR_002 — same-cycle push and pop                  | feature                     | Constrain backpressure to allow both |
| overflow_seq         | ERR_001 — push when full to set overflow           | error                       | Hold m_ready low, fill FIFO, one extra push |
| underflow_seq        | ERR_002 — pop when empty to set underflow          | error                       | Pop until empty, one extra pop |
| backpressure_source_seq | STR_001 — sink slow                               | stress                      | Random m_ready deassert to stress source |
| backpressure_sink_seq   | STR_002 — source slow                             | stress                      | Random delays between push beats |
| random_burst_seq     | STR_004, STR_005 — random lengths and backpressure | stress                      | Random num_items and inter-beat delay |

Populate this table using your actual test IDs from `test_plan.md`.

## 6. Driver Design

Describe how each driver will operate.

### 6.1 Source Driver (stream_driver)

- Class: `stream_driver` (extends `uvm_driver #(stream_item)`).  
- `run_phase()` behavior:
  - Initialize vif: valid=0, data=0.  
  - Loop: `get_next_item(tr)`, drive `vif.data <= tr.data`, `vif.valid <= 1`; wait for `vif.ready` (posedge clk); then `vif.valid <= 0`, `item_done()`.  
- Protocol details (timing, ready/valid, error signaling):  
  - Valid/ready handshake: one beat per transaction. No burst; driver does not drive when ready=0 except holding valid high until accepted.  
- Hooks:
  - Logging per transaction (UVM_LOW). Optional: callback for coverage or trace.  

### 6.2 Control Driver

Similarly describe your control/config driver.

- **N/A** for stream_fifo: no separate control interface. Configuration (DATA_WIDTH, DEPTH) is RTL parameter; no runtime config driver.  

## 7. Monitor Design

Describe how each monitor observes and emits transactions.

### 7.1 Sink Monitor (stream_monitor)

- Class: `stream_monitor` (extends `uvm_component`; has `uvm_analysis_port #(stream_item)`).  
- Responsibilities:
  - Sample sink interface (m_valid, m_ready, m_data).  
  - On each cycle where `m_valid && m_ready`, create `stream_item` with `data = m_data`, write to `ap`.  
- Sampling strategy:
  - One transaction per consumed beat (m_valid && m_ready).  
- Special cases:
  - Reset: do not sample during rst_n=0.  
  - Protocol: only sample on handshake; no error injection in monitor.  

### 7.2 Control Monitor

Define similar details for control/config monitoring.

- **N/A** for stream_fifo. Optional: second monitor on source side to feed scoreboard expected data (or scoreboard infers expected from same sequence that driver runs).  

## 8. TLM & Interconnect

Document TLM/analysis connections in your env.

| From Component / Port       | To Component / Export/Imp         | Purpose                       |
|-----------------------------|-----------------------------------|-------------------------------|
| stream_monitor.ap           | stream_scoreboard.imp_in (analysis_imp) | Send observed sink transactions for comparison |

Driver does not send to scoreboard in current design; scoreboard can maintain expected queue from test/sequence side (e.g., mirror of what driver sends) or from a separate source-side monitor if added.

Adjust to match your actual design.

## 9. Configuration & Modes

Describe how you configure your env/agents.

- **UVM config DB**:
  - `vif_src` (virtual stream_if.master) for driver; `vif_snk` (virtual stream_if.slave) for monitor. Set in testbench top before `run_test()`.  
  - No active/passive agent mode (single driver, single monitor).  
- **Parameters**: DATA_WIDTH, DEPTH from RTL; can be matched in TB via interface parameters.  
- **Coverage/assertions**: Enable/disable via plusargs or config DB if needed (e.g., +COVERAGE=1).  

Document your key config knobs:

- Virtual interfaces (vif_src, vif_snk). Optional: seed, coverage enable, assertion severity.  

## 10. Open Design Issues and Action Items

Track remaining design questions and planned refactors.

- **Open questions**:
  - Whether to add source-side monitor to feed scoreboard expected data (currently scoreboard can count only; full compare requires expected queue from sequence or ref model).  
- **Planned refactors / enhancements**:
  - Add reference model (e.g., queue in scoreboard populated from sequence items or source monitor).  
  - Add sequencer and wrap driver in agent for clarity.  
  - Add coverage collector (stream_fifo_coverage) into monitor or env.  

## 11. Revision History

| Date       | Version | Author | Changes                         |
|------------|---------|--------|---------------------------------|
| 2026-02-05 | 0.1     | Yongfu | Initial env/agent design for stream_fifo; aligned with module4/tb/stream_pkg.sv |

# Verification IP (VIP) Design Plan (Module 7)

> **Purpose**: Design and document a reusable Verification IP (VIP) for a chosen protocol or IP block.  
> **Module**: 7 – Real-World Verification Applications & VIP (SV/UVM)

## 1. VIP Overview

- **Protocol / IP**: Ready/valid streaming protocol — single-beat handshake (valid && ready) for push and pop; used by stream_fifo and other FIFO-like or streaming blocks.  
- **Intended Use**:
  - Block-level verification (stream_fifo and similar DUTs).  
  - Subsystem/system integration (reuse stream_if and agents where streaming interfaces appear).  
  - Internal reuse first; can be packaged for wider reuse with documentation.  

Summarize what this VIP should enable users to do:

- **Drive** source-side traffic (push) via UVM driver and sequences.  
- **Observe** sink-side traffic (pop) via UVM monitor and analysis port.  
- **Check** in-order correctness via scoreboard and protocol rules (overflow/underflow) via assertions.  
- **Measure** functional coverage (operations, level, flags, backpressure).  
- **Configure** virtual interfaces, seed, coverage enable; integrate into any env that provides vif.  

## 2. VIP Components

List all main VIP components.

| Component ID   | Type                | Purpose                                 |
|----------------|---------------------|-----------------------------------------|
| stream_if      | Interface (modport master/slave) | DUT-facing signals: valid, ready, data; clk, rst_n |
| stream_item    | uvm_sequence_item   | Transaction: data (single beat)        |
| stream_driver  | uvm_driver          | Drives source (push) transactions       |
| stream_monitor | uvm_monitor         | Observes sink (pop) transactions       |
| stream_scoreboard | uvm_component    | Order-based compare (expected vs actual) |
| stream_fifo_coverage | Class (covergroups) | CG_OPS, CG_LEVEL, CG_FLAGS        |
| Protocol checker | Bind assertions   | Overflow/underflow/handshake rules      |
| stream_env     | uvm_env             | Contains driver, monitor, scoreboard     |
| stream_seq     | uvm_sequence        | Base sequence (e.g., N pushes)          |

Adapt/extend this for your VIP.

- **Location**: common_dut/tb (stream_fifo_coverage, stream_fifo_env_skeleton), module4/tb (stream_if, stream_pkg: stream_item, stream_driver, stream_monitor, stream_scoreboard, stream_env, stream_test, stream_seq).  

## 3. Interfaces and Transactions

### 3.1 DUT Interface(s)

Describe the interface signals the VIP interacts with:

- **Clock/reset**: clk, rst_n (inputs to interface).  
- **Control/data/status**: valid, ready, data (DATA_WIDTH); for stream_fifo also level, overflow, underflow (DUT outputs; monitor or checker can sample).  
- **Handshakes**: Transfer on posedge clk when valid && ready; one beat per handshake.  

### 3.2 Transaction Definition

Define the primary transaction class(es).

| Transaction Class    | Fields (name:type)                  | Notes |
|----------------------|-------------------------------------|-------|
| stream_item          | data: bit [DATA_WIDTH-1:0] (e.g., 8) | Single beat; used for both push (driver) and pop (monitor) |

Document:

- **Constraints**: data unconstrained by default; tests can constrain.  
- **Helpers**: convert2string(); optional do_copy, do_compare for scoreboard.  

## 4. Protocol Checks and Scoreboarding

### 4.1 Protocol Rules

List key protocol rules (can reference `module6/PROTOCOL_VERIFICATION_PLAN.md`).

| Rule ID | Description                         | Enforced By (checker/assertions/scoreboard) |
|---------|-------------------------------------|---------------------------------------------|
| PR_001  | Handshake: transfer only when valid && ready | Assertions / monitor sampling       |
| PR_002  | In-order: popped data matches push order     | stream_scoreboard                  |
| PR_003  | Overflow set only when write when full       | Bind assertion (A_OVERFLOW)        |
| PR_004  | Underflow set only when read when empty      | Bind assertion (A_UNDERFLOW)       |
| PR_005  | Flags sticky until reset                     | Assertions / monitor               |

### 4.2 Scoreboard & Reference Behavior

Describe how the VIP will check correctness:

- **Expectations**: Popped data matches FIFO order (expected queue front).  
- **Reference**: Internal expected queue (push on driver/sequence side, pop on monitor compare).  
- **Mismatch**: uvm_error with expected vs actual; optional stats counter.  

Notes:

- **Current**: stream_scoreboard counts transactions; full compare requires expected queue (driver callback or source monitor).  

## 5. Coverage Model

Define coverage aspects for the VIP:

- **Operations**: idle, push_only, pop_only, push_and_pop (CG_OPS).  
- **Level**: empty, low, mid, high, full (CG_LEVEL).  
- **Flags**: overflow/underflow set/clear (CG_FLAGS).  
- **Backpressure**: none, source_slow, sink_slow, both (CG_BACKPRESSURE).  
- **Errors**: Overflow/underflow conditions (covered by CG_FLAGS and assertions).  

Summarize coverage items:

| Coverage ID | What it Covers                    | Notes |
|-------------|-----------------------------------|-------|
| CG_OPS      | Operation types per cycle         | stream_fifo_coverage |
| CG_LEVEL    | Occupancy levels                  | stream_fifo_coverage |
| CG_FLAGS    | Overflow/underflow set/clear      | stream_fifo_coverage |
| CG_BACKPRESSURE | Backpressure patterns         | Optional in VIP or DUT-specific |

Refer to `module3/COVERAGE_DESIGN.md` for full design.

## 6. Configuration and Reuse

Describe how the VIP will be configured and reused:

- **Config fields**: Virtual interfaces (vif_src, vif_snk) via config DB; seed (+UVM_SEED=); coverage enable (+COVERAGE=1 or env_cfg); optional verbosity.  
- **Defaults**: Coverage off for speed; seed from test or random.  
- **Integration**: User instantiates stream_env in test; sets vif_src, vif_snk before run_test(); uses provided sequences or writes custom ones.  

Example:

- `uvm_config_db#(virtual stream_if.master)::set(null, "uvm_test_top.env", "vif_src", s_if);`  
- `uvm_config_db#(virtual stream_if.slave)::set(null, "uvm_test_top.env", "vif_snk", m_if);`  
- Optional: stream_env_cfg with has_coverage, seed, verbosity.  

Document your actual config strategy:

- **Strategy**: Config DB for virtual interfaces (required); plusargs for seed and coverage; no agent active/passive (single driver, single monitor).  

## 7. Integration and Usage

Explain how a user would integrate the VIP into a new environment:

1. **Instantiate** stream_env in uvm_test (e.g., stream_test or custom test).  
2. **Configure**: Set vif_src (master modport) and vif_snk (slave modport) in config DB from testbench top before run_test().  
3. **Connect**: Env connects monitor analysis port to scoreboard; no extra user connection.  
4. **Run**: Test creates sequence (e.g., stream_seq), starts on driver’s seq_item_port (or sequencer when added).  

Provide a short "usage recipe":

- **Recipe**: (1) In TB top: instantiate stream_if, DUT, drive clk/rst; (2) Set uvm_config_db for vif_src and vif_snk; (3) run_test("stream_test") or run_test("your_test") with your_test extending stream_test and overriding sequence; (4) Run with +UVM_SEED= for reproducibility.  

## 8. Documentation and Deliverables

Plan what documentation you will provide:

- **README**: How to build, run, and extend; directory layout; dependency on UVM and simulator.  
- **API overview**: Key classes (stream_item, stream_driver, stream_monitor, stream_scoreboard, stream_env), config (vif_src, vif_snk), base sequences (stream_seq).  
- **Example tests**: stream_test in module4/tb; example of custom sequence.  

Document deliverables:

- **Deliverables**: module4/README or project README; module4/ENV_DESIGN.md and module6/7 docs; inline comments in stream_pkg.sv and stream_if.sv.  

## 9. Revision History

| Date       | Version | Author | Changes                      |
|------------|---------|--------|------------------------------|
| 2026-02-05 | 0.1     | Yongfu | Initial VIP design for ready/valid streaming VIP (components, interfaces, rules, coverage, config, usage) |

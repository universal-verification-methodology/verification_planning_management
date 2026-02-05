# Advanced UVM Orchestration Plan (Module 5)

> **Purpose**: Plan how advanced UVM features (virtual sequences, virtual sequencers, complex configuration, callbacks, register model usage) will be used to support your regression strategy.  
> **Module**: 5 – Regression Management & Advanced UVM Orchestration (SV/UVM)

## 1. Context

- **DUT / System Composition**: stream_fifo — single streaming FIFO with source (push) and sink (pop) interfaces; no separate control or register interface.  
- **Agents / Interfaces**: Single source-side driver and single sink-side monitor (stream_driver, stream_monitor); no multi-agent coordination required for basic operation.  
- **Related docs**:
  - `module2/TEST_PLAN.md` (test intents and tiers).  
  - `module4/ENV_DESIGN.md` (env/agent structure).  
  - `module4/CHECKER_PLAN.md` (scoreboards, assertions).  

Summarize which **advanced UVM features** you intend to use and why:

- **Configuration objects**: Env-level config (coverage enable, seed, verbosity) for regression and tier control.  
- **Callbacks**: Driver/monitor/scoreboard callbacks for extra logging, stats, or fault injection in stress/debug jobs.  
- **Virtual sequencer/sequences**: Optional; single sequencer currently; virtual sequence useful if we add multiple sequences (e.g., reset + traffic) or future multi-DUT scenarios.  

## 2. Virtual Sequencer and Virtual Sequences

### 2.1 Virtual Sequencer Design

Describe your virtual sequencer(s).

| Virtual Sequencer | Sequencers Controlled                  | Purpose / Scope                         |
|-------------------|----------------------------------------|-----------------------------------------|
| vsys_stream       | stream_seqr (source sequencer)        | System-level scenarios (reset + traffic, multi-phase) |

For each virtual sequencer, specify:

- **Placement**: Env-level; virtual sequencer holds reference to stream_seqr (when sequencer is added to env).  
- **Binding**: In connect_phase, set virtual sequencer’s stream_seqr = env.agent.stream_seqr (or env.drv’s sequencer).  

Details:

- **Current implementation**: module4/tb uses driver without explicit sequencer; sequence started on driver’s seq_item_port. To use virtual sequencer, add uvm_sequencer #(stream_item) in env and connect driver to it; virtual sequencer then points to that sequencer. Optional for stream_fifo; useful for multi-phase tests (e.g., reset_seq then stream_seq).  

### 2.2 Virtual Sequences and Scenario Mapping

Map higher-level scenarios (from tests) to virtual sequences.

| Virtual Sequence Class     | Scenario / Test IDs                          | Participating Agents/Sequencers        | Notes |
|----------------------------|----------------------------------------------|----------------------------------------|-------|
| sys_reset_then_traffic_vs  | SMK_002, FTR_001 — reset then push/pop      | stream_seqr                            | Reset phase + stream_seq |
| sys_boundary_fill_drain_vs | FTR_001, FTR_003 — fill to full, drain to empty | stream_seqr                      | Boundary scenario        |
| sys_stress_backpressure_vs | STR_001, STR_002 — sustained backpressure   | stream_seqr                            | Stress scenario          |

Document:

- **Phases**: Reset (optional explicit reset sequence), config (if any), traffic (stream_seq or variant), drain (optional).  
- **Coordination**: Single sequencer; no cross-agent sync required. Virtual sequence body() starts sub-sequences in order.  

## 3. Configuration Objects and Hierarchical Config

Describe your configuration object strategy.

| Config Class     | Scope (env/agent/test)   | Key Fields                           | Notes |
|------------------|--------------------------|--------------------------------------|-------|
| stream_env_cfg   | env-wide settings        | enable_coverage, seed, verbosity     | Set from test or plusargs |
| (agent_cfg)      | per-agent (optional)     | active/passive (N/A for single agent)| Not used for stream_fifo |

For each:

- **Set**: Test sets env_cfg in build_phase; or plusargs (+UVM_SEED=, +COVERAGE=1) parsed and pushed to config DB.  
- **Propagation**: uvm_config_db#(stream_env_cfg)::set/get at env level; env reads config and passes to components (e.g., coverage collector enable).  
- **Validation**: Seed must be non-zero if fixed; coverage enable is boolean.  

Notes:

- stream_env_cfg can hold seed, coverage_enable, and verbosity; tests or run script set these per job/tier.  

## 4. Callbacks and Instrumentation

Plan how callbacks will be used to inject behavior without changing core code.

### 4.1 Callback Targets

| Callback Target   | Callback Class   | Purpose (e.g., logging, mutation, fault injection) | When Active (tiers/jobs) |
|-------------------|------------------|-----------------------------------------------------|--------------------------|
| stream_driver     | drv_cb           | Extra logging, optional data mutation               | debug/stress only        |
| stream_monitor    | mon_cb           | Additional checks, coverage sampling hook          | core/stress              |
| stream_scoreboard | sb_cb            | Stats collection, mismatch detail                  | nightly/full             |

Document:

- **Registration**: In test or env end_of_elaboration_phase; add callback to driver/monitor/scoreboard.  
- **Enable/disable**: Via config (e.g., env_cfg.enable_drv_cb); or plusarg +CALLBACKS=1 for debug jobs.  

### 4.2 Use Cases

List specific callback use cases (e.g., late binding of error injection, targeted logging).

- **Driver**: Pre/post drive callbacks for logging transaction count; optional fault injection (corrupt data) in error tests.  
- **Monitor**: Post sample callback to push to coverage collector; optional protocol check.  
- **Scoreboard**: On mismatch callback to dump expected vs actual and increment error counter for reporting.  

## 5. Register Model Usage (If Applicable)

If the DUT has a register map and you use a UVM register model:

- **N/A** for stream_fifo: no register interface. Skip register model.  

Example table (not used):

| Reg Block ID  | Address Map Scope      | Used By Tests/Sequences                  | Notes |
|---------------|------------------------|------------------------------------------|-------|
| (none)        | —                      | —                                        | —     |

## 6. Interaction with Regression and Coverage

Tie advanced UVM features back to operations:

- **Jobs**: Sanity uses simple stream_seq only; core_nightly uses config (seed, coverage) and optional callbacks (mon_cb, sb_cb); stress_weekly uses virtual sequences (e.g., sys_stress_backpressure_vs) and callbacks for stats.  
- **Callbacks**: Enabled in core_nightly and stress_weekly for logging/stats; optional in sanity for speed.  
- **Coverage**: Config enables coverage collector; callbacks can drive coverage sampling hooks.  

Document examples:

- **Example**: core_nightly sets stream_env_cfg.enable_coverage=1 and registers mon_cb for coverage sampling; stress_weekly adds drv_cb for extra logging.  

## 7. Open Questions and Future Enhancements

Capture remaining ideas and unknowns:

- **Open**: Whether to add virtual sequencer to stream_env for multi-phase tests.  
- **Enhancements**: Fault injection callback for error tests; coverage sampling via monitor callback.  

## 8. Revision History

| Date       | Version | Author | Changes                         |
|------------|---------|--------|---------------------------------|
| 2026-02-05 | 0.1     | Yongfu | Initial advanced UVM plan for stream_fifo; config, callbacks, optional virtual seq |

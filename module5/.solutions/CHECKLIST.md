# Module 5 Checklist – Regression Management & Advanced UVM Orchestration

> **Purpose**: Track completion of Module 5 regression and orchestration tasks.

## 1. Pre-Reqs from Modules 1–4

- [x] Module 1–4 documents are reasonably complete and stable.  
- [x] Basic regressions already run (at least sanity/core) with coverage.  

## 2. Regression Jobs and Commands

- [x] Named regression jobs defined in `regression_ops.md` (sanity/core/stress/full or equivalent).  
- [x] For each job:
  - [x] Tiers and test selection rules documented.  
  - [x] Approximate runtime target documented.  
  - [x] Example command lines documented (local + CI/farm where applicable).  
- [x] Seed/randomization policy integrated into job definitions.  

## 3. CI / Farm Integration (Planning Level)

- [x] CI/farm mapping documented (which jobs run where and when).  
- [x] Artifact expectations documented (logs, coverage reports, summaries).  
- [x] Basic failure-handling policy for jobs documented (stop vs continue, reruns).  

## 4. Advanced UVM Orchestration

- [x] `advanced_uvm_plan.md` lists:
  - [x] Virtual sequencer(s) and controlled sequencers.  
  - [x] Virtual sequences mapped to high-level scenarios/tests.  
  - [x] Configuration object strategy (env/agent/test configs).  
  - [x] Planned callback targets and purposes.  
- [x] Interaction between advanced UVM features and regression jobs documented (which jobs use which features).  

## 5. Flakiness Management

- [x] Flake definition and detection criteria documented in `debug_flake_plan.md`.  
- [x] Rerun strategy documented (how many reruns, when, and why).  
- [x] Quarantine rules defined (when and how tests become quarantined and tracked).  

## 6. Debug and Observability

- [x] Logging conventions documented (prefixes, minimal required info).  
- [x] Waveform/trace dumping policy documented (when and how much).  
- [x] Standard debug workflow documented (steps to reproduce and triage failures).  

## 7. Performance Monitoring

- [x] Metrics to track documented (per-job, per-test runtimes, flake rates, etc.).  
- [x] Initial list of **slowest tests** identified (from early regressions).  
- [x] At least a few concrete optimization ideas recorded (e.g., shorter warm-ups, targeted stress).  

## 8. Review and Iteration

- [x] Regression and orchestration plans reviewed with peer/mentor or team.  
- [x] Feedback captured in `regression_ops.md` / `advanced_uvm_plan.md` / `debug_flake_plan.md`.  

## 9. Ready to Move to Module 6

- [x] You can explain:
  - [x] Which regression jobs exist and what they do.  
  - [x] How virtual sequences and advanced UVM features orchestrate scenarios.  
  - [x] How flakiness is detected and managed.  
  - [x] How developers and CI users debug failures using logs/waves/metadata.  
- [x] Regression flows are solid enough to support **ongoing coverage closure and sign-off work**.  


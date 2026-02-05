# Module 5 Checklist – Regression Management & Advanced UVM Orchestration

> **Purpose**: Track completion of Module 5 regression and orchestration tasks.

> **Instructions**: Check off items as you complete them. Copy from `module5/templates/` if needed, or edit the file in `module5/` directly. Reference: `module5/.solutions/`.

## 1. Pre-Reqs from Modules 1–4

- [ ] Module 1–4 documents are reasonably complete and stable.
- [ ] Basic regressions already run (at least sanity/core) with coverage.

## 2. Regression Jobs and Commands

- [ ] Named regression jobs defined in `regression_ops.md` (sanity/core/stress/full or equivalent).
- [ ] For each job:
  - [ ] Tiers and test selection rules documented.
  - [ ] Approximate runtime target documented.
  - [ ] Example command lines documented (local + CI/farm where applicable).
- [ ] Seed/randomization policy integrated into job definitions.

## 3. CI / Farm Integration (Planning Level)

- [ ] CI/farm mapping documented (which jobs run where and when).
- [ ] Artifact expectations documented (logs, coverage reports, summaries).
- [ ] Basic failure-handling policy for jobs documented (stop vs continue, reruns).

## 4. Advanced UVM Orchestration

- [ ] `advanced_uvm_plan.md` lists:
  - [ ] Virtual sequencer(s) and controlled sequencers.
  - [ ] Virtual sequences mapped to high-level scenarios/tests.
  - [ ] Configuration object strategy (env/agent/test configs).
  - [ ] Planned callback targets and purposes.
- [ ] Interaction between advanced UVM features and regression jobs documented (which jobs use which features).

## 5. Flakiness Management

- [ ] Flake definition and detection criteria documented in `debug_flake_plan.md`.
- [ ] Rerun strategy documented (how many reruns, when, and why).
- [ ] Quarantine rules defined (when and how tests become quarantined and tracked).

## 6. Debug and Observability

- [ ] Logging conventions documented (prefixes, minimal required info).
- [ ] Waveform/trace dumping policy documented (when and how much).
- [ ] Standard debug workflow documented (steps to reproduce and triage failures).

## 7. Performance Monitoring

- [ ] Metrics to track documented (per-job, per-test runtimes, flake rates, etc.).
- [ ] Initial list of **slowest tests** identified (from early regressions).
- [ ] At least a few concrete optimization ideas recorded (e.g., shorter warm-ups, targeted stress).

## 8. Review and Iteration

- [ ] Regression and orchestration plans reviewed with peer/mentor or team.
- [ ] Feedback captured in `regression_ops.md` / `advanced_uvm_plan.md` / `debug_flake_plan.md`.

## 9. Ready to Move to Module 6

- [ ] You can explain:
  - [ ] Which regression jobs exist and what they do.
  - [ ] How virtual sequences and advanced UVM features orchestrate scenarios.
  - [ ] How flakiness is detected and managed.
  - [ ] How developers and CI users debug failures using logs/waves/metadata.
- [ ] Regression flows are solid enough to support **ongoing coverage closure and sign-off work**.

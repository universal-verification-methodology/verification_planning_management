# Debug, Flakiness & Performance Plan (Module 5)

> **Purpose**: Define how you will detect, debug, and manage flaky tests, as well as monitor and improve regression performance.  
> **Module**: 5 – Regression Management & Advanced UVM Orchestration (SV/UVM)

## 1. Flake Definition and Detection

### 1.1 What is a Flaky Test Here?

Define criteria for a test being considered *flaky* in your environment, for example:

- Same test + same seed sometimes passes and sometimes fails.  
- Test outcome depends on non-deterministic factors (timing, environment).  
- Test intermittently times out without a clear DUT issue.

Document your specific criteria:

- **Flaky**: Same test name + same seed fails in one run and passes on rerun (or vice versa) with no code change.  
- **Flaky**: Failure rate > 0% and < 100% over multiple runs with same seed; root cause not DUT bug.  
- **Not flaky**: Consistently fails (real failure) or consistently passes (stable).  

### 1.2 Detection Signals

List signals/heuristics to detect flakiness:

- Intermittent failures in CI with no code change.  
- Failures that vanish when rerun with the same seed.  
- Timeouts that are not reproducible or tied to coverage/bug fixes.  

Describe how these are monitored:

- **CI**: Regression job runs all tests; failed tests are rerun once (same seed); if pass on rerun, mark as flaky and log.  
- **Tracking**: Flake count per test per job; flaky test list (e.g., `flake_list.txt` or CI tag) updated when flake detected.  
- **Review**: Periodic review of flaky list; root-cause analysis (timing, resource contention, uninitialized state).  

## 2. Rerun and Quarantine Policy

### 2.1 Rerun Strategy

Define how many times and under what conditions failing tests are rerun.

| Scenario                            | Reruns | Decision Rule                               |
|-------------------------------------|--------|---------------------------------------------|
| Single failure in core_nightly      | 1      | Rerun once with same seed; if pass, mark flaky; if fail, real failure |
| Repeated failures across builds     | 0      | Treat as real failure; no auto-rerun        |
| Timeout in stress_weekly            | 1      | Rerun once; if timeout again, mark failure and log for debug |

### 2.2 Quarantine Rules

Define how flaky tests are handled longer-term:

- **Quarantine**: Test is moved out of blocking tier (e.g., removed from core_nightly blocking list) when flake rate exceeds threshold (e.g., flaked in 2 of last 3 runs). Quarantined tests run in non-blocking job or tracked in separate list.  
- **Tracking**: Quarantine list in repo (e.g., `module5/quarantine_list.txt`) or CI tag; issue tracker link per test.  
- **Return**: Test returns to blocking tier when: (1) root cause fixed (test or env), (2) N consecutive passes in non-blocking run, (3) documented waiver if unfixable.  

Document:

- **Policy**: One rerun per failure; flaky tests added to quarantine list after detection; re-entry after fix and evidence.  

## 3. Logging and Observability

### 3.1 Logging Conventions

Define logging standards to aid debug:

- **Format**: Prefixes `[stream_test]`, `[stream_env]`, `[stream_driver]`, `[stream_monitor]`, `[stream_scoreboard]`; test ID and seed in first line.  
- **Minimum info in every failure log**:
  - Test name, tier/job, seed, DUT revision (commit/tag), simulator version.  
  - Last assertion/scoreboard error message and context.  
  - UVM verbosity and log level used.  

Describe:

- **Convention**: Use UVM component name as prefix; test sets seed and logs test name + seed at start; scoreboard/assertion failures include expected vs actual.  

### 3.2 Waveforms and Traces

Plan when and how to dump waveforms:

- **When**: On failure (optional auto-dump); for debug jobs with plusarg `+DUMP_WAVES=1`; for specific tiers (e.g., stress_weekly optional).  
- **Limitations**: Time window (e.g., last N cycles or around failure); signals of interest (DUT ports, key internal signals).  
- **Request**: Debug job or plusarg `+DUMP_WAVES=1`; or post-failure script to rerun with waves.  

Document:

- **Policy**: Default no waves for speed; enable via +DUMP_WAVES=1 for debug; CI can archive waves for failed tests only.  

## 4. Debug Workflow

Outline the standard steps when a regression fails.

Example:

1. Identify failing test(s) and seeds from regression summary.  
2. Inspect high-level log for assertion vs scoreboard vs timeout.  
3. Rerun locally or in a debug job with:
   - Same test + seed.  
   - Extra logging and/or waveforms enabled.  
4. Use standard tools (logs, waves, coverage reports) to narrow root cause.  
5. Decide: test bug vs DUT bug vs environment bug vs flake.

Customize this for your environment:

- **Steps**: (1) From CI summary, note test name and seed. (2) Open per-test log; check for UVM_ERROR, assertion message, or timeout. (3) Rerun locally: `./run_regression.sh --test <name> --seed <seed> --sim $SIM` with `+DUMP_WAVES=1` if needed. (4) Compare expected vs actual in scoreboard log; check assertion context. (5) Classify and file bug or flake; update quarantine if flake.  

## 5. Performance Monitoring and Optimization

### 5.1 Metrics to Track

Define what you will monitor:

- Per-job runtime (sanity, core_nightly, stress_weekly).  
- Per-test runtime (top N slowest tests).  
- Queue/wait times on farm (if applicable).  
- Pass/fail/flake counts per job.  

### 5.2 Optimization Tactics

List likely performance improvements:

- Adjusting iteration counts or traffic lengths in stress tests (e.g., reduce num_items in stress for faster sanity).  
- Using backdoor or direct stimulus where appropriate (stream_fifo has no registers; N/A for backdoor).  
- Tuning coverage sampling frequency (sample on transaction only, not every cycle).  
- Splitting or refactoring extremely heavy tests.  

Document specific ideas:

- **Stream FIFO**: Reduce stream_seq num_items for sanity; full length for stress. Coverage: sample in monitor on handshake only.  

## 6. Integration with CI and Reporting

Describe how flake and performance information will surface in CI:

- **Annotations**: CI job marks each test as pass / fail / flaky (e.g., "Flaky" badge or tag).  
- **Summary**: Dashboard shows runtime per job, flake rate, pass/fail count; link to logs and coverage.  
- **Links**: Per-test log link; wave link for failures (if archived); coverage report link.  

Notes:

- **Implementation**: Regression script outputs JUnit/XML or custom summary; CI parses and displays; flaky tests from rerun result; performance from timestamps in logs.  

## 7. Open Questions and Follow-Ups

Track unresolved decisions or future enhancements:

- **Open**: Exact CI YAML and artifact retention.  
- **Follow-ups**: Automate quarantine list update; add performance trend tracking.  

## 8. Revision History

| Date       | Version | Author | Changes                         |
|------------|---------|--------|---------------------------------|
| 2026-02-05 | 0.1     | Yongfu | Initial debug/flake plan for stream_fifo; flake definition, rerun, quarantine, logging, workflow |

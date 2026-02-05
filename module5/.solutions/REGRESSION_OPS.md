# Regression Operations (Module 5)

> **Purpose**: Define concrete regression flows, commands, and CI/farm integration.  
> **Module**: 5 – Regression Management & Advanced UVM Orchestration (SV/UVM)

## 1. Context

- **DUT / Project**: stream_fifo verification (Stream FIFO Verification); common_dut/rtl + module4/tb UVM env.  
- **Primary simulator(s)**: Verilator (or VCS/Questa/Xcelium as available).  
- **Earlier plans**:
  - Tiers and goals: `module2/REGRESSION_PLAN.md`  
  - Coverage & environment: `module3/COVERAGE_RUN.md`, `module4/ENV_DESIGN.md`  

This document turns those plans into **concrete jobs and commands**.

## 2. Regression Jobs

Define named jobs that can be invoked locally or from CI.

| Job Name        | Description                          | Tier(s)        | Approx Runtime | Intended Use          |
|-----------------|--------------------------------------|----------------|----------------|-----------------------|
| sanity          | Fast health check (smoke only)       | SANITY         | < 5 min        | Per-commit / pre-push |
| core_nightly    | Main regression (feature + error)   | CORE           | < 2 hours      | Nightly CI/farm       |
| stress_weekly   | Stress & long-run regression        | STRESS/FULL    | < 4–8 hours    | Weekly/weekend        |

Adjust job names/types to suit your project.

## 3. Command-Line Interfaces

Describe how to invoke regressions from the command line.

### 3.1 Local (Developer) Usage

Examples (adapt to your make/pytest/regression wrapper):

```bash
# Run sanity job locally
./run_regression.sh --job sanity --sim verilator --seed 1001

# Run specific test by name
./run_regression.sh --test smoke_basic_test --seed 1001

# Run core_nightly subset locally for debugging (limit to first N tests)
./run_regression.sh --job core_nightly --limit 20

# Run with coverage
./run_regression.sh --job core_nightly --coverage
```

Document your actual commands, options, and environment variables.

- **Assumed**: `run_regression.sh` (or equivalent) accepts `--job`, `--test`, `--sim`, `--seed`, `--limit`, `--coverage`. Environment: `PROJECT_ROOT`, `SIM` (simulator name).  

### 3.2 CI / Farm Usage

For each job, describe:

- **CI/Farm integration**: e.g., GitHub Actions, GitLab CI, Jenkins; trigger on push/PR or scheduled.  
- **Job definitions**: YAML (e.g., `.github/workflows/regression.yml`) or internal farm config.  
- **Parameters**: tier/job name, simulator, seed (fixed or matrix), DUT revision (commit/tag).  

Example (pseudo-YAML):

```yaml
job: sanity
  trigger: on-push, pull_request
  script:
    - ./run_regression.sh --job sanity --sim $SIM --tier SANITY
```

Replace with your actual CI configuration patterns.

## 4. Test Selection Rules

Specify how each job chooses tests (link to `module2/TEST_PLAN.md` where possible).

| Job Name      | Selection Rule (by ID/tag/metadata)                                     |
|---------------|--------------------------------------------------------------------------|
| sanity        | All tests with tier=SANITY: SMK_001, SMK_002, SMK_003                     |
| core_nightly  | All tests in tier=CORE: FTR_001–FTR_013, ERR_001–ERR_006                  |
| stress_weekly | All tier=STRESS (STR_001–STR_012, PERF_001–PERF_003) + STR_013 (FULL)    |

Document how tags/metadata are implemented (e.g., YAML lists, JSON config, plusargs).

- **Implementation**: Test list per tier in `module2/REGRESSION_PLAN.md`; regression script reads tier config (e.g., `regression_tiers.yaml`) or hardcoded test lists per job.  

## 5. Seeds and Randomization at Regression Level

Tie seed policy (from `module2/TEST_PLAN.md`) into jobs.

| Job Name      | Seed Policy                          | Notes                         |
|---------------|--------------------------------------|-------------------------------|
| sanity        | Fixed seeds (1001–1003)              | Deterministic; fast feedback  |
| core_nightly  | Fixed per test (2001–2013, 3001–3006 for FTR/ERR); optional one random seed per run | Reproducible + light exploration |
| stress_weekly | Varied seeds (random or date-based); seed logged per test               | Exploration; log for reproducibility |

Describe:

- **Generation**: Fixed from test ID; random from `$RANDOM` or build ID; logged in test log.  
- **Passing**: Plusarg `+UVM_SEED=<seed>` or env `UVM_SEED`.  
- **Logging**: Seed and test name in regression summary and per-test log for failure replay.  

## 6. Runtime and Parallelism

Summarize how you will meet runtime targets.

- **Parallelism**: Per-job parallelism (e.g., 4–8 workers for core_nightly) if farm allows; sanity often single-threaded for simplicity.  
- **Sharding**: By test ID or by suite; each worker runs a subset of tests; results merged.  
- **Constraints**: Simulator licenses, disk space for logs/waves; farm capacity.  

Example notes:

- Sanity: single runner, < 5 min. Core_nightly: up to N workers in parallel; target < 2 hours wall-clock. Stress_weekly: run overnight; optional parallel by test subset.  

## 7. Artifacts and Reporting

For each job, identify required outputs:

- **Logs**: Per-test log (e.g., `logs/<job>/<test>_<seed>.log`); job-level summary log.  
- **Coverage**: Coverage DB/report when `--coverage`; merge for core_nightly/stress_weekly.  
- **Summary**: Pass/fail count, flake count, runtime per test and total; optional JUnit/XML for CI.  

Document:

- **Storage**: e.g., `artifacts/<branch>/<date>/<job>/`; retention 7–30 days.  
- **Dashboards**: CI status badge; link to coverage report; link to failure logs.  

## 8. Failure Handling Policy

Define how regressions behave on failure:

- **Fail fast vs run all**: Sanity: fail on first failure (fast feedback). Core_nightly/stress_weekly: run all tests, then report; optional fail-fast mode for debug.  
- **Reruns**: Single automatic rerun for failed test (same seed); if pass on rerun, mark as flaky; if fail again, mark as failure. See `DEBUG_FLAKE_PLAN.md`.  
- **Flaky tracking**: Quarantine list or tag; flaky tests excluded from blocking tier until fixed.  

Write your policies:

- **Policy**: Sanity fails job on first failure. Core/stress: run all, then rerun failures once; flaky count reported. Quarantine: tests with flake rate above threshold moved to non-blocking list.  

## 9. Open Questions and Future Enhancements

Capture unresolved items:

- **Open**: Exact `run_regression.sh` interface and CI YAML location (project-specific).  
- **Enhancements**: Parallel sharding by test; coverage trend tracking; automatic quarantine from flake rate.  

## 10. Revision History

| Date       | Version | Author | Changes                         |
|------------|---------|--------|---------------------------------|
| 2026-02-05 | 0.1     | Yongfu | Initial regression ops for stream_fifo; jobs, seeds, artifacts, failure policy |

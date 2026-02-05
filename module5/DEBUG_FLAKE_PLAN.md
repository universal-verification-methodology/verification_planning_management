# Debug, Flakiness & Performance Plan (Module 5)

> **Purpose**: Define how you will detect, debug, and manage flaky tests, as well as monitor and improve regression performance.  
> **Module**: 5 – Regression Management & Advanced UVM Orchestration (SV/UVM)

> **Instructions**: Fill in this document for your design. Copy from `module5/templates/` if needed, or edit the file in `module5/` directly. Reference: `module5/.solutions/`.

## 1. Flake Definition and Detection

### 1.1 What is a Flaky Test Here?

<!-- TODO: Criteria for a test being considered flaky (same test+seed, intermittent, timeout). -->

### 1.2 Detection Signals

<!-- TODO: Signals/heuristics to detect flakiness; how they are monitored (CI, tracking, review). -->

## 2. Rerun and Quarantine Policy

### 2.1 Rerun Strategy

<!-- TODO: How many reruns, under what conditions; decision rules (pass on rerun = flaky, etc.). -->

### 2.2 Quarantine Rules

<!-- TODO: When tests are quarantined; tracking (list/CI tag); return criteria. -->

## 3. Logging and Observability

### 3.1 Logging Conventions

<!-- TODO: Format, prefixes, minimum info in every failure log. -->

### 3.2 Waveforms and Traces

<!-- TODO: When and how to dump waveforms; size/scope limits. -->

## 4. Debug Workflow

<!-- TODO: Steps to reproduce and triage failures; use of logs, waves, metadata. -->

## 5. Performance Monitoring and Optimization

<!-- TODO: Metrics to track (runtime, flake rate); slowest tests; optimization ideas. -->

## 6. Integration with CI and Reporting

<!-- TODO: How flake/debug info is reported in CI; dashboards, alerts. -->

## 7. Open Questions and Follow-Ups

<!-- TODO: Open items and planned actions. -->

## 8. Revision History

<!-- TODO: Document revisions. -->

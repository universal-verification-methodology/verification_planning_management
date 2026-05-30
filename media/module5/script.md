        # Narration script — Module 5: Regression Management & Advanced UVM Orchestration (SV/UVM)

        **Target length:** ~23 minutes (53 slides; auto-generated — edit per slide as needed)

        ## Timing table

        | Slide | Section | Duration | Narration |
|-------|---------|----------|-----------|
| 1 | Module 5 | 0:25 | Welcome to module 5, Regression Management & Advanced UVM Orchestration (SV/UVM). In this module you will turn your test, coverage, and environment designs into a robust regression system that scales: advanced sequence orchestration (including virtual sequences), flake management, ci integration, performance tuning, and coverage-driven refinement.. |
| 2 | Learning objectives | 0:16 | Here is what you will learn in this module. Turn your test, coverage, and environment designs into a robust regression system that scales: advanced sequence orchestration... |
| 3 | Prerequisites | 0:16 | Before you start, make sure you have these prerequisites. See module README |
| 4 | Learning path | 0:22 | Learning path. Turn your test, coverage, and environment designs into a robust regression system that scales: advanced sequence orchestration (including virtual sequences), flake management, CI integration... |
| 5 | Overview | 0:16 | Overview. Modules 1–4 established what to test, how to measure, and how to build a solid UVM environment. In Module 5, you focus on running that... |
| 6 | How to learn this module | 0:08 | Next section: How to learn this module. |
| 7 | Suggested learning path (1/2) | 0:32 | Follow this learning path. Read the guides before running the labs. Re-read module2/REGRESSION_PLAN.md and module4/ENV_DESIGN.md. Scaffold Module 5 workspace: ./scripts/module5.sh --scaffold Document regression ops in module5/REGRESSION_OPS.md and advanced UVM in ADVANCED_UVM_PLAN.md. Plan flake handling in DEBUG_FLAKE_PLAN.md. Implement virtual sequences, callbacks, or config patterns in... |
| 8 | Suggested learning path (2/2) | 0:16 | Follow this learning path. Read the guides before running the labs. Validate: ./scripts/module5.sh --check From docs/MODULE5.md — read guides before running demos. |
| 9 | Design architecture | 0:08 | Next section: Design architecture. |
| 10 | 1. Regression system architecture | 0:30 | 1. Regression system architecture. Local quick loops, CI gated merges, optional farm for long suites (REGRESSION_OPS.md). Regression launcher selects tier → test list → seeds → coverage merge → report artifacts. Refer to the diagram on the right. |
| 11 | 2. Advanced UVM orchestration | 0:34 | 2. Advanced UVM orchestration. Virtual sequences coordinate multiple agents (e.g., concurrent source/sink traffic). Callbacks and config DB patterns for mode switches without rewriting tests. Documented in ADVANCED_UVM_PLAN.md; implemented under common_dut/tb/. Refer to the diagram on the right. |
| 12 | 3. Regression launch and triage pipeline | 0:32 | 3. Regression launch and triage pipeline. Launch: tier script selects test list, seeds, plusargs, and parallelism level. Execute: each test produces log, optional waveform, and coverage database. Collect: merge coverage, aggregate pass/fail, and flag timeouts or assertion failures. Triage: reproduce with saved seed; use DEBUG_FLAKE_PLAN.md for intermittent failures. Report: publish tier... |
| 13 | Monitor — analysis port | 0:28 | Monitor — analysis port. Review the code on screen and match it to files in the repository. |
| 14 | stream_test — run_phase | 0:28 | stream_test — run_phase. Review the code on screen and match it to files in the repository. |
| 15 | Key files to study | 0:08 | Next section: Key files to study. |
| 16 | Open these in the repo | 0:32 | Open these in the repo. module5/REGRESSION_OPS.md — tiers, launchers, CI/farm integration module5/ADVANCED_UVM_PLAN.md — virtual sequences, callbacks, config DB usage module5/DEBUG_FLAKE_PLAN.md — flake detection, quarantine, debug workflow module4/tb/stream_pkg.sv — monitor, test, and sequence patterns to extend scripts/module5.sh — regression and advanced-UVM doc checks Trace while running... |
| 17 | Verification & testing methods | 0:08 | Next section: Verification & testing methods. |
| 18 | 1. Operational regression testing | 0:30 | 1. Operational regression testing. Every tier has target runtime, pass criteria, and artifact retention (logs, waves, coverage DB). Failures triaged with reproducible seeds and minimized waveforms. Refer to the diagram on the right. |
| 19 | 2. Flake and performance management | 0:20 | 2. Flake and performance management. DEBUG_FLAKE_PLAN.md — detect flaky tests, quarantine policy, timeout budgets. Performance tuning: parallel jobs, test ordering, and dropping redundant long tests. |
| 20 | 3. Data-driven refinement | 0:20 | 3. Data-driven refinement. Use regression + coverage history to prioritize new tests and retire low-value ones. ./scripts/module5.sh --check validates ops and advanced-UVM planning docs. |
| 21 | Module 5 — regression validation | 0:28 | Module 5 — regression validation. Review the code on screen and match it to files in the repository. |
| 22 | Syllabus topics | 0:08 | Next section: Syllabus topics. |
| 23 | 1. Concrete Regression Flows (1/2) | 0:36 | 1. Concrete Regression Flows (1/2). Local vs CI vs Farm Developer “inner loop” (fast, focused subsets). CI per-commit/per-PR runs (sanity + selected CORE tests). Nightly/weekly farm runs (CORE/STRESS/FULL tiers). Command-Line Interfaces |
| 24 | 1. Concrete Regression Flows (2/2) | 0:28 | 1. Concrete Regression Flows (2/2). Passing seeds, tiers, and configuration via plusargs/env/CLI options. Job Definitions Defining named regression jobs (e.g., sanity, core_nightly, stress_weekly). Mapping jobs to tiers, test lists, and resource limits. |
| 25 | 2. Advanced UVM Orchestration (Virtual Sequences & Multi-Age | 0:36 | 2. Advanced UVM Orchestration (Virtual Sequences & Multi-Agent) (1/2). Virtual Sequencers & Virtual Sequences Coordinating multiple agents (e.g., data + control + sideband). Layered sequences that correspond to system-level scenarios. Mapping to Test Plan Mapping high-level test intents to virtual sequences. |
| 26 | 2. Advanced UVM Orchestration (Virtual Sequences & Multi-Age | 0:24 | 2. Advanced UVM Orchestration (Virtual Sequences & Multi-Agent) (2/2). Configuration & Callbacks Using complex configuration objects to parameterize regressions. Using callbacks to inject debug behavior or temporary instrumentation. |
| 27 | 3. Flake Management and Stability (1/2) | 0:36 | 3. Flake Management and Stability (1/2). Flaky Test Identification Signals of flakiness (non-deterministic failures, timeouts). Logging and metadata needed to diagnose flakiness (test ID, seed, environment). Policies Criteria for marking a test as flaky. |
| 28 | 3. Flake Management and Stability (2/2) | 0:28 | 3. Flake Management and Stability (2/2). Automatic rerun strategies (e.g., N-of-M reruns to confirm flakiness). Designing Flake-Resistant Tests Avoiding hidden dependencies on timing or environment. Ensuring proper resets and deterministic seeding. |
| 29 | 4. Debug & Observability Strategy (1/2) | 0:36 | 4. Debug & Observability Strategy (1/2). Logging Standardized log formats (prefixes, IDs, levels). Per-test log collection and retention policies. Waveforms and Traces When to dump waves (always for failures, selectively for passes). |
| 30 | 4. Debug & Observability Strategy (2/2) | 0:24 | 4. Debug & Observability Strategy (2/2). Failure Triage Workflow Quick checks (assertion vs scoreboard vs timeout). Reproduction steps (same test, same seed, smaller subset). |
| 31 | 5. Performance and Scalability (1/2) | 0:36 | 5. Performance and Scalability (1/2). Bottleneck Identification Longest-running tests and why. Hot spots in sequences, drivers, or reference models. Optimization Strategies Reducing redundant work (e.g., fewer warm-up cycles, targeted stress). |
| 32 | 5. Performance and Scalability (2/2) | 0:24 | 5. Performance and Scalability (2/2). Regression Capacity Planning Estimating how many tests can run per hour/day. Planning parallelism and job sharding. |
| 33 | 6. Coverage-Driven Regression Refinement | 0:36 | 6. Coverage-Driven Regression Refinement. Using Coverage to Shape Regressions Prioritizing tests that contribute most to coverage gaps. Designing “closure suites” for specific coverage areas. Bug-Driven Refinement Using bug history to prioritize tests and sequences. |
| 34 | Command reference highlights | 0:08 | Next section: Command reference highlights. |
| 35 | Scaffold and validate Module 5 | 0:16 | Scaffold and validate Module 5. ./scripts/module5.sh --scaffold Full detail in docs/MODULE5.md command reference. |
| 36 | Inspect test run_phase and monitor hooks | 0:16 | Inspect test run_phase and monitor hooks. grep -n "class stream_test" module4/tb/stream_pkg.sv Full detail in docs/MODULE5.md command reference. |
| 37 | Hands-on examples | 0:08 | Next section: Hands-on examples. |
| 38 | Module 5 self-check | 0:45 | Module 5 self-check. Watch the terminal output and confirm you see the expected pass message. |
| 39 | Exercise scaffold | 0:28 | Exercise scaffold. Review the code on screen and match it to files in the repository. |
| 40 | Demo: Regression operations template | 0:45 | Demo: Regression operations template. Watch the terminal output and confirm you see the expected pass message. |
| 41 | Demo: Debug and flake plan | 0:45 | Demo: Debug and flake plan. Watch the terminal output and confirm you see the expected pass message. |
| 42 | Demo: Advanced UVM plan | 0:45 | Demo: Advanced UVM plan. Watch the terminal output and confirm you see the expected pass message. |
| 43 | Demo: Reference regression ops | 0:45 | Demo: Reference regression ops. Watch the terminal output and confirm you see the expected pass message. |
| 44 | Demo: Module validation | 0:45 | Demo: Module validation. Watch the terminal output and confirm you see the expected pass message. |
| 45 | Practice & assessment | 0:08 | Next section: Practice & assessment. |
| 46 | What you should know (1/5) | 0:36 | By now you should be able to explain the following. Define and run repeatable regression flows across local and CI/farm environments. Use virtual sequences and advanced UVM patterns to orchestrate complex scenarios. Detect, triage, and manage flaky tests and instability in regressions. Implement a practical debug and observability strategy (logs, waves, metadata). Use coverage and bug data to... |
| 47 | What you should know (2/5) | 0:36 | By now you should be able to explain the following. A sanity job (fast, per-commit). A core_nightly job. A stress_weekly or full_release job. For each job, specify: Tier(s), test selection rules, expected runtime, and invocation commands. From MODULE5 Learning Outcomes. |
| 48 | What you should know (3/5) | 0:36 | By now you should be able to explain the following. Specific virtual sequences and their participating agents/sequencers. Key configuration parameters (modes, seeds, error-injection toggles). Identify at least 3 scenarios that require multi-agent coordination. In module5/DEBUG_FLAKE_PLAN.md, define: What constitutes a flake in your context. From MODULE5 Learning Outcomes. |
| 49 | What you should know (4/5) | 0:36 | By now you should be able to explain the following. How you quarantine and track flaky tests. How/when they must be fixed before sign-off. Define: Standard log naming and locations. When and how to generate waveforms. From MODULE5 Learning Outcomes. |
| 50 | What you should know (5/5) | 0:16 | By now you should be able to explain the following. Verify on at least one failing test that you can reproduce and debug using these artifacts. From MODULE5 Learning Outcomes. |
| 51 | Exercises | 0:24 | Exercises. Runtime Tuning Coverage-Driven Job Resilience Drill |
| 52 | Assessment checklist | 0:28 | Assessment checklist. Concrete regression jobs and commands captured in module5/REGRESSION_OPS.md. Virtual sequence and advanced UVM usage planned in module5/ADVANCED_UVM_PLAN.md. Flake and debug strategy documented in module5/DEBUG_FLAKE_PLAN.md. Regression flows demonstrably support coverage and sign-off goals. |
| 53 | Summary & next steps | 0:28 | In summary: Turn your test, coverage, and environment designs into a robust regression system that scales: advanced sequence orchestration (including virtual sequences), flake management, CI integration, performance tuning, and coverage-driven refinement. Next up: Next module in course. Turn your test, coverage, and environment designs into a robust regression system that scales: advanced... |

        ## Section narration (edit for TTS)

        - **How to learn:** Re-read `module2/REGRESSION_PLAN.md` and `module4/ENV_DESIGN.md`. Then Scaffold Module 5 workspace: `./scripts/module5.sh --scaffold` Then Document regression ops in `module5/REGRESSION_OPS.md` and advanced UVM in `ADVANCED_UVM_PLAN.md`. Then Plan flake handling in `DEBUG_FLAKE_PLAN.md`..
- **Design architecture (Regression system architecture, Advanced UVM orchestration, Regression launch and triage pipeline):** Walk through the block diagram, then relate each block to files under module5/examples/.
- **Verification (Operational regression testing, Flake and performance management, Data-driven refinement):** Explain what stimulus is applied, what is checked, and what is intentionally out of scope.
- **Syllabus:** Cover 6 topic section(s) — pause on protocol timing and signals.
- **Before exercises:** Ask learners to recall the learning outcomes slide; they should explain each bullet in their own words.
- **Hands-on:** Run module5/EXAMPLES.md labs; narrate expected PASS lines.

        ## Notes

        - Slides from **Before You Start**, **Design Architecture**, **Verification & Testing Methods**, **Topics Covered**, **EXAMPLES.md**, and **Learning Outcomes**.
        - Full detail: `docs/MODULE5.md` and `module5/EXAMPLES.md`.
        - Regenerate: `regenerate_course_outlines.sh <course_root> --module 5`

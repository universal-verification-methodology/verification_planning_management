        # Narration script — Module 2: Test Planning & Strategy in Depth (SV/UVM)

        **Target length:** ~24 minutes (54 slides; auto-generated — edit per slide as needed)

        ## Timing table

        | Slide | Section | Duration | Narration |
|-------|---------|----------|-----------|
| 1 | Module 2 | 0:25 | Welcome to module 2, Test Planning & Strategy in Depth (SV/UVM). In this module you will turn your initial verification plan into a detailed, reviewable test strategy, with a structured test catalogue, negative/stress planning, and an initial regression tiering concept for your verilog dut and sv/uvm environment.. |
| 2 | Learning objectives | 0:16 | Here is what you will learn in this module. Turn your initial verification plan into a detailed, reviewable test strategy, with a structured test catalogue, negative/stress... |
| 3 | Prerequisites | 0:16 | Before you start, make sure you have these prerequisites. See module README |
| 4 | Learning path | 0:22 | Learning path. Turn your initial verification plan into a detailed, reviewable test strategy, with a structured test catalogue, negative/stress planning, and an initial regression tiering concept for your... |
| 5 | Overview | 0:16 | Overview. Module 1 gave you a high-level verification plan, scope, and early test catalogue. In this module, you will: |
| 6 | How to learn this module | 0:08 | Next section: How to learn this module. |
| 7 | Suggested learning path (1/2) | 0:32 | Follow this learning path. Read the guides before running the labs. Re-read module1/VERIFICATION_PLAN.md and module1/REQUIREMENTS_MATRIX.md. Scaffold Module 2 workspace if needed: ./scripts/module2.sh --scaffold Fill module2/TEST_PLAN.md, REGRESSION_PLAN.md, and optionally refine COVERAGE_PLAN.md. Map each test intent to a future UVM test name, sequence, and regression tier. Validate... |
| 8 | Suggested learning path (2/2) | 0:16 | Follow this learning path. Read the guides before running the labs. Complete module2/CHECKLIST.md before Module 3. From docs/MODULE2.md — read guides before running demos. |
| 9 | Design architecture | 0:08 | Next section: Design architecture. |
| 10 | 1. UVM environment skeleton | 0:34 | 1. UVM environment skeleton. common_dut/tb/stream_fifo_env_skeleton.sv — env + agent stubs (source/sink agents). Hierarchy: uvm_test → stream_fifo_env → agents → (future) driver, sequencer, monitor. Interfaces tie to DUT ports via virtual interfaces or pin-level connections in the top testbench. Refer to the diagram on the right. |
| 11 | 2. Test-plan ↔ TB mapping | 0:34 | 2. Test-plan ↔ TB mapping. TEST_PLAN.md catalogue entries map to UVM tests, sequences, and config knobs. REGRESSION_PLAN.md defines tiers that will eventually select subsets of tests. Naming conventions (SMK_, FTR_, ERR_) link documentation to future uvm_test names. Refer to the diagram on the right. |
| 12 | 3. Test execution mapping (planning level) | 0:28 | 3. Test execution mapping (planning level). Each catalogue row specifies: UVM test class, base sequence, plusargs/seeds, and regression tier. Smoke tests map to short directed sequences; stress tests map to long-run or backpressure scenarios. Error-injection tests document illegal handshake or overflow/underflow stimulus intent. ./scripts/module2.sh --check confirms test plan sections and TB... |
| 13 | Handshake logic (push/pop) | 0:28 | Handshake logic (push/pop). Review the code on screen and match it to files in the repository. |
| 14 | Agent stub — build_phase | 0:28 | Agent stub — build_phase. Review the code on screen and match it to files in the repository. |
| 15 | Key files to study | 0:08 | Next section: Key files to study. |
| 16 | Open these in the repo | 0:36 | Open these in the repo. module2/TEST_PLAN.md — detailed test catalogue and taxonomy module2/REGRESSION_PLAN.md — tier definitions and pass/fail policy module2/COVERAGE_PLAN.md — coverage intent linked to tests common_dut/tb/stream_fifo_env_skeleton.sv — env hierarchy your tests will target common_dut/rtl/stream_fifo.sv — handshake and status behavior to test Trace while running... |
| 17 | Verification & testing methods | 0:08 | Next section: Verification & testing methods. |
| 18 | 1. Test taxonomy | 0:34 | 1. Test taxonomy. Smoke/sanity — fast checks after every change; feature — per-requirement depth. Stress / long-run — backlog pressure, sustained traffic; error injection — overflow, underflow, illegal sequences. Each type documents expected runtime class and whether seeds are fixed or varied. Refer to the diagram on the right. |
| 19 | 2. Regression tiering (planning level) | 0:24 | 2. Regression tiering (planning level). Assign every catalogue test to sanity, core, stress, or full tiers. Document pass/fail policy preview and which negative tests are safe for frequent runs. ./scripts/module2.sh --check verifies plan completeness and TB skeleton presence. |
| 20 | 3. Reproducibility | 0:16 | 3. Reproducibility. Plan seed strategy, constraint overrides, and plusargs per test for debuggable random runs. |
| 21 | Module 2 — scaffold and check | 0:28 | Module 2 — scaffold and check. Review the code on screen and match it to files in the repository. |
| 22 | Syllabus topics | 0:08 | Next section: Syllabus topics. |
| 23 | 1. Test Taxonomy and Structure (1/2) | 0:36 | 1. Test Taxonomy and Structure (1/2). Test Types Smoke/sanity vs feature vs stress vs error-injection vs performance (if applicable). Directed vs constrained-random vs scenario-based tests. Tiers and Frequency Per-commit / pre-push tests. |
| 24 | 1. Test Taxonomy and Structure (2/2) | 0:28 | 1. Test Taxonomy and Structure (2/2). Weekly full or long-running suites. Mapping to UVM How test types relate to UVM tests and sequences. Using configuration objects / plusargs / factory overrides to specialize tests. |
| 25 | 2. Test Catalogue Refinement (1/2) | 0:36 | 2. Test Catalogue Refinement (1/2). From List to Catalogue Expanding the initial 10–20 test intents into a more complete catalogue. Grouping tests by feature, interface, or requirement group. Naming and Metadata Test ID conventions (e.g., SMK_, FTR_, STR_, ERR_ prefixes). |
| 26 | 2. Test Catalogue Refinement (2/2) | 0:24 | 2. Test Catalogue Refinement (2/2). Redundancy and Value Identifying overlapping tests and merging where reasonable. Distinguishing “coverage-driving” tests vs “regression guardrail” tests. |
| 27 | 3. Negative, Stress, and Corner-Case Planning (1/2) | 0:36 | 3. Negative, Stress, and Corner-Case Planning (1/2). Negative Testing Illegal sequences, protocol violations, out-of-range values. Malformed packets/transactions, timing violations (where meaningful). Stress and Long-Run Scenarios High-load / long-duration tests. |
| 28 | 3. Negative, Stress, and Corner-Case Planning (2/2) | 0:28 | 3. Negative, Stress, and Corner-Case Planning (2/2). Corner Cases Boundary values, wrap-around conditions, reset-in-the-middle, mode transitions. Instrumentation Needs What additional checks, monitors, or assertions are needed to support these tests. |
| 29 | 4. Seeds, Constraints, and Reproducibility (1/2) | 0:36 | 4. Seeds, Constraints, and Reproducibility (1/2). Seed Strategy When to fix seeds vs vary them. How to record seeds for debugging and reproducibility. Constraints and Randomization Control High-level constraints in sequences vs constraint overrides per test. |
| 30 | 4. Seeds, Constraints, and Reproducibility (2/2) | 0:24 | 4. Seeds, Constraints, and Reproducibility (2/2). Test Parameters and Configurations Using UVM configuration database, plusargs, or config files. Planning for parametrization (e.g., data width, depth, mode). |
| 31 | 5. Regression Tiering and Policies (Planning Level) (1/2) | 0:36 | 5. Regression Tiering and Policies (Planning Level) (1/2). Regression Tiers Tier definitions (e.g., sanity, core_feature, stress, full). Target runtimes and approximate test counts for each tier. Test Assignment Mapping each test in the catalogue to one or more tiers. |
| 32 | 5. Regression Tiering and Policies (Planning Level) (2/2) | 0:24 | 5. Regression Tiering and Policies (Planning Level) (2/2). Pass/Fail Policies (Preview) What counts as a pass, fail, flake. Basic quarantine strategy for flaky tests (details in later modules). |
| 33 | 6. Coordination with Coverage and Requirements | 0:36 | 6. Coordination with Coverage and Requirements. Closing Loops with Requirements Ensuring each high-priority requirement has enough tests (not just one). Verifying that tests exercise planned coverage points. Coverage-Driven Test Gaps Identifying missing tests from coverage perspective (e.g., unhit bins). |
| 34 | Command reference highlights | 0:08 | Next section: Command reference highlights. |
| 35 | Scaffold and validate Module 2 | 0:16 | Scaffold and validate Module 2. ./scripts/module2.sh --scaffold Full detail in docs/MODULE2.md command reference. |
| 36 | Review test and regression templates | 0:16 | Review test and regression templates. head -40 module2/templates/TEST_PLAN.md Full detail in docs/MODULE2.md command reference. |
| 37 | Hands-on examples | 0:08 | Next section: Hands-on examples. |
| 38 | Module 2 self-check | 0:45 | Module 2 self-check. Watch the terminal output and confirm you see the expected pass message. |
| 39 | Exercise scaffold | 0:28 | Exercise scaffold. Review the code on screen and match it to files in the repository. |
| 40 | Demo: Test plan template | 0:45 | Demo: Test plan template. Watch the terminal output and confirm you see the expected pass message. |
| 41 | Demo: Regression plan template | 0:45 | Demo: Regression plan template. Watch the terminal output and confirm you see the expected pass message. |
| 42 | Demo: Coverage plan template | 0:45 | Demo: Coverage plan template. Watch the terminal output and confirm you see the expected pass message. |
| 43 | Demo: Reference test plan | 0:45 | Demo: Reference test plan. Watch the terminal output and confirm you see the expected pass message. |
| 44 | Demo: Module validation | 0:45 | Demo: Module validation. Watch the terminal output and confirm you see the expected pass message. |
| 45 | Practice & assessment | 0:08 | Next section: Practice & assessment. |
| 46 | What you should know (1/6) | 0:36 | By now you should be able to explain the following. Design a structured test taxonomy tailored to your DUT and UVM environment. Maintain a rich test catalogue with clear metadata and priorities. Plan explicit negative, stress, and corner-case tests. Define initial regression tiers and assign tests to them. Explain how your test plan supports requirements coverage and coverage closure. From... |
| 47 | What you should know (2/6) | 0:36 | By now you should be able to explain the following. Test types with definitions and examples. Tiers (sanity, core, stress, full) with expected runtime budgets. For at least 10 existing tests from Module 1, assign: Type, tier, and expected runtime. Grow your catalogue to 25–40 tests (intents), focusing on: From MODULE2 Learning Outcomes. |
| 48 | What you should know (3/6) | 0:36 | By now you should be able to explain the following. Interface/protocol scenarios. Mode and configuration combinations. Identify at least 3 redundant or low-value tests and: Merge or remove them, documenting the decision. Add at least: From MODULE2 Learning Outcomes. |
| 49 | What you should know (4/6) | 0:36 | By now you should be able to explain the following. 3 stress or long-run tests. For each, define: Preconditions and exact stimuli. Expected behavior (including assertions/flags). Special logging or debug support needed. From MODULE2 Learning Outcomes. |
| 50 | What you should know (5/6) | 0:36 | By now you should be able to explain the following. Which tests will run with fixed vs varying seeds. How seeds will be passed (e.g., plusargs, config). Document this in module2/TEST_PLAN.md and update module1/REQUIREMENTS_MATRIX.md if needed. In module2/REGRESSION_PLAN.md, define: Tier names, cadence (per-commit, nightly, weekly), and runtime targets. From MODULE2 Learning Outcomes. |
| 51 | What you should know (6/6) | 0:20 | By now you should be able to explain the following. For each test in your catalogue, add a column indicating: Primary tier(s) it belongs to. From MODULE2 Learning Outcomes. |
| 52 | Exercises | 0:24 | Exercises. Runtime Budgeting Flake-Resistance Design Traceability Check |
| 53 | Assessment checklist | 0:36 | Assessment checklist. Has a written test taxonomy and tier definition. Test catalogue expanded and de-duplicated with clear metadata. Negative, stress, and corner-case tests are explicitly planned. Seed and randomness policy is documented. A draft regression plan exists with test-to-tier mapping. |
| 54 | Summary & next steps | 0:28 | In summary: Turn your initial verification plan into a detailed, reviewable test strategy, with a structured test catalogue, negative/stress planning, and an initial regression tiering concept for your Verilog DUT and SV/UVM environment. Next up: Coverage Planning & Analysis in Practice. Turn your initial verification plan into a detailed, reviewable test strategy, with a structured test... |

        ## Section narration (edit for TTS)

        - **How to learn:** Re-read `module1/VERIFICATION_PLAN.md` and `module1/REQUIREMENTS_MATRIX.md`. Then Scaffold Module 2 workspace if needed: `./scripts/module2.sh --scaffold` Then Fill `module2/TEST_PLAN.md`, `REGRESSION_PLAN.md`, and optionally refine `COVERAGE_PLAN.md`. Then Map each test intent to a future UVM test name, sequence, and regression tier..
- **Design architecture (UVM environment skeleton, Test-plan ↔ TB mapping, Test execution mapping (planning level)):** Walk through the block diagram, then relate each block to files under module2/examples/.
- **Verification (Test taxonomy, Regression tiering (planning level), Reproducibility):** Explain what stimulus is applied, what is checked, and what is intentionally out of scope.
- **Syllabus:** Cover 6 topic section(s) — pause on protocol timing and signals.
- **Before exercises:** Ask learners to recall the learning outcomes slide; they should explain each bullet in their own words.
- **Hands-on:** Run module2/EXAMPLES.md labs; narrate expected PASS lines.

        ## Notes

        - Slides from **Before You Start**, **Design Architecture**, **Verification & Testing Methods**, **Topics Covered**, **EXAMPLES.md**, and **Learning Outcomes**.
        - Full detail: `docs/MODULE2.md` and `module2/EXAMPLES.md`.
        - Regenerate: `regenerate_course_outlines.sh <course_root> --module 2`

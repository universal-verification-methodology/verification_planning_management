        # Narration script — Module 3: Coverage Planning & Analysis in Practice (SV/UVM)

        **Target length:** ~24 minutes (54 slides; auto-generated — edit per slide as needed)

        ## Timing table

        | Slide | Section | Duration | Narration |
|-------|---------|----------|-----------|
| 1 | Module 3 | 0:25 | Welcome to module 3, Coverage Planning & Analysis in Practice (SV/UVM). In this module you will design and implement a practical coverage model (functional + code), connect it to your uvm environment and test plan, and perform first real coverage analysis and gap-closing cycles on your verilog dut.. |
| 2 | Learning objectives | 0:16 | Here is what you will learn in this module. Design and implement a practical coverage model (functional + code), connect it to your UVM environment and test plan, and perform first... |
| 3 | Prerequisites | 0:16 | Before you start, make sure you have these prerequisites. See module README |
| 4 | Learning path | 0:22 | Learning path. Design and implement a practical coverage model (functional + code), connect it to your UVM environment and test plan, and perform first real coverage analysis and gap-closing cycles on your... |
| 5 | Overview | 0:16 | Overview. Modules 1–2 focused on what to test and how to structure tests and regressions. Module 3 turns coverage from a conceptual plan into a... |
| 6 | How to learn this module | 0:08 | Next section: How to learn this module. |
| 7 | Suggested learning path (1/2) | 0:32 | Follow this learning path. Read the guides before running the labs. Re-open module2/TEST_PLAN.md and module2/COVERAGE_PLAN.md. Scaffold Module 3 workspace: ./scripts/module3.sh --scaffold Design covergroups in module3/COVERAGE_DESIGN.md and plan runs in COVERAGE_RUN.md. Implement or review common_dut/tb/stream_fifo_coverage.sv covergroup definitions. Run a small CORE-tier regression and... |
| 8 | Suggested learning path (2/2) | 0:16 | Follow this learning path. Read the guides before running the labs. Validate: ./scripts/module3.sh --check From docs/MODULE3.md — read guides before running demos. |
| 9 | Design architecture | 0:08 | Next section: Design architecture. |
| 10 | 1. Coverage in the UVM environment | 0:34 | 1. Coverage in the UVM environment. Functional coverage lives in common_dut/tb/stream_fifo_coverage.sv (covergroups, crosses). Monitors/agents sample transactions that feed coverpoints (fill level, handshake patterns, errors). COVERAGE_DESIGN.md is the authoritative map from requirements → coverpoints → tests. Refer to the diagram on the right. |
| 11 | 2. Code coverage integration | 0:30 | 2. Code coverage integration. Simulator line/branch/FSM coverage configured in your run scripts (documented in COVERAGE_RUN.md). Separate functional vs code coverage roles: intent vs implementation exercised. Refer to the diagram on the right. |
| 12 | 3. Coverage run and merge pipeline | 0:28 | 3. Coverage run and merge pipeline. Run: select CORE-tier tests → enable functional + code coverage in simulator → save per-test databases. Merge: combine run databases into a session or regression snapshot for analysis. Analyze: compare merged coverage against goals in COVERAGE_PLAN.md; record gaps in COVERAGE_RUN.md. Close: add targeted tests or refine coverpoints; re-run until must-cover... |
| 13 | Coverage model — covergroups | 0:28 | Coverage model — covergroups. Review the code on screen and match it to files in the repository. |
| 14 | Key files to study | 0:08 | Next section: Key files to study. |
| 15 | Open these in the repo | 0:32 | Open these in the repo. module3/COVERAGE_DESIGN.md — coverpoints, crosses, and requirement mapping module3/COVERAGE_RUN.md — run logs, merge steps, and gap analysis notes common_dut/tb/stream_fifo_coverage.sv — functional coverage implementation module2/COVERAGE_PLAN.md — coverage goals and tier linkage scripts/module3.sh — coverage design and TB presence checks Trace while running... |
| 16 | Verification & testing methods | 0:08 | Next section: Verification & testing methods. |
| 17 | 1. Coverage-driven verification (CDV) | 0:30 | 1. Coverage-driven verification (CDV). Run a CORE-tier regression subset, merge coverage, and compare against goals in COVERAGE_PLAN.md. Use gap analysis to add targeted tests or relax/remove low-value bins — not blind random runs. Refer to the diagram on the right. |
| 18 | 2. Closure loop | 0:20 | 2. Closure loop. Requirements → tests → coverpoints → measured bins → updated plan/tests. ./scripts/module3.sh --check expects covergroup references and coverage design docs. |
| 19 | 3. Reporting discipline | 0:16 | 3. Reporting discipline. Log each run in COVERAGE_RUN.md with tool, seed, tier, and top uncovered items. |
| 20 | sample() integration point | 0:28 | sample() integration point. Review the code on screen and match it to files in the repository. |
| 21 | Module 3 — coverage checks | 0:28 | Module 3 — coverage checks. Review the code on screen and match it to files in the repository. |
| 22 | Syllabus topics | 0:08 | Next section: Syllabus topics. |
| 23 | 1. From Coverage Plan to Concrete Model | 0:36 | 1. From Coverage Plan to Concrete Model. Refinement of Coverage Goals Translating high-level goals into specific covergroups and bins. Deciding which metrics are *must-hit* vs *nice-to-have*. Coverage Model Structure Organizing covergroups by feature, interface, or component. |
| 24 | 2. Functional Coverage Implementation (SV/UVM) (1/2) | 0:36 | 2. Functional Coverage Implementation (SV/UVM) (1/2). Covergroup Basics covergroup declaration, sampling events (@), and options. Coverpoints: bins, ranges, wildcards, ignore/illegal bins. Cross coverage: when and how to cross (and when not to). Sampling Strategy |
| 25 | 2. Functional Coverage Implementation (SV/UVM) (2/2) | 0:28 | 2. Functional Coverage Implementation (SV/UVM) (2/2). Avoiding oversampling/undersampling. Integration with UVM Components Embedding covergroups in monitors/scoreboards. Using analysis ports/exports for coverage sampling. |
| 26 | 3. Code Coverage Setup and Interpretation (1/2) | 0:36 | 3. Code Coverage Setup and Interpretation (1/2). Enabling Code Coverage Turning on statement/branch/toggle coverage in your simulator. Handling compile-time options and run-time switches. Interpreting Results Reading coverage reports and understanding common metrics. |
| 27 | 3. Code Coverage Setup and Interpretation (2/2) | 0:24 | 3. Code Coverage Setup and Interpretation (2/2). Managing Exclusions Identifying truly unreachable code. Documenting exclusions and waivers with rationale. |
| 28 | 4. Running Coverage-Enabled Regressions (1/2) | 0:36 | 4. Running Coverage-Enabled Regressions (1/2). Pilot Regressions Start with a modest CORE-tier run (not full regression). Ensure coverage data collection is working end-to-end. Merging Coverage Combining coverage from multiple tests/regressions. |
| 29 | 4. Running Coverage-Enabled Regressions (2/2) | 0:20 | 4. Running Coverage-Enabled Regressions (2/2). Automating Coverage Collection Hooks in your regression/CI scripts to generate coverage databases/reports. |
| 30 | 5. Coverage Analysis and Gap Closure (1/3) | 0:36 | 5. Coverage Analysis and Gap Closure (1/3). Gap Identification Finding unhit or low-hit coverpoints and crosses. Detecting missing or ineffective coverage (bins that never can be hit). Root-Cause Analysis Is the gap due to: |
| 31 | 5. Coverage Analysis and Gap Closure (2/3) | 0:36 | 5. Coverage Analysis and Gap Closure (2/3). Overly tight constraints? Incomplete coverage model? Truly unreachable or out-of-scope functionality? Closure Actions Adding or modifying tests (directed or constrained-random). |
| 32 | 5. Coverage Analysis and Gap Closure (3/3) | 0:20 | 5. Coverage Analysis and Gap Closure (3/3). Refining or pruning coverage points. Documenting waivers where appropriate. |
| 33 | 6. Connecting Coverage to Requirements and Sign-off (1/2) | 0:36 | 6. Connecting Coverage to Requirements and Sign-off (1/2). Traceability Ensuring high-priority requirements are covered by both tests and coverage. Updating REQUIREMENTS_MATRIX.md with coverage IDs and status. Interpreting Coverage for Sign-off Understanding when “100% coverage” is meaningful (and when it isn’t). |
| 34 | 6. Connecting Coverage to Requirements and Sign-off (2/2) | 0:20 | 6. Connecting Coverage to Requirements and Sign-off (2/2). Preparing for Later Modules How coverage insights will influence later regression and sign-off modules. |
| 35 | Command reference highlights | 0:08 | Next section: Command reference highlights. |
| 36 | Scaffold and validate Module 3 | 0:16 | Scaffold and validate Module 3. ./scripts/module3.sh --scaffold Full detail in docs/MODULE3.md command reference. |
| 37 | Inspect coverage model in TB | 0:16 | Inspect coverage model in TB. head -60 common_dut/tb/stream_fifo_coverage.sv Full detail in docs/MODULE3.md command reference. |
| 38 | Hands-on examples | 0:08 | Next section: Hands-on examples. |
| 39 | Module 3 self-check | 0:45 | Module 3 self-check. Watch the terminal output and confirm you see the expected pass message. |
| 40 | Exercise scaffold | 0:28 | Exercise scaffold. Review the code on screen and match it to files in the repository. |
| 41 | Demo: Coverage design template | 0:45 | Demo: Coverage design template. Watch the terminal output and confirm you see the expected pass message. |
| 42 | Demo: Coverage run log template | 0:45 | Demo: Coverage run log template. Watch the terminal output and confirm you see the expected pass message. |
| 43 | Demo: TB coverage skeleton | 0:45 | Demo: TB coverage skeleton. Watch the terminal output and confirm you see the expected pass message. |
| 44 | Demo: Reference coverage design | 0:45 | Demo: Reference coverage design. Watch the terminal output and confirm you see the expected pass message. |
| 45 | Demo: Module validation | 0:45 | Demo: Module validation. Watch the terminal output and confirm you see the expected pass message. |
| 46 | Practice & assessment | 0:08 | Next section: Practice & assessment. |
| 47 | What you should know (1/5) | 0:36 | By now you should be able to explain the following. Design and implement a concrete functional coverage model for your DUT. Enable and collect code coverage from your simulator. Run coverage-enabled regressions and interpret coverage reports. Perform a structured coverage gap analysis and plan closure actions. Tie coverage results back to requirements and sign-off criteria. From MODULE3... |
| 48 | What you should know (2/5) | 0:36 | By now you should be able to explain the following. For each, implement: At least one covergroup with meaningful coverpoints. At least one useful cross (if warranted). Integrate sampling into your UVM monitor/scoreboard. Verify that bins are being hit in basic tests (e.g., SANITY/CORE tests). From MODULE3 Learning Outcomes. |
| 49 | What you should know (3/5) | 0:36 | By now you should be able to explain the following. Run a small set of tests (e.g., SANITY or a subset of CORE). Generate and inspect the coverage report. Identify: Any obvious coverage gaps in well-understood code. Any code that appears to be unreachable or out-of-scope. From MODULE3 Learning Outcomes. |
| 50 | What you should know (4/5) | 0:36 | By now you should be able to explain the following. Date, DUT version, test set/tier, seed policy, simulator version. Key coverage metrics (summary) and major observations. List at least 5 concrete coverage gaps and your initial hypotheses. For at least 3 significant gaps: Decide whether to: add tests, tune constraints, refine coverage, or waive. From MODULE3 Learning Outcomes. |
| 51 | What you should know (5/5) | 0:28 | By now you should be able to explain the following. Update: module2/TEST_PLAN.md (new/updated tests). module2/COVERAGE_PLAN.md / module3/COVERAGE_DESIGN.md. module1/REQUIREMENTS_MATRIX.md (coverage mappings, waivers). From MODULE3 Learning Outcomes. |
| 52 | Exercises | 0:24 | Exercises. Over-Coverage vs Under-Coverage Coverage vs Bug History (if available) Tooling Experiment |
| 53 | Assessment checklist | 0:32 | Assessment checklist. Functional coverage model implemented for key features/interfaces. Code coverage successfully enabled and reports generated. At least one coverage run documented in COVERAGE_RUN.md. Coverage gaps identified and categorized (test/constraint/model/waiver). Closure actions planned and reflected in test/coverage/requirements docs. |
| 54 | Summary & next steps | 0:28 | In summary: Design and implement a practical coverage model (functional + code), connect it to your UVM environment and test plan, and perform first real coverage analysis and gap-closing cycles on your Verilog DUT. Next up: UVM Environment and Checker Maturity. Design and implement a practical coverage model (functional + code), connect it to your UVM environment and test plan, and perform... |

        ## Section narration (edit for TTS)

        - **How to learn:** Re-open `module2/TEST_PLAN.md` and `module2/COVERAGE_PLAN.md`. Then Scaffold Module 3 workspace: `./scripts/module3.sh --scaffold` Then Design covergroups in `module3/COVERAGE_DESIGN.md` and plan runs in `COVERAGE_RUN.md`. Then Implement or review `common_dut/tb/stream_fifo_coverage.sv` covergroup definitions..
- **Design architecture (Coverage in the UVM environment, Code coverage integration, Coverage run and merge pipeline):** Walk through the block diagram, then relate each block to files under module3/examples/.
- **Verification (Coverage-driven verification (CDV), Closure loop, Reporting discipline):** Explain what stimulus is applied, what is checked, and what is intentionally out of scope.
- **Syllabus:** Cover 6 topic section(s) — pause on protocol timing and signals.
- **Before exercises:** Ask learners to recall the learning outcomes slide; they should explain each bullet in their own words.
- **Hands-on:** Run module3/EXAMPLES.md labs; narrate expected PASS lines.

        ## Notes

        - Slides from **Before You Start**, **Design Architecture**, **Verification & Testing Methods**, **Topics Covered**, **EXAMPLES.md**, and **Learning Outcomes**.
        - Full detail: `docs/MODULE3.md` and `module3/EXAMPLES.md`.
        - Regenerate: `regenerate_course_outlines.sh <course_root> --module 3`

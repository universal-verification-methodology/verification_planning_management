        # Narration script — Module 4: UVM Environment & Checker Maturity (SV/UVM)

        **Target length:** ~18 minutes (44 slides; auto-generated — edit per slide as needed)

        ## Timing table

        | Slide | Section | Duration | Narration |
|-------|---------|----------|-----------|
| 1 | Module 4 | 0:25 | Welcome to module 4, UVM Environment & Checker Maturity (SV/UVM). In this module you will design and mature your uvm environment (env, agents, drivers, monitors, sequencers) and checking strategy (scoreboards, reference models, protocol/functional assertions) so that your test and coverage plans from earlier modules can be executed reliably at scale.. |
| 2 | Learning objectives | 0:16 | Here is what you will learn in this module. Design and mature your UVM environment (env, agents, drivers, monitors, sequencers) and checking strategy (scoreboards, reference... |
| 3 | Prerequisites | 0:16 | Before you start, make sure you have these prerequisites. See module README |
| 4 | Learning path | 0:22 | Learning path. Design and mature your UVM environment (env, agents, drivers, monitors, sequencers) and checking strategy (scoreboards, reference models, protocol/functional assertions) so that your test and... |
| 5 | Overview | 0:16 | Overview. Modules 1–3 focused on planning (scope, tests, regressions) and measurement (coverage). In Module 4, you focus on the quality and... |
| 6 | How to learn this module | 0:08 | Next section: How to learn this module. |
| 7 | Suggested learning path (1/2) | 0:32 | Follow this learning path. Read the guides before running the labs. Re-read module2/TEST_PLAN.md and module3/COVERAGE_DESIGN.md. Scaffold Module 4 workspace: ./scripts/module4.sh --scaffold Complete module4/ENV_DESIGN.md (agents, transactions, connectivity). Complete module4/CHECKER_PLAN.md (scoreboard, reference model, SVA split). Implement or refine UVM components in module4/tb/ and... |
| 8 | Suggested learning path (2/2) | 0:16 | Follow this learning path. Read the guides before running the labs. Validate: ./scripts/module4.sh --check From docs/MODULE4.md — read guides before running demos. |
| 9 | Design architecture | 0:08 | Next section: Design architecture. |
| 10 | 1. Mature UVM environment (stream_fifo) | 0:38 | 1. Mature UVM environment (stream_fifo). Env (stream_fifo_env): connects source/sink agents, scoreboard, coverage subscribers. Agents: driver + sequencer + monitor per interface; active vs passive roles documented in ENV_DESIGN.md. Transactions: item fields mirror DUT handshake semantics (data, valid/ready timing). Reference implementation sketch: module4/tb/tb_stream_fifo_uvm.sv and... |
| 11 | 2. Checking architecture | 0:34 | 2. Checking architecture. Scoreboard / reference model — golden data path and ordering checks (CHECKER_PLAN.md). SVA — protocol and functional assertions on interfaces and internal flags. Clear split: what is checked in SVA vs scoreboard vs test self-check. Refer to the diagram on the right. |
| 12 | 3. UVM phase execution flow | 0:32 | 3. UVM phase execution flow. build_phase: create env, agents, scoreboard, coverage subscribers via factory. connect_phase: connect monitor analysis ports to scoreboard and coverage; tie virtual interfaces. run_phase: raise objection, start sequences on sequencers, wait for drain, drop objection. report_phase: summarize errors, assertion failures, and coverage sampling status. Top module... |
| 13 | DUT instantiation in UVM top | 0:28 | DUT instantiation in UVM top. Review the code on screen and match it to files in the repository. |
| 14 | stream_env — build & connect | 0:28 | stream_env — build & connect. Review the code on screen and match it to files in the repository. |
| 15 | Scoreboard write() hook | 0:28 | Scoreboard write() hook. Review the code on screen and match it to files in the repository. |
| 16 | Key files to study | 0:08 | Next section: Key files to study. |
| 17 | Open these in the repo | 0:36 | Open these in the repo. module4/ENV_DESIGN.md — env, agent, driver, monitor, sequencer design module4/CHECKER_PLAN.md — scoreboard, reference model, and assertion strategy module4/tb/stream_pkg.sv — reference UVM package (env, agents, scoreboard) module4/tb/tb_stream_fifo_uvm.sv — top-level UVM testbench and DUT hookup common_dut/rtl/stream_fifo.sv — DUT under verification Trace while running... |
| 18 | Verification & testing methods | 0:08 | Next section: Verification & testing methods. |
| 19 | 1. Stimulus and checking flow | 0:30 | 1. Stimulus and checking flow. Sequences → driver → DUT → monitor → scoreboard compare and assertion sampling. Reset, backpressure, and error-injection scenarios exercised per TEST_PLAN.md. Refer to the diagram on the right. |
| 20 | 2. Assertion-based verification (ABV) | 0:20 | 2. Assertion-based verification (ABV). Place assertions close to interfaces; use assert/assume policy consistent with your simulator flow. Document waiver and severity policy for known benign cases. |
| 21 | 3. Environment review | 0:20 | 3. Environment review. Peer/self review of ENV_DESIGN.md and CHECKER_PLAN.md before expanding regression scope. ./scripts/module4.sh --check validates design docs and TB file presence. |
| 22 | stream_test — run_phase | 0:28 | stream_test — run_phase. Review the code on screen and match it to files in the repository. |
| 23 | Syllabus topics | 0:08 | Next section: Syllabus topics. |
| 24 | 1. Environment and Agent Architecture | 0:20 | 1. Environment and Agent Architecture. Environment and agent architecture (env vs agents vs tests). Layered testbench structure and reuse across tiers and DUT variants. |
| 25 | 2. Transactions and Sequences | 0:20 | 2. Transactions and Sequences. Transaction and sequence design aligned with your test plan. Mapping test intents to UVM sequences and configuration. |
| 26 | 3. Drivers and Monitors | 0:16 | 3. Drivers and Monitors. Driver and monitor behavior, including resets, backpressure, and error handling. |
| 27 | 4. Scoreboards and Reference Models | 0:16 | 4. Scoreboards and Reference Models. Scoreboard and reference model design. |
| 28 | 5. Assertions and Checking Strategy | 0:16 | 5. Assertions and Checking Strategy. Assertion strategy: what to check with SVA vs scoreboards vs tests. |
| 29 | Command reference highlights | 0:08 | Next section: Command reference highlights. |
| 30 | Scaffold and validate Module 4 | 0:16 | Scaffold and validate Module 4. ./scripts/module4.sh --scaffold Full detail in docs/MODULE4.md command reference. |
| 31 | Inspect UVM env and scoreboard | 0:16 | Inspect UVM env and scoreboard. head -80 module4/tb/stream_pkg.sv Full detail in docs/MODULE4.md command reference. |
| 32 | Hands-on examples | 0:08 | Next section: Hands-on examples. |
| 33 | Module 4 self-check | 0:45 | Module 4 self-check. Watch the terminal output and confirm you see the expected pass message. |
| 34 | Exercise scaffold | 0:28 | Exercise scaffold. Review the code on screen and match it to files in the repository. |
| 35 | Demo: Environment design template | 0:45 | Demo: Environment design template. Watch the terminal output and confirm you see the expected pass message. |
| 36 | Demo: Checker plan template | 0:45 | Demo: Checker plan template. Watch the terminal output and confirm you see the expected pass message. |
| 37 | Demo: Module-local UVM TB | 0:45 | Demo: Module-local UVM TB. Watch the terminal output and confirm you see the expected pass message. |
| 38 | Demo: Reference env design | 0:45 | Demo: Reference env design. Watch the terminal output and confirm you see the expected pass message. |
| 39 | Demo: Module validation | 0:45 | Demo: Module validation. Watch the terminal output and confirm you see the expected pass message. |
| 40 | Practice & assessment | 0:08 | Next section: Practice & assessment. |
| 41 | What you should know (1/2) | 0:36 | By now you should be able to explain the following. Describe and justify your UVM environment and agent architecture. Implement and maintain drivers, monitors, sequencers, and transactions that match your DUT and test plan. Implement or integrate scoreboards and reference models for robust checking. Design and place protocol and functional assertions that support your verification goals... |
| 42 | What you should know (2/2) | 0:28 | By now you should be able to explain the following. Transaction and sequence designs documented and aligned with module2/TEST_PLAN.md. Scoreboards and reference models specified in module4/CHECKER_PLAN.md. Key protocol/functional assertions listed and placed. At least one env/checker review (self or peer) completed; action items captured. From MODULE4 Learning Outcomes. |
| 43 | Assessment checklist | 0:32 | Assessment checklist. UVM env/agent architecture documented in module4/ENV_DESIGN.md. Transaction and sequence designs documented and aligned with module2/TEST_PLAN.md. Scoreboards and reference models specified in module4/CHECKER_PLAN.md. Key protocol/functional assertions listed and placed. At least one env/checker review (self or peer) completed; action items captured. |
| 44 | Summary & next steps | 0:28 | In summary: Design and mature your UVM environment (env, agents, drivers, monitors, sequencers) and checking strategy (scoreboards, reference models, protocol/functional assertions) so that your test and coverage plans from earlier modules can be executed reliably at scale. Next up: Next module in course. Design and mature your UVM environment (env, agents, drivers, monitors, sequencers) and... |

        ## Section narration (edit for TTS)

        - **How to learn:** Re-read `module2/TEST_PLAN.md` and `module3/COVERAGE_DESIGN.md`. Then Scaffold Module 4 workspace: `./scripts/module4.sh --scaffold` Then Complete `module4/ENV_DESIGN.md` (agents, transactions, connectivity). Then Complete `module4/CHECKER_PLAN.md` (scoreboard, reference model, SVA split)..
- **Design architecture (Mature UVM environment (stream_fifo), Checking architecture, UVM phase execution flow):** Walk through the block diagram, then relate each block to files under module4/examples/.
- **Verification (Stimulus and checking flow, Assertion-based verification (ABV), Environment review):** Explain what stimulus is applied, what is checked, and what is intentionally out of scope.
- **Syllabus:** Cover 5 topic section(s) — pause on protocol timing and signals.
- **Before exercises:** Ask learners to recall the learning outcomes slide; they should explain each bullet in their own words.
- **Hands-on:** Run module4/EXAMPLES.md labs; narrate expected PASS lines.

        ## Notes

        - Slides from **Before You Start**, **Design Architecture**, **Verification & Testing Methods**, **Topics Covered**, **EXAMPLES.md**, and **Learning Outcomes**.
        - Full detail: `docs/MODULE4.md` and `module4/EXAMPLES.md`.
        - Regenerate: `regenerate_course_outlines.sh <course_root> --module 4`

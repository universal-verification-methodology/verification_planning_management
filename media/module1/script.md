        # Narration script — Module 1: Verification Planning & Management Foundations (SV/UVM)

        **Target length:** ~26 minutes (57 slides; auto-generated — edit per slide as needed)

        ## Timing table

        | Slide | Section | Duration | Narration |
|-------|---------|----------|-----------|
| 1 | Module 1 | 0:25 | Welcome to module 1, Verification Planning & Management Foundations (SV/UVM). In this module you will learn how to turn a dut specification into a concrete verification plan, with clear strategy, coverage intent, and regression approach, using verilog duts and systemverilog/uvm testbenches.. |
| 2 | Learning objectives | 0:16 | Here is what you will learn in this module. Learn how to turn a DUT specification into a concrete verification plan, with clear strategy, coverage intent, and regression approach... |
| 3 | Prerequisites | 0:16 | Before you start, make sure you have these prerequisites. See module README |
| 4 | Learning path | 0:22 | Learning path. Learn how to turn a DUT specification into a concrete verification plan, with clear strategy, coverage intent, and regression approach, using Verilog DUTs and SystemVerilog/UVM testbenches. |
| 5 | Overview | 0:16 | Overview. This module establishes the foundation for verification planning and management. Instead of starting from coding UVM components, you... |
| 6 | How to learn this module | 0:08 | Next section: How to learn this module. |
| 7 | Suggested learning path (1/2) | 0:32 | Follow this learning path. Read the guides before running the labs. Read this module doc and module1/README.md for objectives and workspace layout. Scaffold planning files if needed: ./scripts/module1.sh --scaffold Edit module1/VERIFICATION_PLAN.md and module1/REQUIREMENTS_MATRIX.md from templates. Inspect shared DUT RTL at common_dut/rtl/stream_fifo.sv and the TB skeleton under... |
| 8 | Suggested learning path (2/2) | 0:16 | Follow this learning path. Read the guides before running the labs. Complete module1/CHECKLIST.md before starting Module 2. From docs/MODULE1.md — read guides before running demos. |
| 9 | Design architecture | 0:08 | Next section: Design architecture. |
| 10 | 1. Stream FIFO DUT (shared course RTL) | 0:42 | 1. Stream FIFO DUT (shared course RTL). Course DUT: common_dut/rtl/stream_fifo.sv — parameterizable DEPTH and DATA_WIDTH. Source interface: s_valid, s_ready, s_data (push when both valid and ready). Sink interface: m_valid, m_ready, m_data (pop on handshake). Internal storage: circular buffer (mem, wr_ptr, rd_ptr, count). Refer to the diagram on the right. |
| 11 | 2. Planning-level verification view (Module 1) | 0:34 | 2. Planning-level verification view (Module 1). No full UVM implementation required yet — document intended env boundaries in VERIFICATION_PLAN.md. REQUIREMENTS_MATRIX.md traces features → future tests and coverage bins. common_dut/tb/ holds skeleton stubs so architecture decisions are concrete, not abstract. Refer to the diagram on the right. |
| 12 | 3. Repository layout and planning workflow | 0:32 | 3. Repository layout and planning workflow. Inputs: DUT spec, course README, Module 1 templates and optional solutions. Workspace: edit module1/*.md planning documents directly in the repository. Shared RTL/TB: common_dut/ holds the physical DUT and skeleton env reused in later modules. Validation loop: edit plan → run ./scripts/module1.sh --check → fix TODOs → checklist sign-off. Outputs... |
| 13 | DUT — stream_fifo ports | 0:28 | DUT — stream_fifo ports. Review the code on screen and match it to files in the repository. |
| 14 | UVM env skeleton | 0:28 | UVM env skeleton. Review the code on screen and match it to files in the repository. |
| 15 | Key files to study | 0:08 | Next section: Key files to study. |
| 16 | Open these in the repo (1/2) | 0:36 | Open these in the repo (1/2). module1/VERIFICATION_PLAN.md — verification strategy, scope, and test intents module1/REQUIREMENTS_MATRIX.md — requirements-to-test traceability module1/templates/ — empty templates for a fresh start module1/.solutions/ — reference solutions (optional comparison) common_dut/rtl/stream_fifo.sv — shared course DUT (stream FIFO) Trace while running... |
| 17 | Open these in the repo (2/2) | 0:16 | Open these in the repo (2/2). scripts/module1.sh — validation and scaffold orchestrator Trace while running module1/EXAMPLES.md labs. |
| 18 | Verification & testing methods | 0:08 | Next section: Verification & testing methods. |
| 19 | 1. Planning-first methodology | 0:34 | 1. Planning-first methodology. Start from spec → scope → strategy before writing large amounts of testbench code. Use risk-based prioritization to decide what to verify first in later modules. Separate verification objectives (quality/risk) from implementation details. Refer to the diagram on the right. |
| 20 | 2. Test intent and validation (Module 1) | 0:24 | 2. Test intent and validation (Module 1). Capture test intents (names, goals, tiers) in the verification plan — not full UVM tests yet. Directed vs constrained-random choices are documented with rationale for the FIFO DUT. Self-check: ./scripts/module1.sh --check validates planning artifacts; simulation is optional. |
| 21 | 3. Early closure thinking | 0:20 | 3. Early closure thinking. Sketch functional coverage intent and regression tiers (sanity / nightly / full) for later modules. Define sign-off preview criteria (coverage goals, bug bars) in the plan from day one. |
| 22 | Module 1 — validation commands | 0:28 | Module 1 — validation commands. Review the code on screen and match it to files in the repository. |
| 23 | Syllabus topics | 0:08 | Next section: Syllabus topics. |
| 24 | 1. Verification Mindset and Goals (1/2) | 0:36 | 1. Verification Mindset and Goals (1/2). Design vs Verification What verification is responsible for (and what it is not). “Bug-finding” vs “quality and risk management”. Verification Objectives Proving conformance to spec (as far as practical). |
| 25 | 1. Verification Mindset and Goals (2/2) | 0:28 | 1. Verification Mindset and Goals (2/2). Balancing schedule, quality, and resources. UVM/SV Context Why constrained-random and coverage-driven verification (CDV) matter. Where SV/UVM and Verilog DUTs fit in the overall flow. |
| 26 | 2. From Specification to Verification Scope (1/2) | 0:36 | 2. From Specification to Verification Scope (1/2). Requirements Intake Extracting verifiable requirements from a product/design spec. Identifying interfaces, modes, configurations, and corner cases. Capturing assumptions and dependencies (e.g., upstream/downstream blocks, firmware behavior). In-Scope vs Out-of-Scope |
| 27 | 2. From Specification to Verification Scope (2/2) | 0:28 | 2. From Specification to Verification Scope (2/2). Handling legacy behavior, debug features, and low-priority modes. Risk-Based Prioritization High-risk vs low-risk features. Safety/criticality, complexity, novelty, and usage frequency. |
| 28 | 3. Verification Strategy (SV/UVM Focus) (1/2) | 0:36 | 3. Verification Strategy (SV/UVM Focus) (1/2). Strategy Dimensions Directed vs constrained-random vs scenario-based testing. Use of reference models, assertions, and protocol checkers. Layered testbench and reuse (block/IP → subsystem → SoC). UVM Testbench Architecture Concepts |
| 29 | 3. Verification Strategy (SV/UVM Focus) (2/2) | 0:32 | 3. Verification Strategy (SV/UVM Focus) (2/2). Mapping features and scenarios to sequences and configuration knobs. Choosing Strategies for the DUT For a FIFO: corner-case heavy, error injection, stress tests. For a bus/reg block: protocol correctness, access patterns, error responses. For a UART: timing, framing/parity errors, flow control. |
| 30 | 3. Verification flow | 0:22 | 3. Verification flow. Stimulus, observation, and check strategy for this module. |
| 31 | 4. Test Planning and Test Catalogue Basics (1/2) | 0:36 | 4. Test Planning and Test Catalogue Basics (1/2). Test Intent vs Test Implementation Writing test descriptions at the intent level (what to prove). Mapping intents to one or more concrete UVM tests/sequences. Test Types and Tiers Smoke/sanity vs feature tests vs stress/error-injection. |
| 32 | 4. Test Planning and Test Catalogue Basics (2/2) | 0:24 | 4. Test Planning and Test Catalogue Basics (2/2). Early Test Catalogue Building a first-pass list of 10–20 key tests/intents from the spec. Tagging each with requirements, priority, and expected coverage impact. |
| 33 | 5. Coverage Planning Primer (1/2) | 0:36 | 5. Coverage Planning Primer (1/2). Why Coverage is Central to Planning Functional vs code coverage and their roles. “Coverage as a question”: what do you need to know to sleep at night? Sketching Coverage Models Listing features, modes, and scenarios that deserve covergroups. |
| 34 | 5. Coverage Planning Primer (2/2) | 0:24 | 5. Coverage Planning Primer (2/2). Defining Initial Coverage Goals Setting measurable but realistic targets. Separating “must cover” from “nice to have”. |
| 35 | 6. Intro to Regression and Sign-off Thinking | 0:36 | 6. Intro to Regression and Sign-off Thinking. Regression at a High Level Why we need repeatable, automated regressions. Basic tiers (sanity / nightly / full). Sign-off Preview Types of sign-off criteria: coverage, bug bars, waivers, stability. |
| 36 | Command reference highlights | 0:08 | Next section: Command reference highlights. |
| 37 | Scaffold planning workspace | 0:16 | Scaffold planning workspace. ./scripts/module1.sh --scaffold Full detail in docs/MODULE1.md command reference. |
| 38 | Validate Module 1 artifacts | 0:16 | Validate Module 1 artifacts. ./scripts/module1.sh --check Full detail in docs/MODULE1.md command reference. |
| 39 | Inspect templates and shared DUT | 0:16 | Inspect templates and shared DUT. head -30 module1/templates/VERIFICATION_PLAN.md Full detail in docs/MODULE1.md command reference. |
| 40 | Hands-on examples | 0:08 | Next section: Hands-on examples. |
| 41 | Module 1 self-check | 0:45 | Module 1 self-check. Watch the terminal output and confirm you see the expected pass message. |
| 42 | Exercise scaffold | 0:28 | Exercise scaffold. Review the code on screen and match it to files in the repository. |
| 43 | Demo: Verification plan template | 0:45 | Demo: Verification plan template. Watch the terminal output and confirm you see the expected pass message. |
| 44 | Demo: Requirements matrix template | 0:45 | Demo: Requirements matrix template. Watch the terminal output and confirm you see the expected pass message. |
| 45 | Demo: Reference solution | 0:45 | Demo: Reference solution. Watch the terminal output and confirm you see the expected pass message. |
| 46 | Demo: Shared DUT RTL | 0:45 | Demo: Shared DUT RTL. Watch the terminal output and confirm you see the expected pass message. |
| 47 | Demo: Module validation | 0:45 | Demo: Module validation. Watch the terminal output and confirm you see the expected pass message. |
| 48 | Practice & assessment | 0:08 | Next section: Practice & assessment. |
| 49 | What you should know (1/6) | 0:36 | By now you should be able to explain the following. Explain the role of verification and its relationship to design. Turn a DUT specification into a verification scope with clear assumptions and boundaries. Draft a verification strategy for a simple Verilog DUT and SV/UVM environment. Create an initial test catalogue (test intents) linked to requirements. Sketch a coverage plan (what to... |
| 50 | What you should know (2/6) | 0:36 | By now you should be able to explain the following. Given a short DUT spec (e.g., FIFO or UART), list: Functional requirements (what the DUT must do). Non-functional/quality requirements (throughput, latency constraints, etc.). Assumptions and environment constraints. Classify each requirement as must-have, nice-to-have, or future. From MODULE1 Learning Outcomes. |
| 51 | What you should know (3/6) | 0:36 | By now you should be able to explain the following. Choose your DUT (FIFO / UART / AXI-lite block / your own). In module1/VERIFICATION_PLAN.md, add sections for: Objectives and success criteria. High-level SV/UVM environment concept (env, agents, scoreboard, reference model). Use of directed, random, and scenario-based tests. From MODULE1 Learning Outcomes. |
| 52 | What you should know (4/6) | 0:36 | By now you should be able to explain the following. Keep the strategy to 1–2 pages maximum. Create a table with columns: Test ID Test name Intent / description From MODULE1 Learning Outcomes. |
| 53 | What you should know (5/6) | 0:36 | By now you should be able to explain the following. Priority (H/M/L) Type (smoke/feature/stress/error) Populate at least 10 test intents for your DUT. From your requirement list and test catalogue, identify: Signals/fields that deserve coverpoints (e.g., addresses, opcodes, status flags, error types). From MODULE1 Learning Outcomes. |
| 54 | What you should know (6/6) | 0:24 | By now you should be able to explain the following. Write a brief description (no code required yet) of: Where each covergroup would live in the UVM testbench (monitor, scoreboard, etc.). What hitting those bins would tell you about verification completeness. From MODULE1 Learning Outcomes. |
| 55 | Exercises | 0:24 | Exercises. Scope and Risk Matrix Assumption Log UVM Architecture Sketch |
| 56 | Assessment checklist | 0:36 | Assessment checklist. Can explain verification’s role and goals in the SV/UVM context. Has produced a written verification scope (in-scope, out-of-scope, assumptions). Has a concise verification strategy document for the chosen DUT. Has an initial test catalogue with traceability to requirements. Has a high-level coverage plan (what to cover and why). |
| 57 | Summary & next steps | 0:28 | In summary: Learn how to turn a DUT specification into a concrete verification plan, with clear strategy, coverage intent, and regression approach, using Verilog DUTs and SystemVerilog/UVM testbenches. Next up: Test Planning & Strategy in Depth. Learn how to turn a DUT specification into a concrete verification plan, with clear strategy, coverage intent, and regression approach... Complete... |

        ## Section narration (edit for TTS)

        - **How to learn:** Read this module doc and `module1/README.md` for objectives and workspace layout. Then Scaffold planning files if needed: `./scripts/module1.sh --scaffold` Then Edit `module1/VERIFICATION_PLAN.md` and `module1/REQUIREMENTS_MATRIX.md` from templates. Then Inspect shared DUT RTL at `common_dut/rtl/stream_fifo.sv` and the TB skeleton under `common_dut/tb/`..
- **Design architecture (Stream FIFO DUT (shared course RTL), Planning-level verification view (Module 1), Repository layout and planning workflow):** Walk through the block diagram, then relate each block to files under module1/examples/.
- **Verification (Planning-first methodology, Test intent and validation (Module 1), Early closure thinking):** Explain what stimulus is applied, what is checked, and what is intentionally out of scope.
- **Syllabus:** Cover 6 topic section(s) — pause on protocol timing and signals.
- **Before exercises:** Ask learners to recall the learning outcomes slide; they should explain each bullet in their own words.
- **Hands-on:** Run module1/EXAMPLES.md labs; narrate expected PASS lines.

        ## Notes

        - Slides from **Before You Start**, **Design Architecture**, **Verification & Testing Methods**, **Topics Covered**, **EXAMPLES.md**, and **Learning Outcomes**.
        - Full detail: `docs/MODULE1.md` and `module1/EXAMPLES.md`.
        - Regenerate: `regenerate_course_outlines.sh <course_root> --module 1`

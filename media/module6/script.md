        # Narration script — Module 6: Complex Multi-Agent & Protocol Testbenches (SV/UVM)

        **Target length:** ~16 minutes (41 slides; auto-generated — edit per slide as needed)

        ## Timing table

        | Slide | Section | Duration | Narration |
|-------|---------|----------|-----------|
| 1 | Module 6 | 0:25 | Welcome to module 6, Complex Multi-Agent & Protocol Testbenches (SV/UVM). In this module you will apply your planning, environment, and regression skills to complex multi-agent, protocol-heavy testbenches (e.g., axi-like, multi-channel interfaces), focusing on architecture, protocol checking, and maintainability.. |
| 2 | Learning objectives | 0:16 | Here is what you will learn in this module. Apply your planning, environment, and regression skills to complex multi-agent, protocol-heavy testbenches (e.g., AXI-like... |
| 3 | Prerequisites | 0:16 | Before you start, make sure you have these prerequisites. See module README |
| 4 | Learning path | 0:22 | Learning path. Apply your planning, environment, and regression skills to complex multi-agent, protocol-heavy testbenches (e.g., AXI-like, multi-channel interfaces), focusing on architecture, protocol checking... |
| 5 | Overview | 0:16 | Overview. By Module 6, you have: |
| 6 | How to learn this module | 0:08 | Next section: How to learn this module. |
| 7 | Suggested learning path | 0:32 | Follow this learning path. Read the guides before running the labs. Re-read module4/ENV_DESIGN.md and module5/REGRESSION_OPS.md. Scaffold Module 6 workspace: ./scripts/module6.sh --scaffold Complete MULTI_AGENT_ARCHITECTURE.md, PROTOCOL_VERIFICATION_PLAN.md, and INTEGRATION_PLAN.md. Add or refine multi-agent and protocol checker components in common_dut/tb/. Validate: ./scripts/module6.sh... |
| 8 | Design architecture | 0:08 | Next section: Design architecture. |
| 9 | 1. Multi-agent / multi-channel TB | 0:30 | 1. Multi-agent / multi-channel TB. Multiple agents (per interface or channel) coordinated by env and virtual sequences. Layered architecture: block agents → fabric/scoreboard → subsystem scenarios (MULTI_AGENT_ARCHITECTURE.md). Refer to the diagram on the right. |
| 10 | 2. Protocol verification layer | 0:30 | 2. Protocol verification layer. Dedicated protocol checker (SVA or monitor-based) separate from scoreboard data checks. PROTOCOL_VERIFICATION_PLAN.md lists rules, coverage, and integration with agents. Refer to the diagram on the right. |
| 11 | 3. System integration view | 0:20 | 3. System integration view. INTEGRATION_PLAN.md describes how block-level env connects to subsystem tests. Reuse agents/VIP across DUT variants via configuration and factory overrides. |
| 12 | Monitor observes transactions | 0:28 | Monitor observes transactions. Review the code on screen and match it to files in the repository. |
| 13 | Multi-agent architecture template | 0:28 | Multi-agent architecture template. Review the code on screen and match it to files in the repository. |
| 14 | Key files to study | 0:08 | Next section: Key files to study. |
| 15 | Open these in the repo | 0:32 | Open these in the repo. module6/MULTI_AGENT_ARCHITECTURE.md — multi-channel env and virtual sequence coordination module6/PROTOCOL_VERIFICATION_PLAN.md — protocol rules, checkers, and coverage module6/INTEGRATION_PLAN.md — block-to-subsystem integration strategy module4/tb/stream_pkg.sv — monitor and agent patterns to extend scripts/module6.sh — multi-agent and protocol doc checks Trace while... |
| 16 | Verification & testing methods | 0:08 | Next section: Verification & testing methods. |
| 17 | 1. Protocol rule testing | 0:30 | 1. Protocol rule testing. Each protocol rule maps to checker fires, coverpoints, and at least one directed or random test. Illegal sequences and corner timing documented with expected checker behavior. Refer to the diagram on the right. |
| 18 | 2. Multi-agent scenario testing | 0:20 | 2. Multi-agent scenario testing. Virtual sequences stress cross-agent ordering, arbitration, and backpressure. System scoreboard validates end-to-end data and sideband signals. |
| 19 | 3. Maintainability reviews | 0:20 | 3. Maintainability reviews. Architecture review before adding agents — avoid duplicate monitors and conflicting checkers. ./scripts/module6.sh --check validates multi-agent and protocol planning artifacts. |
| 20 | Protocol verification plan excerpt | 0:28 | Protocol verification plan excerpt. Review the code on screen and match it to files in the repository. |
| 21 | Syllabus topics | 0:08 | Next section: Syllabus topics. |
| 22 | 1. Multi-Agent Environment Design | 0:20 | 1. Multi-Agent Environment Design. Multi-agent and multi-channel environment design. Layered and reusable testbench architecture patterns. |
| 23 | 2. Protocol Agents and Checkers | 0:16 | 2. Protocol Agents and Checkers. Protocol agent and protocol checker design. |
| 24 | 3. Scoreboards and Integration | 0:16 | 3. Scoreboards and Integration. Integration of complex scoreboards and time-based matching. |
| 25 | 4. Debug and Analysis | 0:16 | 4. Debug and Analysis. Debugging and analyzing complex, protocol-heavy simulations. |
| 26 | Command reference highlights | 0:08 | Next section: Command reference highlights. |
| 27 | Scaffold and validate Module 6 | 0:16 | Scaffold and validate Module 6. ./scripts/module6.sh --scaffold Full detail in docs/MODULE6.md command reference. |
| 28 | Review multi-agent architecture template | 0:16 | Review multi-agent architecture template. head -40 module6/templates/MULTI_AGENT_ARCHITECTURE.md Full detail in docs/MODULE6.md command reference. |
| 29 | Hands-on examples | 0:08 | Next section: Hands-on examples. |
| 30 | Module 6 self-check | 0:45 | Module 6 self-check. Watch the terminal output and confirm you see the expected pass message. |
| 31 | Exercise scaffold | 0:28 | Exercise scaffold. Review the code on screen and match it to files in the repository. |
| 32 | Demo: Protocol verification plan | 0:45 | Demo: Protocol verification plan. Watch the terminal output and confirm you see the expected pass message. |
| 33 | Demo: Multi-agent architecture | 0:45 | Demo: Multi-agent architecture. Watch the terminal output and confirm you see the expected pass message. |
| 34 | Demo: Integration plan | 0:45 | Demo: Integration plan. Watch the terminal output and confirm you see the expected pass message. |
| 35 | Demo: Reference protocol plan | 0:45 | Demo: Reference protocol plan. Watch the terminal output and confirm you see the expected pass message. |
| 36 | Demo: Module validation | 0:45 | Demo: Module validation. Watch the terminal output and confirm you see the expected pass message. |
| 37 | Practice & assessment | 0:08 | Next section: Practice & assessment. |
| 38 | What you should know (1/2) | 0:36 | By now you should be able to explain the following. Design and document multi-agent UVM environments for protocol-based DUTs. Implement and integrate protocol agents and protocol checkers. Apply layered architecture patterns to keep complex benches maintainable. Analyze and debug multi-channel, protocol-level behavior in simulations. Multi-agent/multi-channel environment design documented in... |
| 39 | What you should know (2/2) | 0:20 | By now you should be able to explain the following. Integration patterns and system-level scenarios documented in module6/INTEGRATION_PLAN.md. Complex bench design reviewed; action items captured in the docs. From MODULE6 Learning Outcomes. |
| 40 | Assessment checklist | 0:28 | Assessment checklist. Multi-agent/multi-channel environment design documented in module6/MULTI_AGENT_ARCHITECTURE.md. Protocol verification strategy documented in module6/PROTOCOL_VERIFICATION_PLAN.md. Integration patterns and system-level scenarios documented in module6/INTEGRATION_PLAN.md. Complex bench design reviewed; action items captured in the docs. |
| 41 | Summary & next steps | 0:28 | In summary: Apply your planning, environment, and regression skills to complex multi-agent, protocol-heavy testbenches (e.g., AXI-like, multi-channel interfaces), focusing on architecture, protocol checking, and maintainability. Next up: Next module in course. Apply your planning, environment, and regression skills to complex multi-agent, protocol-heavy testbenches (e.g., AXI-like... Complete... |

        ## Section narration (edit for TTS)

        - **How to learn:** Re-read `module4/ENV_DESIGN.md` and `module5/REGRESSION_OPS.md`. Then Scaffold Module 6 workspace: `./scripts/module6.sh --scaffold` Then Complete `MULTI_AGENT_ARCHITECTURE.md`, `PROTOCOL_VERIFICATION_PLAN.md`, and `INTEGRATION_PLAN.md`. Then Add or refine multi-agent and protocol checker components in `common_dut/tb/`..
- **Design architecture (Multi-agent / multi-channel TB, Protocol verification layer, System integration view):** Walk through the block diagram, then relate each block to files under module6/examples/.
- **Verification (Protocol rule testing, Multi-agent scenario testing, Maintainability reviews):** Explain what stimulus is applied, what is checked, and what is intentionally out of scope.
- **Syllabus:** Cover 4 topic section(s) — pause on protocol timing and signals.
- **Before exercises:** Ask learners to recall the learning outcomes slide; they should explain each bullet in their own words.
- **Hands-on:** Run module6/EXAMPLES.md labs; narrate expected PASS lines.

        ## Notes

        - Slides from **Before You Start**, **Design Architecture**, **Verification & Testing Methods**, **Topics Covered**, **EXAMPLES.md**, and **Learning Outcomes**.
        - Full detail: `docs/MODULE6.md` and `module6/EXAMPLES.md`.
        - Regenerate: `regenerate_course_outlines.sh <course_root> --module 6`

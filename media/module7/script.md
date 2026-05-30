        # Narration script — Module 7: Real-World Verification Applications & VIP (SV/UVM)

        **Target length:** ~15 minutes (39 slides; auto-generated — edit per slide as needed)

        ## Timing table

        | Slide | Section | Duration | Narration |
|-------|---------|----------|-----------|
| 1 | Module 7 | 0:25 | Welcome to module 7, Real-World Verification Applications & VIP (SV/UVM). In this module you will apply the full methodology (planning, uvm env, coverage, regressions) to real-world style blocks and protocols (e.g., dma, uart/spi/i2c, custom ip) and design reusable verification ip (vip) ready for production.. |
| 2 | Learning objectives | 0:16 | Here is what you will learn in this module. Apply the full methodology (planning, UVM env, coverage, regressions) to real-world style blocks and protocols (e.g., DMA, UART/SPI/I2C... |
| 3 | Prerequisites | 0:16 | Before you start, make sure you have these prerequisites. See module README |
| 4 | Learning path | 0:22 | Learning path. Apply the full methodology (planning, UVM env, coverage, regressions) to real-world style blocks and protocols (e.g., DMA, UART/SPI/I2C, custom IP) and design reusable verification IP (VIP) ready... |
| 5 | Overview | 0:16 | Overview. Modules 1–6 built up your skills and infrastructure. Module 7 is about applying them to realistic verification challenges: |
| 6 | How to learn this module | 0:08 | Next section: How to learn this module. |
| 7 | Suggested learning path | 0:32 | Follow this learning path. Read the guides before running the labs. Choose a real-world DUT or subsystem scope in module7/PROJECTS.md. Scaffold Module 7 workspace: ./scripts/module7.sh --scaffold Design reusable VIP structure in module7/VIP_DESIGN.md. Apply best practices from module7/BEST_PRACTICES.md to naming, docs, and API boundaries. Validate: ./scripts/module7.sh --check From... |
| 8 | Design architecture | 0:08 | Next section: Design architecture. |
| 9 | 1. Real-world DUT / subsystem | 0:30 | 1. Real-world DUT / subsystem. Choose DMA-style block, bus/register IP, or protocol DUT (UART/SPI/I2C/AXI-lite style). Document block diagram, clocks/resets, and interface contracts in PROJECTS.md. Refer to the diagram on the right. |
| 10 | 2. VIP package architecture | 0:34 | 2. VIP package architecture. Reusable VIP: agent, sequencer, driver, monitor, checker, coverage, config objects. VIP_DESIGN.md defines public API, sequences, and integration guide for adopters. Package boundaries: what integrators configure vs what VIP owns internally. Refer to the diagram on the right. |
| 11 | 3. Production layout | 0:16 | 3. Production layout. Separate rtl/, tb/, tests/, docs/ with consistent naming for handoff to another team. |
| 12 | VIP design template | 0:28 | VIP design template. Review the code on screen and match it to files in the repository. |
| 13 | Key files to study | 0:08 | Next section: Key files to study. |
| 14 | Open these in the repo | 0:32 | Open these in the repo. module7/PROJECTS.md — DUT scope, interfaces, and verification goals module7/VIP_DESIGN.md — VIP package architecture and public API module7/BEST_PRACTICES.md — production-quality verification and delivery standards module6/MULTI_AGENT_ARCHITECTURE.md — prior multi-agent patterns to reuse scripts/module7.sh — project and VIP design doc checks Trace while running... |
| 15 | Verification & testing methods | 0:08 | Next section: Verification & testing methods. |
| 16 | 1. End-to-end IP verification | 0:30 | 1. End-to-end IP verification. Full lifecycle: requirements → env → tests → coverage → regressions → sign-off preview. Regression tiers and coverage goals match production expectations. Refer to the diagram on the right. |
| 17 | 2. VIP validation | 0:20 | 2. VIP validation. Self-test environment for the VIP plus integrator tests on a reference DUT. Documentation-driven review: another engineer can adopt VIP from docs alone. |
| 18 | 3. Quality bar | 0:20 | 3. Quality bar. BEST_PRACTICES.md — coding standards, review checklist, maintenance and versioning. ./scripts/module7.sh --check validates project and VIP design documentation. |
| 19 | Project scope template | 0:28 | Project scope template. Review the code on screen and match it to files in the repository. |
| 20 | VIP best practices excerpt | 0:28 | VIP best practices excerpt. Review the code on screen and match it to files in the repository. |
| 21 | Syllabus topics | 0:08 | Next section: Syllabus topics. |
| 22 | 1. End-to-End IP Verification | 0:20 | 1. End-to-End IP Verification. Applying planning + UVM + coverage + regression to realistic IP. Realistic test planning, coverage closure, and regression operation. |
| 23 | 2. VIP Design and Reuse | 0:16 | 2. VIP Design and Reuse. Designing and documenting verification IP (VIP) for protocols or blocks. |
| 24 | 3. Production Quality and Maintenance | 0:16 | 3. Production Quality and Maintenance. Best practices for project structure, code quality, docs, and maintenance. |
| 25 | Command reference highlights | 0:08 | Next section: Command reference highlights. |
| 26 | Scaffold and validate Module 7 | 0:16 | Scaffold and validate Module 7. ./scripts/module7.sh --scaffold Full detail in docs/MODULE7.md command reference. |
| 27 | Review VIP and project templates | 0:16 | Review VIP and project templates. head -40 module7/templates/VIP_DESIGN.md Full detail in docs/MODULE7.md command reference. |
| 28 | Hands-on examples | 0:08 | Next section: Hands-on examples. |
| 29 | Module 7 self-check | 0:45 | Module 7 self-check. Watch the terminal output and confirm you see the expected pass message. |
| 30 | Demo: VIP design template | 0:45 | Demo: VIP design template. Watch the terminal output and confirm you see the expected pass message. |
| 31 | Demo: Projects overview | 0:45 | Demo: Projects overview. Watch the terminal output and confirm you see the expected pass message. |
| 32 | Demo: Best practices | 0:45 | Demo: Best practices. Watch the terminal output and confirm you see the expected pass message. |
| 33 | Demo: Reference VIP design | 0:45 | Demo: Reference VIP design. Watch the terminal output and confirm you see the expected pass message. |
| 34 | Demo: Module validation | 0:45 | Demo: Module validation. Watch the terminal output and confirm you see the expected pass message. |
| 35 | Practice & assessment | 0:08 | Next section: Practice & assessment. |
| 36 | What you should know (1/2) | 0:36 | By now you should be able to explain the following. Design and implement a complete verification environment for a realistic DUT. Create and document reusable VIP that others could adopt. Operate regressions and coverage closure as you would in a real team. Maintain production-quality code, docs, and tests over the lifetime of a project. At least one substantial real-world style project is... |
| 37 | What you should know (2/2) | 0:20 | By now you should be able to explain the following. Best-practices checklist largely satisfied (module7/BEST_PRACTICES.md / module7/CHECKLIST.md). You can explain your project and design decisions as if presenting to a review board. From MODULE7 Learning Outcomes. |
| 38 | Assessment checklist | 0:28 | Assessment checklist. At least one substantial real-world style project is described and partially/fully implemented. VIP or environment design is documented in module7/VIP_DESIGN.md and module7/PROJECTS.md. Best-practices checklist largely satisfied (module7/BEST_PRACTICES.md / module7/CHECKLIST.md). You can explain your project and design decisions as if presenting to a review board. |
| 39 | Summary & next steps | 0:28 | In summary: Apply the full methodology (planning, UVM env, coverage, regressions) to real-world style blocks and protocols (e.g., DMA, UART/SPI/I2C, custom IP) and design reusable verification IP (VIP) ready for production. Next up: Next module in course. Apply the full methodology (planning, UVM env, coverage, regressions) to real-world style blocks and protocols (e.g., DMA, UART/SPI/I2C... |

        ## Section narration (edit for TTS)

        - **How to learn:** Choose a real-world DUT or subsystem scope in `module7/PROJECTS.md`. Then Scaffold Module 7 workspace: `./scripts/module7.sh --scaffold` Then Design reusable VIP structure in `module7/VIP_DESIGN.md`. Then Apply best practices from `module7/BEST_PRACTICES.md` to naming, docs, and API boundaries..
- **Design architecture (Real-world DUT / subsystem, VIP package architecture, Production layout):** Walk through the block diagram, then relate each block to files under module7/examples/.
- **Verification (End-to-end IP verification, VIP validation, Quality bar):** Explain what stimulus is applied, what is checked, and what is intentionally out of scope.
- **Syllabus:** Cover 3 topic section(s) — pause on protocol timing and signals.
- **Before exercises:** Ask learners to recall the learning outcomes slide; they should explain each bullet in their own words.
- **Hands-on:** Run module7/EXAMPLES.md labs; narrate expected PASS lines.

        ## Notes

        - Slides from **Before You Start**, **Design Architecture**, **Verification & Testing Methods**, **Topics Covered**, **EXAMPLES.md**, and **Learning Outcomes**.
        - Full detail: `docs/MODULE7.md` and `module7/EXAMPLES.md`.
        - Regenerate: `regenerate_course_outlines.sh <course_root> --module 7`

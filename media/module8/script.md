        # Narration script — Module 8: Capstone – End‑to‑End Verification & VIP Delivery (SV/UVM)

        **Target length:** ~15 minutes (35 slides; auto-generated — edit per slide as needed)

        ## Timing table

        | Slide | Section | Duration | Narration |
|-------|---------|----------|-----------|
| 1 | Module 8 | 0:25 | Welcome to module 8, Capstone – End‑to‑End Verification & VIP Delivery (SV/UVM). In this module you will plan and execute a single, substantial capstone project that exercises the full verification lifecycle (modules 1–7), from requirements and planning through uvm environment, coverage, regressions, and delivery of a reusable verification solution or vip.. |
| 2 | Learning objectives | 0:16 | Here is what you will learn in this module. Plan and execute a single, substantial capstone project that exercises the full verification lifecycle (Modules 1–7), from requirements... |
| 3 | Prerequisites | 0:16 | Before you start, make sure you have these prerequisites. See module README |
| 4 | Learning path | 0:22 | Learning path. Plan and execute a single, substantial capstone project that exercises the full verification lifecycle (Modules 1–7), from requirements and planning through UVM environment, coverage, regressions... |
| 5 | Overview | 0:16 | Overview. Module 8 is not another theory module; it is a major project that ties everything together: |
| 6 | How to learn this module | 0:08 | Next section: How to learn this module. |
| 7 | Suggested learning path | 0:32 | Follow this learning path. Read the guides before running the labs. Select capstone DUT and scope in module8/CAPSTONE_PROJECT.md. Scaffold Module 8 workspace: ./scripts/module8.sh --scaffold Assemble artifacts from Modules 1–7: plans, env, coverage, regression ops, VIP (if applicable). Run full regression tiers and document sign-off status in the capstone checklist. Validate deliverable... |
| 8 | Design architecture | 0:08 | Next section: Design architecture. |
| 9 | 1. Capstone system architecture | 0:34 | 1. Capstone system architecture. CAPSTONE_PROJECT.md defines DUT hierarchy, interfaces, clocks, and verification scope. Apply Modules 1–7 artifacts: plans, env, VIP (if applicable), coverage, regression ops. Deliverable layout: RTL, UVM env, tests, scripts, and user-facing documentation. Refer to the diagram on the right. |
| 10 | 2. End-to-end verification package | 0:30 | 2. End-to-end verification package. Single coherent verification solution or VIP another team can integrate. Traceability matrix from requirements through tests, coverage, and sign-off criteria. Refer to the diagram on the right. |
| 11 | 3. Capstone delivery and handoff workflow | 0:32 | 3. Capstone delivery and handoff workflow. Plan: consolidate Modules 1–2 plans into capstone scope and test/regression strategy. Build: mature env, checkers, coverage, and VIP (Module 4–7 artifacts) under rtl/ and tb/. Execute: run sanity → core → stress tiers; merge coverage; triage failures with saved seeds. Sign off: meet exit criteria in CAPSTONE_PROJECT.md; complete CHECKLIST.md. Deliver... |
| 12 | Capstone project plan template | 0:28 | Capstone project plan template. Review the code on screen and match it to files in the repository. |
| 13 | Key files to study | 0:08 | Next section: Key files to study. |
| 14 | Open these in the repo | 0:32 | Open these in the repo. module8/CAPSTONE_PROJECT.md — end-to-end project definition and deliverables module8/CHECKLIST.md — capstone sign-off and delivery checklist docs/FILL_GUIDES.md — guidance for completing planning artifacts Prior module workspaces (module1/ … module7/) — reusable verification assets scripts/module8.sh — capstone documentation and checklist validation Trace while running... |
| 15 | Verification & testing methods | 0:08 | Next section: Verification & testing methods. |
| 16 | 1. Full-lifecycle testing | 0:30 | 1. Full-lifecycle testing. Execute planned regression tiers with coverage merge and documented closure status. Include negative, stress, and protocol/rule tests appropriate to your capstone DUT. Refer to the diagram on the right. |
| 17 | 2. Sign-off and delivery testing | 0:20 | 2. Sign-off and delivery testing. Define explicit exit criteria (coverage %, bug bar, stability window). Retrospective: what worked, gaps, and improvements for a real project review. |
| 18 | 3. Validation | 0:20 | 3. Validation. ./scripts/module8.sh --check validates capstone documentation and checklist completion. Optional demo or walkthrough recorded as part of the deliverable. |
| 19 | Capstone checklist excerpt | 0:28 | Capstone checklist excerpt. Review the code on screen and match it to files in the repository. |
| 20 | Capstone validation script | 0:28 | Capstone validation script. Review the code on screen and match it to files in the repository. |
| 21 | Command reference highlights | 0:08 | Next section: Command reference highlights. |
| 22 | Scaffold and validate capstone | 0:16 | Scaffold and validate capstone. ./scripts/module8.sh --scaffold Full detail in docs/MODULE8.md command reference. |
| 23 | Review capstone templates | 0:16 | Review capstone templates. head -45 module8/templates/CAPSTONE_PROJECT.md Full detail in docs/MODULE8.md command reference. |
| 24 | Hands-on examples | 0:08 | Next section: Hands-on examples. |
| 25 | Module 8 self-check | 0:45 | Module 8 self-check. Watch the terminal output and confirm you see the expected pass message. |
| 26 | Demo: Capstone project template | 0:45 | Demo: Capstone project template. Watch the terminal output and confirm you see the expected pass message. |
| 27 | Demo: Capstone checklist | 0:45 | Demo: Capstone checklist. Watch the terminal output and confirm you see the expected pass message. |
| 28 | Demo: Fill guides | 0:45 | Demo: Fill guides. Watch the terminal output and confirm you see the expected pass message. |
| 29 | Demo: Reference capstone | 0:45 | Demo: Reference capstone. Watch the terminal output and confirm you see the expected pass message. |
| 30 | Demo: Module validation | 0:45 | Demo: Module validation. Watch the terminal output and confirm you see the expected pass message. |
| 31 | Practice & assessment | 0:08 | Next section: Practice & assessment. |
| 32 | What you should know (1/2) | 0:36 | By now you should be able to explain the following. Drive an end‑to‑end verification effort from requirements → plan → env → tests → coverage → regressions → sign‑off. Deliver a coherent, documented verification package or VIP that others can understand and use. Reflect on trade‑offs and improvements as if you were preparing for a real project review. A clearly defined capstone project... |
| 33 | What you should know (2/2) | 0:16 | By now you should be able to explain the following. A short written or presented retrospective on what worked, what didn’t, and what you’d improve next. From MODULE8 Learning Outcomes. |
| 34 | Assessment checklist | 0:28 | Assessment checklist. A clearly defined capstone project documented in capstone_project.md. Evidence that Modules 1–7 have been applied (plans, env, tests, coverage, regressions). A “deliverable” verification solution or VIP (code + docs) that could be handed to another team. A short written or presented retrospective on what worked, what didn’t, and what you’d improve next. |
| 35 | Summary & next steps | 0:28 | In summary: Plan and execute a single, substantial capstone project that exercises the full verification lifecycle (Modules 1–7), from requirements and planning through UVM environment, coverage, regressions, and delivery of a reusable verification solution or VIP. Next up: Next module in course. Plan and execute a single, substantial capstone project that exercises the full verification... |

        ## Section narration (edit for TTS)

        - **How to learn:** Select capstone DUT and scope in `module8/CAPSTONE_PROJECT.md`. Then Scaffold Module 8 workspace: `./scripts/module8.sh --scaffold` Then Assemble artifacts from Modules 1–7: plans, env, coverage, regression ops, VIP (if applicable). Then Run full regression tiers and document sign-off status in the capstone checklist..
- **Design architecture (Capstone system architecture, End-to-end verification package, Capstone delivery and handoff workflow):** Walk through the block diagram, then relate each block to files under module8/examples/.
- **Verification (Full-lifecycle testing, Sign-off and delivery testing, Validation):** Explain what stimulus is applied, what is checked, and what is intentionally out of scope.
- **Before exercises:** Ask learners to recall the learning outcomes slide; they should explain each bullet in their own words.
- **Hands-on:** Run module8/EXAMPLES.md labs; narrate expected PASS lines.

        ## Notes

        - Slides from **Before You Start**, **Design Architecture**, **Verification & Testing Methods**, **Topics Covered**, **EXAMPLES.md**, and **Learning Outcomes**.
        - Full detail: `docs/MODULE8.md` and `module8/EXAMPLES.md`.
        - Regenerate: `regenerate_course_outlines.sh <course_root> --module 8`

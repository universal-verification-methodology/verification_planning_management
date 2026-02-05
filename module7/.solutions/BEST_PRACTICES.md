# Best Practices & Quality Checklist (Module 7)

> **Purpose**: Capture and enforce best practices for code, structure, and maintenance in your real-world verification/VIP projects.  
> **Module**: 7 – Real-World Verification Applications & VIP (SV/UVM)

## 1. Project Structure

Guidelines:

- Clear separation between:
  - DUT RTL.  
  - UVM environment / VIP.  
  - Tests/regression scripts.  
  - Docs and utilities.  
- Consistent directory naming and layout across projects.

Project-specific notes / decisions:

- **Layout**: `common_dut/rtl/` (DUT), `common_dut/tb/` (shared TB/VIP components: stream_if usage, stream_fifo_coverage, env skeleton), `module4/tb/` (stream_fifo UVM env and test), `module1/`–`module7/` (planning docs), `scripts/` (module orchestrators).  
- **Naming**: Lowercase with underscores for files (stream_pkg.sv, stream_if.sv); class names match (stream_item, stream_driver).  

## 2. Code Quality and Naming

Checklist:

- [x] Classes, methods, and variables have clear, descriptive names.  
- [x] No magic numbers – use parameters, enums, or config fields.  
- [x] Common patterns (agents, monitors, scoreboards, sequences) follow consistent naming and structure.  
- [x] Comments explain *why*, not just *what*.  

Conventions / decisions:

- **Naming**: stream_* for VIP; SMK_*, FTR_*, ERR_*, STR_*, PERF_* for test IDs; CG_* for covergroups; PR_* for protocol rules.  
- **Parameters**: DATA_WIDTH, DEPTH in RTL and interface; no hardcoded 8/16 in VIP where parameterizable.  

## 3. Documentation

Checklist:

- [x] Each major component (env, agent, VIP, scoreboard, checker) has a brief description (in code and/or docs).  
- [x] Public APIs (config objects, sequences, VIP interfaces) are documented.  
- [x] Project-level README(s) explain how to build, run, and extend the environment/VIP.  

Docs to maintain:

- **Module docs**: module1/VERIFICATION_PLAN, module2/TEST_PLAN, module3/COVERAGE_DESIGN, module4/ENV_DESIGN, CHECKER_PLAN, module5 REGRESSION_OPS, ADVANCED_UVM_PLAN, DEBUG_FLAKE_PLAN, module6 MULTI_AGENT, PROTOCOL_VERIFICATION, INTEGRATION_PLAN, module7 PROJECTS, VIP_DESIGN, BEST_PRACTICES.  
- **Code**: Docstrings/comments in stream_pkg.sv and stream_if.sv; README in project root and in common_dut/tb and module4/tb as needed.  

## 4. Testing and Coverage Practices

Checklist:

- [x] Every bug fix has at least one associated test (or enhanced test) and coverage evidence where applicable.  
- [x] Test names and IDs reflect intent (what is being verified).  
- [x] Tests are categorized and mapped into tiers (sanity/core/stress/etc.).  
- [x] Coverage is used to drive incremental improvements, not just as a number.  

Project-specific notes:

- **Test IDs**: SMK_* smoke, FTR_* feature, ERR_* error, STR_* stress, PERF_* performance; mapped in module2/TEST_PLAN and module2/REGRESSION_PLAN.  
- **Coverage**: CG_LEVEL, CG_OPS, CG_FLAGS, CG_BACKPRESSURE; closure actions in module3/COVERAGE_RUN.md.  

## 5. Regression and CI Hygiene

Checklist:

- [x] Regressions are repeatable (same test + seed → same result).  
- [x] Failing tests generate actionable logs and, when needed, waveforms.  
- [x] CI jobs are documented (which tests run where and when).  
- [x] Flaky tests are tracked and addressed (see module5/DEBUG_FLAKE_PLAN.md).  

Decisions / standards:

- **Seeds**: Fixed for sanity/core where possible; varied for stress; seed logged per run.  
- **Logs**: UVM component prefixes; test name and seed in summary; scoreboard/assertion context on failure.  
- **Flake**: One rerun per failure; quarantine list; see module5/DEBUG_FLAKE_PLAN.md.  

## 6. Maintenance and Evolution

Checklist:

- [x] Deprecated code is clearly marked and removed in a timely manner.  
- [x] Refactors are accompanied by updates to docs and tests.  
- [x] Reusable components are extracted into common libraries where appropriate.  

Future improvements / ideas:

- **Reuse**: stream_if and stream_pkg are reusable; stream_fifo_coverage is DUT-specific but pattern is reusable.  
- **Refactors**: Add sequencer to env; add source-side analysis for scoreboard expected queue; extract protocol checker into reusable component.  

## 7. Final Self-Review Notes

Use this section to record your own reflections:

- **If used by another team**: Add README with build/run instructions; document config DB keys and plusargs; provide minimal example test and sequence.  
- **Trade-offs**: Simplicity (single driver, single monitor, no virtual sequencer yet) vs completeness (full scoreboard compare, virtual sequences); performance (coverage sampling on handshake only) vs coverage density.  

Notes:

- **Reflection**: Planning-heavy approach (modules 1–7) ensures traceability and clarity; implementation can evolve (e.g., add sequencer, source monitor) without losing alignment with requirements and tests.  

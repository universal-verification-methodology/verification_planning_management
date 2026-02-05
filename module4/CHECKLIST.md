# Module 4 Checklist – UVM Environment & Checker Maturity

> **Purpose**: Track completion of Module 4 environment and checker tasks.

> **Instructions**: Check off items as you complete them. Copy from `module4/templates/` if needed, or edit the file in `module4/` directly. Reference: `module4/.solutions/`.

## 1. Pre-Reqs from Modules 1–3

- [ ] Module 1 verification plan and requirements matrix reasonably complete.
- [ ] Module 2 test and regression plans in place.
- [ ] Module 3 coverage design and at least one coverage run logged.

## 2. Environment Architecture

- [ ] `env_design.md` created and linked to earlier module docs.
- [ ] Environment block diagram (or equivalent description) completed.
- [ ] Clear responsibilities documented for:
  - [ ] Env.
  - [ ] Each agent.
  - [ ] Drivers, monitors, sequencers.
  - [ ] Scoreboards and reference models.
- [ ] UVM hierarchy in code (`common_dut/tb/…`) matches the documented design (or notes describe differences).

## 3. Transaction and Sequence Design

- [ ] Main transaction classes documented with fields and constraints.
- [ ] Helper methods (`copy`, `compare`, `convert2string`, etc.) described and implemented.
- [ ] Sequences mapped to test intents from `module2/test_plan.md`.
- [ ] At least:
  - [ ] One base/common sequence.
  - [ ] Several feature sequences.
  - [ ] Negative/error and stress sequences planned.

## 4. Driver and Monitor Implementation (Design-Level)

- [ ] Driver behavior and protocol handling described in `env_design.md`.
- [ ] Monitor sampling strategy and transaction reconstruction documented.
- [ ] TLM/analysis connections (ports/exports/imps) outlined in a table.
- [ ] Reset, backpressure, and error-handling behaviors considered.

## 5. Scoreboards and Reference Models

- [ ] `checker_plan.md` lists all planned scoreboards and reference models.
- [ ] For each scoreboard:
  - [ ] Inputs (analysis ports/streams) identified.
  - [ ] Matching/comparison strategy documented.
  - [ ] Error reporting approach described.
- [ ] For each reference model:
  - [ ] Abstraction level defined.
  - [ ] Input/outputs and assumptions documented.

## 6. Assertions and Checkers

- [ ] Key assertions (IDs, intents, locations) listed in `checker_plan.md`.
- [ ] Placement strategy (interface vs internal vs monitor-based) documented.
- [ ] Enable/disable controls planned (e.g., via config DB or plusargs).
- [ ] Mapping from high-priority requirements to assertions/scoreboards exists (and is reflected in `requirements_matrix.md`).

## 7. Integration with Tests and Coverage

- [ ] For several representative tests (smoke, feature, stress):
  - [ ] It is clear which sequences they use.
  - [ ] Which scoreboards and assertions are exercised is documented.
- [ ] Coverage–checker alignment noted (e.g., which coverage items depend on which checkers).

## 8. Review and Action Items

- [ ] Environment and checker design reviewed with peer/mentor or team.
- [ ] Feedback and follow-up actions captured in `env_design.md` or `checker_plan.md`.

## 9. Ready to Move to Module 5

- [ ] UVM env and checkers are **designed** and documented; implementation can proceed (or is in progress).
- [ ] You can explain:
  - [ ] Your env block diagram and component roles.
  - [ ] How scoreboard and assertions map to requirements.
  - [ ] How tests and coverage tie to the env/checker design.
- [ ] You are ready to focus on **regression operations, advanced UVM, and debug** in the next module.

# Module 6 Checklist – Complex Multi-Agent & Protocol Testbenches

> **Purpose**: Track completion of Module 6 tasks around multi-agent, protocol-heavy benches.

> **Instructions**: Check off items as you complete them. Copy from `module6/templates/` if needed, or edit the file in `module6/` directly. Reference: `module6/.solutions/`.

## 1. Pre-Reqs from Modules 1–5

- [ ] DUT + base UVM env in `module1/` stable enough for extension.
- [ ] Test, regression, coverage, and env/checker plans reasonably complete.
- [ ] Regression and advanced UVM orchestration plans (Module 5) documented.

## 2. Multi-Agent Architecture

- [ ] `multi_agent_architecture.md` created and linked to earlier env design.
- [ ] All relevant agents listed with roles (master/slave/passive) and channels.
- [ ] Multi-agent environment hierarchy documented (diagrams or structured description).
- [ ] Coordination strategy defined (virtual sequencers, sequences, scenarios).

## 3. Protocol Verification

- [ ] `protocol_verification_plan.md` created.
- [ ] Protocol overview and key rules documented (with Rule IDs).
- [ ] Protocol agents (master/slave/passive) defined and mapped to DUT interfaces.
- [ ] Protocol checker(s) defined, with:
  - [ ] Rule-to-checker mapping.
  - [ ] Error/warning reporting approach.
- [ ] Protocol coverage strategy documented (functional + assertion/code).

## 4. Integration & System-Level Scenarios

- [ ] `integration_plan.md` created.
- [ ] In-scope integration levels (block/subsystem/system) identified.
- [ ] Key end-to-end scenarios listed with IDs and descriptions.
- [ ] Cross-block / cross-agent checks defined (scoreboards, assertions, or both).

## 5. Traceability

- [ ] Protocol rules and integration scenarios linked to:
  - [ ] Requirements in `REQUIREMENTS_MATRIX.md` or equivalent.
  - [ ] Tests in `test_plan.md`.
  - [ ] Coverage items in `coverage_design.md`.

## 6. Review and Action Items

- [ ] Multi-agent architecture reviewed with peer/mentor or team.
- [ ] Protocol verification plan reviewed.
- [ ] Integration scenarios reviewed.
- [ ] Feedback and action items captured in the respective docs.

## 7. Ready to Move to Next Module

- [ ] You can explain:
  - [ ] How agents and channels are organized and coordinated.
  - [ ] How protocol correctness is enforced and measured.
  - [ ] How complex, end-to-end flows are verified and checked.
- [ ] Complex testbench design is well-documented and ready for long-term evolution and reuse.

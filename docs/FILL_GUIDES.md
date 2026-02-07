# Fill Guides – How to Complete Planning Documents

This document gives **section-by-section guidance** for filling the planning templates. Use it together with the "How to fill" hints inside each template and the reference solutions in `moduleN/.solutions/`.

---

## Table of Contents

- [Minimal vs full](#minimal-vs-full)
- [Module 1](#module-1)
  - [Verification Plan](#module-1---verification-plan)
  - [Requirements Matrix](#module-1---requirements-matrix)
  - [Checklist](#module-1---checklist)
  - [High-Priority Requirements Traceability](#module-1---high-priority-requirements-traceability)
- [Module 2](#module-2)
- [Modules 3–8](#modules-38)

---

## Minimal vs full

Two ways to complete planning documents:

| Approach | What it means | Where to find |
|----------|----------------|---------------|
| **Minimal** | Enough to **pass the scripts**: no TODOs left, required sections present, at least a few requirement rows in the matrix, checklist items checked. Minimal tables and bullets. | Your workspace after a first pass; or copy from `moduleN/templates/` and replace each `<!-- TODO: ... -->` with 1–2 sentences and minimal tables. |
| **Full** | **Full depth** for review and sign-off: detailed DUT description, risk table, full test catalogue (≥10 tests), Req→Test→Coverage→Checkers mapping, high-priority traceability. | `moduleN/.solutions/` (e.g. `module1/.solutions/` for the Stream FIFO). |

**Recommendation**: Start with a minimal pass so the script passes, then deepen section by section using [USE_CASE_FIFO](USE_CASE_FIFO.md) and the fill guides below. Use `.solutions/` to judge quality and depth; scripts only check structure and completeness.

---

## Module 1

Module 1 deliverable files (in `module1/`): `VERIFICATION_PLAN.md`, `REQUIREMENTS_MATRIX.md`, `CHECKLIST.md`, `HIGH_PRIORITY_REQUIREMENTS_TRACEABILITY.md`.

### Module 1 – Verification Plan

**Purpose**: Capture the initial verification plan for your chosen DUT so that later modules (test plan, coverage, regression) can build on it.

| Section | What to add | Good looks like |
|--------|-------------|-------------------|
| 1. Project and DUT Overview | Project name, DUT name, owners, version; 2–4 sentence DUT description; list of interfaces (ports, clocks, resets); dependencies | Concrete names and a short paragraph; no generic "TBD" only |
| 2. Verification Objectives and Scope | 3–5 verification goals; in-scope features; out-of-scope with justification; risk table (feature vs H/M/L) | Goals tied to coverage and risk; risk table with at least 3–4 rows |
| 3. Verification Strategy | Directed vs random vs scenario-based; UVM structure (env/agent/sequence/scoreboard); assertions/checkers | One short paragraph per dimension |
| 4. Test Planning and Test Catalogue | Test tiers; ≥10 tests with ID, name, intent; mapping to requirement IDs | Table or list with test IDs and Req IDs |
| 5. Coverage Planning | Functional coverage items; code coverage goals; closure philosophy | Short list of covergroups/coverpoints and "how we close" |
| 6. Regression and Sign-off | Regression tiers (e.g. sanity, nightly, full); draft sign-off criteria | 3–5 bullets |
| 7. Open Questions and Risks | Open questions; risks; mitigations | Updated as project progresses |
| 8. Review and Action Items | Review notes; action items | After self-review or peer review |
| 9. Revision History | Date, version, author, summary | One row per significant change |

**Common mistakes**: Leaving only `<!-- TODO: ... -->` in a section; no requirement IDs (R1, R2, …) in test catalogue; no risk table.

**Reference**: `module1/.solutions/VERIFICATION_PLAN.md` (stream_fifo example).

---

### Module 1 – Requirements Matrix

**Purpose**: Track mapping from requirements → tests → coverage → checkers so nothing is missed.

| Section | What to add | Good looks like |
|--------|-------------|-------------------|
| 1. Instructions | How you maintain Req IDs and mappings | 1–2 sentences |
| 2. Requirement List | Table: Req ID, Description, Priority (H/M/L), Notes | One row per requirement (e.g. R1, R2, …); at least 5–10 rows for a small DUT |
| 3. Requirement → Test Mapping | For each Req, which test IDs exercise it | Table or bullets (e.g. R1 → T1, T2) |
| 4. Requirement → Coverage Mapping | For each Req, which coverage items measure it | Same structure |
| 5. Requirement → Checkers / Assertions | For each Req, which scoreboards/assertions/checkers verify it | Same structure |
| 6. Test Definitions (Summary) | Test ID, name, intent, type, priority | Short table |
| 7. Coverage Item Definitions (Summary) | Coverage ID, what it measures | Short list |
| 8. Traceability Checklist | Confirm every Req has test + coverage + checker | Checklist; tick off as you verify |

**Common mistakes**: No requirement rows (Section 2 empty); Req IDs in matrix don't match IDs used in VERIFICATION_PLAN.md; sections 3–5 left as TODO only.

**Reference**: `module1/.solutions/REQUIREMENTS_MATRIX.md`.

---

### Module 1 – Checklist

**Purpose**: Track completion of Module 1 tasks so you and the script can see progress.

- Work through sections 1–9 in order.
- When a task is done, change `- [ ]` to `- [x]`.
- Run `./scripts/module1.sh` to see how many items are still unchecked.
- Don't check an item until the underlying work is done (e.g. "Requirements extracted" only after REQUIREMENTS_MATRIX.md §2 is filled).

**Reference**: `module1/.solutions/CHECKLIST.md`.

---

### Module 1 – High-Priority Requirements Traceability

**Purpose**: Quick reference for where each high-priority requirement is tested, covered, and checked.

- **Overview**: 2–3 sentences on how H-priority requirements are mapped.
- **High-Priority Requirements**: For each Priority=H requirement (e.g. R1, R2), list risk/complexity, test IDs, coverage IDs, checker IDs.
- **Traceability Matrix Summary**: One paragraph on overall traceability health and any gaps.
- **Verification Strategy Summary**: Short "elevator pitch" (what you verify, how, why).
- **References**: Links to spec and module docs.

**Reference**: `module1/.solutions/HIGH_PRIORITY_REQUIREMENTS_TRACEABILITY.md`.

---

## Module 2

Module 2 deliverable files (in `module2/`): `TEST_PLAN.md`, `REGRESSION_PLAN.md`, `COVERAGE_PLAN.md`, `CHECKLIST.md`.

### Module 2 – TEST_PLAN.md

**Purpose**: Turn the initial test catalogue from Module 1 into a detailed, reviewable test plan with tiers, types, and mapping to requirements.

- **What to add**: Test taxonomy (smoke / feature / stress / error); expanded test catalogue with ID, name, intent, type, priority, related Req IDs; negative and corner-case tests; mapping to UVM tests/sequences.
- **Good looks like**: Table(s) with test IDs and Req IDs; at least 10 tests; clear tiers.
- **Reference**: `module2/.solutions/TEST_PLAN.md`.

### Module 2 – REGRESSION_PLAN.md

**Purpose**: Define regression tiers (e.g. sanity, nightly, full), runtimes, and gating rules.

- **What to add**: Tier definitions (which tests run when); approximate runtimes; gating rules (e.g. sanity must pass before merge); optional seed/config policy.
- **Good looks like**: Table or list of tiers with test sets and runtimes.
- **Reference**: `module2/.solutions/REGRESSION_PLAN.md`.

### Module 2 – COVERAGE_PLAN.md

**Purpose**: Refine coverage model and closure tactics (optional but recommended).

- **What to add**: Covergroups/coverpoints/crosses; code coverage goals; closure criteria; gap analysis workflow.
- **Good looks like**: Short list of coverage items and "how we close."
- **Reference**: `module2/.solutions/COVERAGE_PLAN.md`.

### Module 2 – CHECKLIST.md

**Purpose**: Track completion of Module 2 tasks.

- Work through each section; mark completed items with `- [x]`. Run `./scripts/module2.sh` to see progress.
- **Reference**: `module2/.solutions/CHECKLIST.md`.

---

## Modules 3–8

Section-by-section fill guides for Modules 3–8 will be added in a later phase. For now, use each module's templates (and "How to fill" hints inside them), `moduleN/.solutions/`, and the module docs in `docs/MODULE3.md` … `docs/MODULE8.md`.

---

*For the overall self-paced workflow and "First time?" path, see [METHODS.md](METHODS.md). For use cases (FIFO, UART), see [USE_CASES.md](USE_CASES.md).*

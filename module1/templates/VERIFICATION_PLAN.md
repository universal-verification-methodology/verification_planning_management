# Verification Plan Template (Module 1)

> **Purpose**: Capture the initial verification plan for your chosen DUT  \
> **Module**: 1 – Verification Planning & Management Foundations (SV/UVM)

> **Instructions**: Fill in this document for your design. Copy from `module1/templates/` if needed, or edit the file in `module1/` directly. Reference: `module1/.solutions/`. For section-by-section guidance see [docs/FILL_GUIDES.md](../../docs/FILL_GUIDES.md#module-1---verification-plan).

## 1. Project and DUT Overview

> **How to fill**: Add project name, DUT name, owners, version. Describe the DUT in 2–4 sentences (function, interfaces, operating modes). List external interfaces (ports, clocks, resets) and dependencies.

<!-- TODO: Project name, DUT name, owners, version. DUT description, interfaces, operating modes. -->

## 2. Verification Objectives and Scope

> **How to fill**: List 3–5 verification goals (e.g. prove correctness, meet coverage, limit escaped defects). Then list in-scope features, out-of-scope items with justification, and a simple risk table (feature vs risk H/M/L).

<!-- TODO: Objectives, in-scope, out-of-scope, risk assessment. -->

## 3. Verification Strategy (SV/UVM)

> **How to fill**: Describe directed vs constrained-random vs scenario-based approach. Outline planned UVM structure (env/agent/sequence/scoreboard) and how assertions or protocol checkers will be used.

<!-- TODO: Approach (directed vs random), env architecture, checkers/assertions strategy. -->

## 4. Test Planning and Test Catalogue

> **How to fill**: Define test tiers (smoke, feature, stress, error). List an initial catalogue of at least 10 tests with ID, name, intent, and mapping to requirement IDs.

<!-- TODO: Test taxonomy, initial catalogue (>=10), mapping to requirements. -->

## 5. Coverage Planning

> **How to fill**: List key functional coverage items (covergroups/coverpoints/crosses). State code coverage goals and how you will decide when coverage is “closed.”

<!-- TODO: Functional coverage items, code coverage goals, closure philosophy. -->

## 6. Regression and Sign-off (High-Level)

> **How to fill**: Describe regression tiers (e.g. sanity, nightly, full). Add 3–5 draft sign-off criteria bullets (coverage, bugs, stability, docs).

<!-- TODO: Regression tiers concept and draft sign-off criteria. -->

## 7. Open Questions and Risks

> **How to fill**: List open questions, risks, and mitigations. Keep it short; update as the project progresses.

<!-- TODO: Open questions, risks, mitigations. -->

## 8. Review and Action Items

> **How to fill**: Add review notes and action items after self-review or peer review.

<!-- TODO: Review notes and action items. -->

## 9. Revision History

> **How to fill**: Track revisions (date, version, author, summary). Add a row when you make significant changes.

<!-- TODO: Track revisions. -->

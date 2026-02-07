# Use Case: UART (Spec-Only)

A **second use case** to show how the same planning templates are filled for a different kind of DUT. This example is **spec-only**: no RTL or filled planning docs are provided in the repo. You apply the templates yourself with a UART (or similar serial block) in mind.

---

## Title and DUT

**UART** (or simple serial TX/RX block) — A serial transmitter/receiver with configurable baud rate, data bits, stop bits, and optional parity. Interfaces: TX line, RX line, clock, reset; optional flow control (e.g. RTS/CTS). Typical behaviors: framing, start/stop bits, parity errors, overrun, break detection.

---

## Verification focus

- **Timing and framing**: Baud timing, start/stop bit alignment, parity generation/check.
- **Protocol and errors**: Framing errors, overrun, break condition, invalid configurations.
- **Flow control**: If present, RTS/CTS or similar; backpressure and FIFO behavior.
- **Configuration space**: Different data lengths (7/8/9), stop bits (1/2), parity (none/odd/even).

---

## Artifacts

This use case does **not** include RTL or pre-filled planning docs in the repository.

| What to do | How |
|------------|-----|
| **Spec** | Use an internal UART spec or a short write-up (interfaces, modes, error conditions). |
| **Plans** | Copy `module1/templates/` (and later `module2/templates/`, etc.) into your workspace and fill them for the UART. |
| **Reference** | Use the **Stream FIFO** solution (`module1/.solutions/`) as the structural reference: same sections, same style of tables and bullets, but with UART-specific content. |

---

## Teaching points

1. **Same template, different content** — VERIFICATION_PLAN.md still has sections 1–9 (Overview, Objectives, Strategy, Test Catalogue, Coverage, Regression, Risks, Review, Revisions). For UART you fill them with UART interfaces, UART test tiers (e.g. baud accuracy, framing errors, overrun), and UART coverage items (e.g. baud × data length, error type).
2. **Different risk profile** — A UART might rate “timing and baud” as H (customer-visible) and “parity” as M. The risk table format is the same as in the FIFO use case; the entries change.
3. **Req → Test mapping** — Requirements (R1: correct TX at all baud rates, R2: framing error detection, …) map to tests (T1: baud_sweep, T2: framing_error_inject, …). Same traceability pattern as FIFO.
4. **Test strategy** — UART often needs directed tests for baud and framing, plus negative tests (invalid config, overrun). The test catalogue table has the same columns (ID, name, intent, type, Req IDs); the rows are UART-specific.
5. **Coverage** — Covergroups might include baud rate × data length, error type × configuration. Coverage closure philosophy (functional + code goals) is the same; the coverpoints differ.

---

## Minimal vs full (applies to any use case)

- **Minimal**: Fill each section with just enough to pass the scripts (no TODOs, requirement rows in the matrix, checklist items checked). Good for a first pass or a small block.
- **Full**: Like `module1/.solutions/` for the FIFO: detailed DUT description, risk table, full test catalogue (≥10 tests), Req→Test→Coverage→Checkers mapping, and high-priority traceability. Good for review and sign-off.

See [FILL_GUIDES.md – Minimal vs full](FILL_GUIDES.md#minimal-vs-full) for where to find examples.

---

## How to use this use case

- **Study**: Read this doc and the FIFO use case; compare “FIFO verification focus” vs “UART verification focus” to see how the same template serves different DUTs.
- **Do**: Create a short UART spec (or use an existing one), then fill `module1/` workspace from `module1/templates/` with UART content. Run `./scripts/module1.sh` and fix any missing sections or traceability.
- **Extend**: In Module 2, fill TEST_PLAN, REGRESSION_PLAN, COVERAGE_PLAN for the UART using the same structure as `module2/.solutions/` (FIFO).

---

*See also: [USE_CASE_FIFO.md](USE_CASE_FIFO.md), [FILL_GUIDES.md](FILL_GUIDES.md), [METHODS.md](METHODS.md).*

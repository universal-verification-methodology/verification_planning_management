# Use Case: Stream FIFO

This is the **primary worked example** for the course. All Module 1–8 reference solutions are built around this DUT.

---

## Title and DUT

**Stream FIFO** (`stream_fifo`) — A parameterizable streaming FIFO that buffers data between a source and a sink using ready/valid handshakes. It stores up to `DEPTH` elements of `DATA_WIDTH` bits each, guarantees in-order delivery, and exposes fill level plus sticky overflow/underflow flags.

---

## Verification focus

- **Data path and ordering**: In-order transfer, level accuracy, simultaneous push/pop.
- **Protocol and boundaries**: Ready/valid handshaking, empty/full behavior, backpressure.
- **Error and robustness**: Sticky overflow/underflow flags, reset semantics, stress and corner cases.

---

## Artifacts

| Resource | Location |
|----------|----------|
| **RTL** | [`common_dut/rtl/stream_fifo.sv`](../common_dut/rtl/stream_fifo.sv) |
| **Testbench skeleton** | [`common_dut/tb/`](../common_dut/tb/) |
| **Module 1 filled plans** | [`module1/.solutions/`](../module1/.solutions/) — VERIFICATION_PLAN.md, REQUIREMENTS_MATRIX.md, CHECKLIST.md, HIGH_PRIORITY_REQUIREMENTS_TRACEABILITY.md |
| **Module 2–8 solutions** | `module2/.solutions/` … `module8/.solutions/` (same DUT, extended plans) |

---

## Teaching points

1. **Risk table** — Section 2.4 of the verification plan shows a feature vs risk (H/M/L) table (e.g. full/empty boundary = H, sticky flags = H). Use this pattern for any DUT.
2. **Req → Test mapping** — REQUIREMENTS_MATRIX.md §3 maps each requirement (R1, R2, R3) to test IDs (T1, T2, …). The verification plan test catalogue (§4) uses the same IDs so traceability is consistent.
3. **Req → Coverage → Checkers** — Sections 4 and 5 of the matrix map requirements to coverage items (e.g. CG_LEVEL, CG_FLAGS) and to checkers/assertions (SB_MAIN, A_OVERFLOW, A_UNDERFLOW). Every requirement is covered and checked.
4. **Coverage closure** — The plan states coverage goals and “how we close” (functional + code). Same idea applies to any block.
5. **High-priority traceability** — HIGH_PRIORITY_REQUIREMENTS_TRACEABILITY.md gives a short summary of where each H-priority requirement is tested, covered, and checked. Useful for reviews and sign-off.

---

## How to use this use case

- **Learn**: Read `module1/.solutions/` section by section and compare with `module1/templates/` to see what “filled” looks like.
- **Practice**: Use the same DUT (stream_fifo) and copy templates to your workspace; fill them using the solution as reference, then run `./scripts/module1.sh`.
- **Transfer**: Study the FIFO solution, then apply the same document structure to a different DUT (e.g. UART) using the templates from scratch.

---

*See also: [USE_CASE_UART.md](USE_CASE_UART.md), [FILL_GUIDES.md](FILL_GUIDES.md), [METHODS.md](METHODS.md).*

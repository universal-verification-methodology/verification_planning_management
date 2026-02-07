# Use Cases

This document describes the **worked use cases** for the course and links to their artifacts. Use them to see how the same planning templates are filled for different DUT types.

---

## Use cases

| Use case | DUT | Artifacts | Description |
|----------|-----|-----------|-------------|
| **[Stream FIFO](USE_CASE_FIFO.md)** | `stream_fifo` | RTL in `common_dut/rtl/`; filled plans in `module1/.solutions/` … `module8/.solutions/` | Primary example: ready/valid FIFO, overflow/underflow flags, in-order delivery. |
| **[UART](USE_CASE_UART.md)** | UART (spec-only) | No RTL or filled docs in repo; apply templates with UART in mind | Second example: serial TX/RX, framing, baud, errors. Same template structure, different content. |

---

## How to use

- **First time**: Start with the **Stream FIFO** use case. Read `module1/.solutions/` and run `./scripts/module1.sh` on your workspace (copy from `module1/templates/` and fill using the solution as reference).
- **Transfer**: Study the FIFO solution, then apply the same structure to a **UART** (or another DUT) using the templates from scratch. See [USE_CASE_UART.md](USE_CASE_UART.md).
- **Minimal vs full**: See [FILL_GUIDES.md – Minimal vs full](FILL_GUIDES.md#minimal-vs-full) for “minimum to pass the script” vs “full depth” examples.

---

*For section-by-section fill guidance, see [FILL_GUIDES.md](FILL_GUIDES.md). For the self-paced workflow, see [METHODS.md](METHODS.md).*

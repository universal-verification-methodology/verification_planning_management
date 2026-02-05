# Verification Planning and Management Course

A **self-paced** course for learning verification planning and management using SystemVerilog/UVM. This repository provides a complete learning path from initial verification planning through advanced UVM orchestration and VIP delivery.

## License

This work is licensed under the [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/) (CC BY 4.0).

You are free to:
- **Share** — copy and redistribute the material in any medium or format
- **Adapt** — remix, transform, and build upon the material for any purpose, even commercially

Under the following terms:
- **Attribution** — You must give appropriate credit, provide a link to the license, and indicate if changes were made

## Quick Start

1. **Read** [`METHODS.md`](METHODS.md) to understand the self-paced learning structure.
2. **Start with Module 1**: Navigate to `module1/` and read its `README.md`.
3. **Edit workspace files**: The files in `module1/` (e.g., `VERIFICATION_PLAN.md`) are your workspace.
4. **Use templates**: Copy from `module1/templates/` if you need a fresh start.
5. **Reference solutions**: View `module1/.solutions/` when you want to compare or understand the methodology.
6. **Validate**: Run `./scripts/module1.sh` to check your progress.

## Course Structure

This course consists of **8 modules**, each building on the previous:

- **Module 1**: Verification Planning & Management Foundations
- **Module 2**: Test Planning & Strategy in Depth
- **Module 3**: Coverage Planning & Analysis in Practice
- **Module 4**: UVM Environment & Checker Maturity
- **Module 5**: Regression Management & Advanced UVM Orchestration
- **Module 6**: Complex Multi-Agent & Protocol Testbenches
- **Module 7**: Real-World Verification Applications & VIP
- **Module 8**: Capstone: End-to-End Verification & VIP Delivery

## Self-Paced Learning Structure

Each module (`module1/` through `module8/`) follows the same structure:

- **`moduleN/templates/`** — Empty/skeleton planning documents
- **`moduleN/.solutions/`** — Filled-in reference solutions (hidden, opt-in to view)
- **`moduleN/*.md`** — Your workspace (edit these files directly)
- **`moduleN/README.md`** — Module-specific instructions

## Validation Scripts

Each module has a validation script in `scripts/`:

```bash
./scripts/module1.sh    # Check Module 1 progress
./scripts/module2.sh    # Check Module 2 progress
# ... and so on
```

Run these scripts to get feedback on:
- Missing required files
- TODO markers remaining
- Checklist completion status

## Documentation

- **[`METHODS.md`](METHODS.md)** — Detailed explanation of the self-paced methodology
- **[`docs/MODULE1.md`](docs/MODULE1.md)** through **[`docs/MODULE8.md`](docs/MODULE8.md)** — Detailed module objectives and topics
- Each `moduleN/README.md` — Quick reference and self-paced learning guide

## Repository Contents

- **`module1/` through `module8/`** — Course modules (workspace + templates + solutions)
- **`scripts/`** — Validation scripts for each module
- **`common_dut/`** — Shared DUT RTL and testbench skeletons
- **`docs/`** — Detailed module documentation
- **`solutions/`** — Additional instructor reference code (e.g., DMA capstone)

## Getting Help

- Check the module `README.md` files for module-specific guidance
- Review `moduleN/.solutions/` for reference examples
- Run `./scripts/moduleN.sh --help` for script usage

## Attribution

When using or adapting this material, please provide attribution as required by the CC BY 4.0 license.

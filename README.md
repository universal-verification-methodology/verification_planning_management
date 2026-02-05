# Verification Planning and Management Course

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![Course](https://img.shields.io/badge/Course-Self--Paced-blue.svg)](#)
[![Modules](https://img.shields.io/badge/Modules-8-green.svg)](#course-structure)
[![SystemVerilog](https://img.shields.io/badge/SystemVerilog-UVM-orange.svg)](https://www.accellera.org/)

A **self-paced** course for learning verification planning and management using SystemVerilog/UVM. This repository provides a complete learning path from initial verification planning through advanced UVM orchestration and VIP delivery.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Quick Start](#quick-start)
- [Course Structure](#course-structure)
- [Self-Paced Learning Structure](#self-paced-learning-structure)
- [Validation Scripts](#validation-scripts)
- [Documentation](#documentation)
- [Repository Contents](#repository-contents)
- [Getting Help](#getting-help)
- [License](#license)
- [Attribution](#attribution)

## 🎯 Overview

This repository is a complete **self-paced** educational resource for verification planning and management. It covers:

- **8 Progressive Modules**: From verification planning foundations to end-to-end VIP delivery
- **Workspace-Based Learning**: Edit planning documents directly in each module
- **Templates and Solutions**: Skeleton documents and reference solutions (opt-in)
- **Validation Scripts**: Automated checks for progress and completeness
- **Shared DUT**: Common RTL and testbench skeletons across modules
- **Detailed Documentation**: Module objectives, topics, and methodology guides

### Why Verification Planning and Management?

- **Industry Relevance**: Structured planning is essential for successful verification projects
- **Methodology Alignment**: Aligns with UVM and modern verification practices
- **Self-Paced**: Learn at your own speed with clear milestones
- **Hands-On**: Edit real planning artifacts (e.g., `VERIFICATION_PLAN.md`) and validate your work
- **Reference Material**: Compare with solutions when you need guidance

## ✨ Features

- ✅ **8 Modules**: Complete path from foundations to capstone
- ✅ **Workspace Files**: Edit `moduleN/*.md` directly as your workspace
- ✅ **Templates**: Copy from `moduleN/templates/` for a fresh start
- ✅ **Reference Solutions**: View `moduleN/.solutions/` when you want to compare
- ✅ **Validation Scripts**: Run `./scripts/moduleN.sh` to check progress
- ✅ **Methodology Guide**: [`METHODS.md`](METHODS.md) explains the self-paced structure
- ✅ **Module Documentation**: Detailed objectives in `docs/MODULE1.md` through `docs/MODULE8.md`
- ✅ **Common DUT**: Shared RTL and testbench in `common_dut/`

## 🚀 Quick Start

### 1. Understand the Methodology

Read **[`METHODS.md`](METHODS.md)** to understand the self-paced learning structure.

### 2. Start with Module 1

- Navigate to `module1/` and read its `README.md`.
- The files in `module1/` (e.g., `VERIFICATION_PLAN.md`) are your **workspace**.

### 3. Use Templates and Solutions

- **Templates**: Copy from `module1/templates/` if you need a fresh start.
- **Solutions**: View `module1/.solutions/` when you want to compare or understand the methodology.

### 4. Validate Your Progress

```bash
./scripts/module1.sh
```

Run the script to get feedback on missing files, TODO markers, and checklist completion.

## 🎓 Course Structure

This course consists of **8 modules**, each building on the previous:

| Module | Title |
|--------|--------|
| **Module 1** | Verification Planning & Management Foundations |
| **Module 2** | Test Planning & Strategy in Depth |
| **Module 3** | Coverage Planning & Analysis in Practice |
| **Module 4** | UVM Environment & Checker Maturity |
| **Module 5** | Regression Management & Advanced UVM Orchestration |
| **Module 6** | Complex Multi-Agent & Protocol Testbenches |
| **Module 7** | Real-World Verification Applications & VIP |
| **Module 8** | Capstone: End-to-End Verification & VIP Delivery |

## 📁 Self-Paced Learning Structure

Each module (`module1/` through `module8/`) follows the same structure:

| Path | Description |
|------|-------------|
| **`moduleN/templates/`** | Empty/skeleton planning documents |
| **`moduleN/.solutions/`** | Filled-in reference solutions (hidden, opt-in to view) |
| **`moduleN/*.md`** | Your workspace (edit these files directly) |
| **`moduleN/README.md`** | Module-specific instructions |

## 🔧 Validation Scripts

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

For script usage: `./scripts/moduleN.sh --help`

## 📖 Documentation

### Core Documentation

- **[`METHODS.md`](METHODS.md)** — Detailed explanation of the self-paced methodology

### Module Documentation

- **[`docs/MODULE1.md`](docs/MODULE1.md)** through **[`docs/MODULE8.md`](docs/MODULE8.md)** — Detailed module objectives and topics
- Each **`moduleN/README.md`** — Quick reference and self-paced learning guide for that module

## 📂 Repository Contents

```
verification_planning_management/
├── docs/                    # Detailed module documentation
│   ├── MODULE1.md          # Module 1 objectives and topics
│   ├── ...                 # MODULE2–MODULE8
│   └── ...
├── module1/ … module8/     # Course modules (workspace + templates + solutions)
│   ├── templates/          # Skeleton planning documents
│   ├── .solutions/         # Reference solutions (opt-in)
│   ├── *.md                # Your workspace files
│   └── README.md           # Module instructions
├── scripts/                # Validation scripts per module
│   ├── module1.sh
│   ├── ...
│   └── module8.sh
├── common_dut/             # Shared DUT RTL and testbench skeletons
├── METHODS.md              # Self-paced methodology guide
└── README.md               # This file
```

## 📞 Getting Help

1. **Module guidance**: Check the `README.md` in each `moduleN/` directory.
2. **Reference examples**: Review `moduleN/.solutions/` when you need a comparison.
3. **Script usage**: Run `./scripts/moduleN.sh --help` for validation script options.
4. **Methodology**: Read [`METHODS.md`](METHODS.md) for the overall learning structure.

## 📄 License

This work is licensed under the [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/) (CC BY 4.0).

[![CC BY 4.0](https://i.creativecommons.org/l/by/4.0/88x31.png)](https://creativecommons.org/licenses/by/4.0/)

### What this means

- ✅ **You are free to:**
  - **Share** — copy and redistribute the material in any medium or format
  - **Adapt** — remix, transform, and build upon the material for any purpose, even commercially

- 📝 **Under the following terms:**
  - **Attribution** — You must give appropriate credit, provide a link to the license, and indicate if changes were made.

### Attribution

When using or adapting this material, please provide attribution as required by the CC BY 4.0 license (e.g., link to this repository and to the [license](https://creativecommons.org/licenses/by/4.0/)).

---

**Start with Module 1** → Read [`METHODS.md`](METHODS.md), then open `module1/README.md` and begin your workspace in `module1/`.

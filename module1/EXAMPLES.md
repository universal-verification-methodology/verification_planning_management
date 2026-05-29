# Module 1 Examples

Hands-on examples for **Verification Planning & Management Foundations**: templates, shared DUT, reference solutions, and validation.

---

## 1. Verification plan template (`plan_template/`)

Review the skeleton verification plan before filling your workspace copy.

```bash
head -30 module1/templates/VERIFICATION_PLAN.md
```

---

## 2. Requirements matrix template (`matrix_template/`)

See how requirements map to tests and coverage in the template.

```bash
head -25 module1/templates/REQUIREMENTS_MATRIX.md
```

---

## 3. Reference solution (`solutions/`)

Compare your work to the Stream FIFO reference solution (optional).

```bash
head -20 module1/.solutions/VERIFICATION_PLAN.md
```

---

## 4. Shared DUT RTL (`dut_rtl/`)

Inspect the course DUT used across all modules.

```bash
head -35 common_dut/rtl/stream_fifo.sv
```

---

## 5. Module validation (`validate/`)

Run the Module 1 planning orchestrator from the repository root.

```bash
./scripts/module1.sh --check
```

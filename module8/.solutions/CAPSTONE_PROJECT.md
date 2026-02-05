# Capstone Project Plan (Module 8)

> **Purpose**: Define and track your major end‑to‑end verification or VIP project.  
> **Module**: 8 – Capstone: End‑to‑End Verification & VIP Delivery (SV/UVM)

## 1. Capstone Choice

- **Project ID / Name**: `CAP_DMA_FIFO`  
- **Brief Description**:  
  - Verify a simple **DMA engine** that uses the shared `stream_fifo` DUT as its internal buffer.  
  - The DMA engine reads descriptors from a register interface, transfers a programmable number of bytes from a source to a sink stream, and reports status and errors via status/IRQ.  
  - The capstone applies the full verification lifecycle (Modules 1–7) to this DMA, including requirements, plan, UVM environment, coverage, regressions, and a small DMA verification IP package.  
- **Type**:
  - [x] Block/IP verification  
  - [ ] Subsystem / SoC‑style integration  
  - [ ] Protocol VIP (reusable agent + checker + coverage)  

## 2. Requirements and Goals

Summarize the key requirements and goals (link to `REQUIREMENTS_MATRIX.md` when used).

### 2.1 Functional Requirements (Draft)

| Req ID     | Description                                                   | Priority (H/M/L) | Notes |
|------------|---------------------------------------------------------------|------------------|-------|
| CAP_R1     | DMA shall support linear memory‑to‑memory transfers           | H                | Single channel, simple mode |
| CAP_R2     | DMA shall use `stream_fifo` as an internal buffer             | H                | Valid/ready semantics preserved |
| CAP_R3     | DMA shall raise a DONE flag/IRQ when transfer completes       | H                | With correct transfer count     |
| CAP_R4     | DMA shall detect and flag invalid length (e.g., 0 or >MAX)    | M                | ERROR status + optional IRQ    |
| CAP_R5     | DMA shall detect FIFO overflow/underflow and flag ERROR       | H                | Propagate from `stream_fifo`   |
| CAP_R6     | DMA shall support abort/reset behavior during an active xfer  | M                | Graceful stop, documented state|
| CAP_R7     | DMA shall provide readable status registers (busy, done, err) | M                | For SW polling                  |

### 2.2 Non‑Functional / Quality Goals

- **Functional**: All in‑scope requirements (R1–R7) covered by tests, checks, and coverage.  
- **Coverage** (tunable target): e.g., ≥ 95% statement / ≥ 90% branch on DMA RTL; functional coverage closed on:
  - Transfer lengths (small/medium/large, boundary values).  
  - Status/error codes.  
  - FIFO level behaviors during transfer (empty/partial/full).  
- **Regression**: Stable `core_nightly` job for the DMA, with:
  - No known flakes in sanity/core jobs.  
  - Stress/regression jobs available for deeper exploration.  

## 3. Re‑use of Earlier Modules

List which earlier artifacts you are reusing or extending:

- From Module 1 (planning):  
  - Extend `VERIFICATION_PLAN.md` with DMA‑specific scope, assumptions, and risks based on R1–R7.  
- From Module 2 (tests/regression):  
  - Add DMA tests to `TEST_PLAN.md` (sanity, feature, stress, negative).  
  - Map DMA tests into tiers/jobs in `REGRESSION_PLAN.md`.  
- From Module 3 (coverage):  
  - Extend `COVERAGE_DESIGN.md` with DMA‑specific covergroups (lengths, status/error codes, FIFO level profiles during transfers).  
  - Log DMA coverage runs in `COVERAGE_RUN.md`.  
- From Module 4 (env/checkers):  
  - Reuse/extend `stream_if` and `stream_env` for DMA source/sink streams.  
  - Add a DMA register interface agent+monitor and a DMA scoreboard/ref model in `ENV_DESIGN.md` / `CHECKER_PLAN.md`.  
- From Module 5 (regressions/UVM):  
  - Hook DMA tests into jobs in `REGRESSION_OPS.md`.  
  - Optionally add DMA‑specific virtual sequences/config in `ADVANCED_UVM_PLAN.md`.  
- From Module 6–7 (complex benches/VIP):  
  - If time permits, treat the DMA environment as a small **DMA VIP** and document its usage in `VIP_DESIGN.md` and `PROJECTS.md`.  

## 4. Architecture and Environment

Describe your capstone architecture at a high level.

- **DUT**: `dma_engine` (new RTL block) that:
  - Exposes a simple register interface (e.g., address/data/write‑enable) for configuration.  
  - Uses a `stream_fifo` instance internally to buffer data between source and sink.  
  - Drives/receives `stream_if`‑style streaming interfaces toward source and sink models or agents.  
- **Env and agents** (UVM, building on Module 4–6):
  - `reg_agent`: drives DMA configuration/status registers.  
  - `src_stream_agent` / `snk_stream_agent`: reuse/extend `stream_env` components for source/sink.  
  - `dma_scoreboard`: compares expected vs actual transfers and checks status/IRQ behavior.  
  - Optional `protocol_checker`: verifies basic correctness of the register protocol (if you define one).  
- **Integration**:
  - For the capstone, treat DMA as a **block‑level DUT with three logical interfaces**:
    - Register interface.  
    - Source stream.  
    - Sink stream.  

Textual architecture sketch:

```text
uvm_test_top (dma_capstone_test)
└── dma_env
    ├── reg_agent          (configures DMA descriptors/ctrl)
    ├── src_stream_agent   (drives source stream into DMA/stream_fifo)
    ├── snk_stream_agent   (monitors sink stream out of DMA/stream_fifo)
    ├── dma_scoreboard     (checks transfers, status, errors)
    └── dma_cov            (optional coverage subscriber)
```

Code locations (planned):

- RTL: `common_dut/rtl/dma_engine.sv` (or `dma/rtl/` subtree).  
- TB/UVM: extend `module4/tb/stream_pkg.sv` and add DMA‑specific UVM components in a DMA package (e.g., `module4/tb/dma_pkg.sv`) and a top `tb_dma_uvm.sv`.  

## 5. Test Strategy and Regression

Summarize the key tests and regressions:

- Which **tiers/jobs** (from `REGRESSION_OPS.md`) cover this capstone?  
  - `sanity`: one or two short DMA transfers (small lengths, no errors).  
  - `core_nightly`: feature + negative tests (boundary lengths, invalid descriptors, FIFO error propagation).  
  - `stress_weekly` (optional): long/high‑load transfers, randomized lengths, back‑to‑back programming.  
- Any new capstone‑specific jobs?  
  - Optionally define a `dma_core` job that runs only DMA‑focused tests.  
- Key test IDs and scenarios (to be defined in `TEST_PLAN.md`), e.g.:
  - `DMA_SANE_01`: simple 16‑byte transfer, no errors.  
  - `DMA_LEN_BOUND_01`: transfers with length = 1, max_len.  
  - `DMA_ERR_LEN_01`: invalid length (0 or >MAX) → ERROR + no transfer.  
  - `DMA_FIFO_ERR_01`: force FIFO overflow/underflow → DMA flags ERROR.  
  - `DMA_ABORT_01`: abort/reset mid‑transfer and verify final state.  

Document concrete mapping in `TEST_PLAN.md` and summarize here once defined.

## 6. Coverage Strategy

Describe how you will measure and close coverage:

- Functional coverage focus areas (link to `COVERAGE_DESIGN.md`).  
- Protocol or system‑level coverage specific to this capstone.  
- How you will use coverage runs (`COVERAGE_RUN*.md`) to drive new tests.

Notes (initial ideas):

- Extend existing FIFO coverage to consider DMA‑level behaviors (e.g., relationship between programmed length and level profile).  
- Add coverage for **descriptor fields** (src/dst/len ranges) and **status codes** (DONE, ERROR sub‑types).  
- Add cross coverage for **length × error_type**, **channel (if >1) × mode**, etc.  

## 7. Deliverables

List what you will deliver at the end of the capstone:

- Code:
  - `dma_engine` RTL block and integration with `stream_fifo`.  
  - UVM env and DMA‑specific agents/sequences/scoreboards.  
  - Regression scripts or make targets to run DMA regressions.  
- Docs:
  - Updated plans (Modules 1–7) reflecting DMA.  
  - A short **DMA verification README** explaining how to run and interpret results.  
- Metrics:
  - Final coverage snapshots.  
  - Regression stability summary.  

## 8. Timeline and Milestones

Define major milestones and rough dates.

| Milestone ID | Description                          | Target Date | Status |
|--------------|--------------------------------------|-------------|--------|
| CAP_M1       | Plan complete, env skeleton updated  | 2026-02-05   | Done   |
| CAP_M2       | Core tests running, initial coverage | TBD          | Planned |
| CAP_M3       | Coverage/regression goals met        | TBD          | Planned |

## 9. Retrospective (to be filled at the end)

After completing the capstone, record:

- What worked well.  
- What you would change next time.  
- Which parts of Modules 1–7 were most/least helpful.  

Notes:



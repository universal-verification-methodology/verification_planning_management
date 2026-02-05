# Coverage Runs Log (Module 3)

> **Purpose**: Record coverage-enabled regression runs, key metrics, gaps, and follow-up actions.  
> **Module**: 3 – Coverage Planning & Analysis in Practice (SV/UVM)

## 1. Instructions

- Use this file as a **lightweight lab notebook** for coverage work.  
- For each significant run, add an entry with:
  - When, what tests, which DUT version, which simulator.  
  - Key summary metrics (functional + code).  
  - Notable gaps and hypotheses.  
  - Planned closure actions.

## 2. Run Entries

### Run 1 – Initial CORE smoke with coverage

- **Date**: 2026-02-05  
- **Engineer**: Yongfu  
- **DUT Revision**: stream_fifo (common_dut/rtl), default DATA_WIDTH=8, DEPTH=16  
- **Environment**:
  - Simulator: Verilator (or placeholder; coverage design phase)  
  - UVM/Tool versions: UVM 1.2 / tool TBD  
- **Test Set / Tier**:
  - Tier: CORE (subset)  
  - Tests: SMK_001, SMK_002, SMK_003, FTR_001, FTR_002, ERR_001, ERR_002  
  - Seed policy: fixed (1001–1003 for smoke, 2001–2002 for feature, 3001–3002 for error)  

#### 2.1 Functional Coverage Summary (High-Level)

- Key covergroups and approximate percentages:

| Coverage ID     | Metric / Notes                       |
|-----------------|--------------------------------------|
| CG_LEVEL        | ~70% (empty/full hit; mid bands partial) |
| CG_OPS          | ~75% (idle/push/pop hit; push_and_pop sparse) |
| CG_FLAGS        | ~80% (overflow/underflow set hit; clear_on_reset hit) |
| CG_BACKPRESSURE | ~50% (none/sink_slow hit; source_slow/both_slow gaps) |

#### 2.2 Code Coverage Summary (High-Level)

- Statement: ~88% (target ≥95%)  
- Branch: ~82% (target ≥90%)  
- Toggle / Condition: not yet collected  
- Notable excluded regions: Reset assertion block; debug-only paths (none currently).  

#### 2.3 Observed Gaps

| Area           | Observation / Gap                                  | Hypothesized Cause                    |
|----------------|-----------------------------------------------------|----------------------------------------|
| CG_LEVEL mid   | Mid occupancy (26–75%) under-sampled                | test / need more varied push/pop counts |
| CG_OPS         | push_and_pop same-cycle bin rarely hit             | constraint / need FTR_002 and backpressure mix |
| CG_BACKPRESSURE| source_slow and both_slow bins missing              | test / add STR_001, STR_011 to CORE subset |
| CROSS_LEVEL_FLAGS | level×overflow at “full” hit; level×underflow at “empty” hit; other level bins partial | test / extend boundary tests |
| Code branch    | Pointer wrap branch (rptr/wptr at DEPTH-1→0) not hit | test / add FTR_006 to this run         |

#### 2.4 Planned Actions

| Area / Gap       | Planned Action                                              | Owner  | Target Module |
|------------------|-------------------------------------------------------------|--------|----------------|
| CG_LEVEL mid     | Add directed sequence in FTR_010 to sweep level 1..DEPTH-1; add to test_plan if missing | Yongfu | 2 / 3          |
| CG_OPS push_and_pop | Run FTR_002 in regression; add constraint in random seq to allow same-cycle push+pop | Yongfu | 3               |
| CG_BACKPRESSURE  | Include STR_001, STR_002, STR_011 in next CORE run; document in regression_plan | Yongfu | 2               |
| CROSS_LEVEL_FLAGS| Run FTR_001, ERR_001, ERR_002 together; consider FTR_013 for flag combos       | Yongfu | 3               |
| Code pointer wrap| Add FTR_006 (wrap_around_test) to CORE tier and re-run                       | Yongfu | 2               |

#### 2.5 Notes

- First coverage run used to validate coverage_design.md and identify initial gaps.  
- Closure actions feed back into module2 test_plan and regression_plan (tier membership, sequence constraints).  

---

### Template for next run (copy for future runs)

- **Date**: YYYY-MM-DD  
- **Engineer**: …  
- **DUT Revision**: …  
- **Environment**: Simulator, UVM/tool versions  
- **Test Set / Tier**: Tier, tests, seed policy  

#### Functional / Code Summary

- Fill covergroup percentages and code metrics.  

#### Observed Gaps

- List ≥5 significant gaps with hypothesized cause.  

#### Planned Actions

- For ≥3 major gaps, define concrete closure actions.  

---

## 3. Summary of Runs

| Run Label   | Date       | Tier  | Key Takeaway                                      |
|-------------|------------|-------|----------------------------------------------------|
| Run 1       | 2026-02-05 | CORE  | Initial gaps: CG_LEVEL mid, CG_OPS push_and_pop, CG_BACKPRESSURE, pointer wrap; 5 closure actions defined |


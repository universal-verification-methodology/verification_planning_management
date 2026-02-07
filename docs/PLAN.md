# Improvement Plan: MD Evaluation, Template Guidance & Use Cases

This document captures planned improvements for:

1. **Automating evaluation** of user-filled MD files
2. **Helping users understand** how to fill templates
3. **Adding more use cases** for better understanding

Use this as the implementation roadmap. Items can be tackled in phases.

---

## Table of Contents

- [1. Automate Evaluation of MD Files](#1-automate-evaluation-of-md-files)
- [2. Help Users Fill Templates](#2-help-users-fill-templates)
- [3. More Use Cases](#3-more-use-cases)
- [4. Implementation Phases](#4-implementation-phases)

---

## 1. Automate Evaluation of MD Files

### 1.1 Current State

- **Scripts** (`scripts/module1.sh` … `module8.sh`) check:
  - Required files exist
  - Line count
  - TODO marker count
  - Checklist `- [ ]` vs `- [x]`
  - Simple regex (e.g. `| R[0-9]+` for requirement rows)
- **Not checked**: required sections, minimum content per section, cross-file consistency, table/list format.

### 1.2 Planned Improvements

#### A. Schema / structure checks

- **Define expected structure per document type**
  - Location: e.g. `scripts/schema/` or embedded in a single config (YAML/JSON).
  - For each `*_PLAN.md`, `REQUIREMENTS_MATRIX.md`, `CHECKLIST.md`, etc.:
    - List required top-level headings (e.g. `## 1. Project and DUT Overview`, `## 2. Verification Objectives`).
    - Optionally: required order, or "at least N of these sections must exist."
- **Implementation**
  - Parser: extract `##` / `###` headings from MD (e.g. small Python script or Bash + grep/sed).
  - Compare against schema; report missing sections and, if desired, "section still only TODO/placeholder" (e.g. section body is one line or only `<!-- TODO: ... -->`).
- **Optional**: Minimum line count or "non-comment, non-TODO" line count per section to consider it "filled."

#### B. Checklist parsing (stronger)

- **Current**: Count `- [ ]` and `- [x]` / `- [X]`.
- **Add**:
  - Validate list syntax (consistent `- ` and optional indentation).
  - Report **which** checklist items are still unchecked (e.g. line number + first 50 chars of text).
  - Optional: flag malformed lines (e.g. `- [x]` with typo).

#### C. Traceability checks (Module 1 and beyond)

- **Extract** requirement IDs from `REQUIREMENTS_MATRIX.md` (e.g. `R1`, `R2`, …).
- **Check**:
  - Same IDs (or a defined subset) appear in verification plan, test plan, or coverage plan where relevant.
  - Report "orphan" requirements (in matrix but not referenced elsewhere) and "missing" (referenced elsewhere but not in matrix).
- **Scope**: Start with Module 1 (VERIFICATION_PLAN, REQUIREMENTS_MATRIX); extend to Module 2+ where Req IDs are referenced.

#### D. Single entry point and CI

- **Single entry point**
  - One script or tool: e.g. `scripts/validate_all.sh` or `scripts/evaluate.py`.
  - Runs all module-specific checks; outputs one combined report (e.g. Markdown or JSON).
- **CI**
  - GitHub Actions (or similar) workflow that runs the evaluator on push/PR and reports pass/fail and file/section-level messages.

#### E. Optional semantic / quality hints

- **Do not** grade "correctness" of content.
- **Do** add optional checks that encourage good practice, e.g.:
  - Verification plan has at least one table (e.g. risk or test catalogue).
  - Requirements matrix has both "Requirement → Test" and "Requirement → Coverage" mappings.
- Report as "hints" or "suggestions," not hard failures.

### 1.3 Deliverables

| Item | Description |
|------|-------------|
| Schema/config | Expected headings (and optional rules) per document type per module |
| Parser | Script/tool to parse MD structure (headings, sections, TODOs) |
| Structure checker | Compares workspace MDs against schema; reports missing/empty sections |
| Checklist reporter | Which checklist items are unchecked + optional format checks |
| Traceability checker | Req ID extraction and cross-file consistency (Module 1 first) |
| `validate_all` | Single entry point (e.g. `validate_all.sh` or `evaluate.py`) |
| CI workflow | Run evaluator on push/PR; document in README |

---

## 2. Help Users Fill Templates

### 2.1 Current State

- One-line "Instructions" at top of each template; pointer to `templates/` and `.solutions/`.
- Module README and `docs/MODULEN.md` describe objectives and workflow but do not walk through each section of each document.

### 2.2 Planned Improvements

#### A. In-template hints

- **Per section** in each template, add a short "How to fill" line, e.g.:
  - *"List 3–5 verification goals; mention coverage and risk."*
  - *"Add one row per requirement; use IDs R1, R2, …"*
- Keep hints in the template; optionally trim or remove in `.solutions/` to avoid clutter.
- **Files to touch**: All `moduleN/templates/*.md` (and optionally `.solutions/*.md` if hints are removed there).

#### B. Per-document "fill guide"

- **Content**
  - Short guide per major document type (e.g. "How to fill VERIFICATION_PLAN," "How to fill REQUIREMENTS_MATRIX"):
    - Purpose of the document
    - Purpose of each section
    - What "good" looks like (bullets or short paragraph)
    - Common mistakes (e.g. leaving only TODOs, Req IDs not matching across docs)
- **Location**: e.g. `docs/FILL_GUIDES.md` (one file with sections) or `docs/module1/FILL_VERIFICATION_PLAN.md` etc.
- **Linking**: Add link in template header and in each `moduleN/README.md`.

#### C. Validation messages that teach

- **When a check fails**, script output should:
  - Identify **file and section** (e.g. "VERIFICATION_PLAN.md, section 2").
  - State **what is missing** (e.g. "Section 2 is still only TODO" or "No requirement rows found").
  - Add **one line "how to fix"** (e.g. "Add a short list of objectives; see module1/.solutions/VERIFICATION_PLAN.md §2.").
- **Checklist**: "Checklist item X still unchecked" plus a one-line hint.
- **Implementation**: Extend existing `scripts/moduleN.sh` (or the new evaluator) to emit these messages.

#### D. Progressive "first time" path

- **In METHODS.md or main README**, add a "First time?" subsection:
  - Step 1: Copy template to workspace.
  - Step 2: Fill Section 1 only; run script; fix until that part passes.
  - Step 3: Add Section 2; run again; repeat.
- Ties "how to fill" to automation so users learn by doing.

### 2.3 Deliverables

| Item | Description |
|------|-------------|
| In-template hints | One short "How to fill" per major section in each template |
| Fill guide doc(s) | `docs/FILL_GUIDES.md` or per-doc guides; linked from templates and module READMEs |
| Improved script output | File + section + "what's wrong" + "how to fix" (and checklist item-level where applicable) |
| First-time path | Short "First time?" steps in METHODS.md or README |

---

## 3. More Use Cases

### 3.1 Current State

- One worked example: **stream_fifo** in `common_dut/` and `moduleN/.solutions/`.
- "Use case" mentioned in MODULE8 (capstone) and MODULE7 (requirements/use cases) but no dedicated worked use-case docs for different DUT types.

### 3.2 Planned Improvements

#### A. Use case 1: Stream FIFO (existing)

- Keep as primary example.
- Optionally add a short **use-case doc** (e.g. `docs/USE_CASE_FIFO.md`) that:
  - States this is the main example.
  - Lists 3–5 teaching points (e.g. risk table, Req→Test mapping, coverage closure).
  - Links to `common_dut/` and `module1/.solutions/` (and other modules as relevant).

#### B. Use case 2: UART (or simple serial block)

- **Option A – Full**: Second DUT in `common_dut/` (or `examples/uart/`) plus a second set of filled docs (e.g. `module1/.solutions_uart/` or `examples/uart/`).
- **Option B – Spec-only**: No RTL; only a spec + filled planning docs to show "same template, different content."
- **Content**: Different interfaces (TX/RX, baud, framing), different test strategy (timing, framing errors, flow control).
- **Doc**: `docs/USE_CASE_UART.md` with purpose, links to artifacts, and 3–5 teaching points.

#### C. Use case 3: AXI-lite register block (optional)

- Same idea: address map, register fields, access types, interrupts.
- Emphasizes requirements matrix and traceability (Req → tests → coverage → checkers).
- **Doc**: `docs/USE_CASE_AXI_LITE.md` (or similar).

#### D. Use case 4: "Minimal passing" vs "full depth"

- **Minimal**: One small example (or doc) showing "minimum to pass the script" (e.g. TODOs removed, minimal tables/bullets).
- **Full**: Current `.solutions/` as "full depth" example.
- **Doc**: Short section in METHODS.md or FILL_GUIDES explaining "minimal vs full" and where to find each.

### 3.3 Use case document format

For each use case (FIFO, UART, AXI-lite, etc.):

- **Title and DUT**: Name, one-paragraph description.
- **Verification focus**: What this use case emphasizes (e.g. protocol, data path, control).
- **Artifacts**: Links to RTL (if any), filled plans (e.g. `.solutions/` or `examples/<name>/`).
- **Teaching points**: 3–5 bullets (e.g. "Risk table," "Req→Test mapping," "Coverage closure").
- **Optional**: Side-by-side "Template section → Example A → Example B" for 1–2 sections in FILL_GUIDES or USE_CASES.

### 3.4 Where to put use case artifacts

| Option | Description |
|--------|-------------|
| **A** | New `examples/` directory (e.g. `examples/stream_fifo/`, `examples/uart/`) with copies of filled MDs and a README per use case |
| **B** | Keep one canonical solution in `moduleN/.solutions/` (FIFO); add `moduleN/.solutions_uart/` (or similar) for second use case |
| **C** | Single `docs/USE_CASES.md` that describes 2–3 use cases and links to `.solutions/` or `examples/` paths |

Choose one (or a mix) and document the convention in README and METHODS.md.

### 3.5 Deliverables

| Item | Description |
|------|-------------|
| USE_CASE_FIFO.md | Short doc for stream_fifo; teaching points; links to artifacts |
| USE_CASE_UART.md | Second use case (spec-only or full); same structure |
| USE_CASE_AXI_LITE.md | Optional third use case |
| Minimal vs full | Section or short doc explaining "minimal passing" vs "full depth" and where to find examples |
| Use case artifacts | Filled MDs for UART (and optionally AXI-lite) in `examples/` or `.solutions_*` |

---

## 4. Implementation Phases

### Phase 1 – Quick wins (no new tools) ✅ COMPLETE

- Add **in-template hints** to Module 1 templates (and optionally others).
- Improve **validation messages** in existing `moduleN.sh`: file + section + "how to fix" where feasible.
- Add **"First time?"** path to METHODS.md or README.
- Add **docs/FILL_GUIDES.md** (skeleton) and link from Module 1 README and template headers.

### Phase 2 – Structure and single entry point ✅ COMPLETE

- Define **schema** for Module 1 documents (required headings).
- Implement **structure checker** (Python or Bash) and integrate into Module 1 script (or new evaluator).
- Add **checklist reporter** (which items unchecked).
- Add **validate_all** entry point (script or small tool) that runs all module checks and prints a combined report.

### Phase 3 – Traceability and CI ✅ COMPLETE

- Implement **traceability checker** (Req IDs; Module 1 only first).
- Add **CI workflow** (e.g. GitHub Actions) that runs the evaluator and documents in README.

### Phase 4 – Use cases and fill guide depth ✅ COMPLETE

- Add **USE_CASE_FIFO.md** and **USE_CASE_UART.md** (and optionally AXI-lite).
- Add **minimal vs full** explanation and links.
- Complete **FILL_GUIDES** with section-by-section guidance for Module 1 (and optionally Module 2).

### Phase 5 – Extend to all modules (optional) 🚧 IN PROGRESS

- ✅ Extend schema and structure checks to **Module 2**.
- ⏳ Extend schema and structure checks to Modules 3–8 (remaining).
- ⏳ Add traceability or cross-doc checks where Req IDs are used in later modules.

---

## References

- **METHODS.md** – Self-paced methodology; what scripts can and cannot check.
- **README.md** – Quick start, validation scripts, repo layout.
- **scripts/moduleN.sh** – Current validation logic per module.
- **moduleN/templates/** – Templates to add hints and link to fill guides.
- **moduleN/.solutions/** – Reference solutions; baseline for "full depth" and teaching points.

---

*Last updated: 2026-02-06*

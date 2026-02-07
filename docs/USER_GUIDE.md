# User Guide: Verification Planning and Management Course

**Welcome!** This guide helps you get the most out of the automated evaluation and guidance features.

---

## 🎯 What This Course Provides

This is a **self-paced** course for learning verification planning and management. You'll:

1. **Fill planning documents** (e.g., `VERIFICATION_PLAN.md`, `TEST_PLAN.md`) for a DUT of your choice
2. **Get automated feedback** from validation scripts that check structure, completeness, and consistency
3. **Learn from examples** (Stream FIFO worked example) and apply to your own design
4. **Progress through 8 modules** from initial planning to VIP delivery

---

## 🚀 Getting Started

### Step 1: Choose Your Approach

**Option A: Learn with Stream FIFO (Recommended for first time)**
- Use the Stream FIFO example (`module1/.solutions/`) as your reference
- Copy templates to workspace and fill them using the solution as a guide
- See [USE_CASE_FIFO.md](USE_CASE_FIFO.md)

**Option B: Transfer to Your Own DUT**
- Study the Stream FIFO solution to understand structure and depth
- Apply the same templates to your own DUT (e.g., UART, AXI-lite)
- See [USE_CASE_UART.md](USE_CASE_UART.md) for transfer guidance

### Step 2: Start with Module 1

1. **Copy templates**:
   ```bash
   cp module1/templates/*.md module1/
   ```

2. **Fill Section 1** of `VERIFICATION_PLAN.md`:
   - Replace `<!-- TODO: ... -->` with real content
   - Use the "How to fill" hint under that section
   - See [FILL_GUIDES.md](FILL_GUIDES.md) for detailed guidance

3. **Run validation**:
   ```bash
   ./scripts/module1.sh
   ```

4. **Fix issues**:
   - Read the "How to fix" messages
   - Add missing sections, reduce TODOs, check off checklist items

5. **Repeat** for Section 2, Section 3, etc.

See [METHODS.md — "First time?"](METHODS.md#4-first-time-progressive-path) for the full 6-step workflow.

---

## 📋 Understanding Validation Output

### Module 1 Validation

When you run `./scripts/module1.sh`, you'll see:

1. **Verification Plan Status**
   - File found/not found
   - TODO count (how many sections still need filling)
   - "How to fix" guidance

2. **Requirements Matrix Status**
   - File found/not found
   - Requirement row count (R1, R2, …)
   - Section-specific guidance if empty

3. **Checklist Status**
   - Total items, completed, remaining
   - **List of unchecked items** with line numbers and content preview

4. **Document Structure (Required Sections)**
   - Validates all required `##` headings are present
   - Reports missing sections with "How to fix"

5. **Traceability (Requirement IDs)**
   - Checks Req IDs in matrix are referenced in plan or high-priority doc
   - Reports "orphans" (IDs in matrix but not referenced elsewhere)

### Module 2 Validation

Similar to Module 1, but checks:
- TEST_PLAN.md, REGRESSION_PLAN.md, COVERAGE_PLAN.md, CHECKLIST.md
- Structure checking (required sections)
- No traceability check (Req IDs are Module 1 concern)

### Understanding Error Messages

All error messages follow this format:

```
File: FILENAME.md — Issue description
  Location: /full/path/to/file
  How to fix: specific actionable guidance
```

**Example**:
```
File: VERIFICATION_PLAN.md — 9 TODO marker(s) still present
  How to fix: replace each <!-- TODO: ... --> with real content for that section. 
  See module1/.solutions/VERIFICATION_PLAN.md for an example, or docs/FILL_GUIDES.md 
  for section-by-section guidance.
```

---

## 📚 Documentation Guide

### For First-Time Users

1. **Start here**: [METHODS.md](METHODS.md) — Read the "First time?" section
2. **Fill guidance**: [FILL_GUIDES.md](FILL_GUIDES.md) — Section-by-section help
3. **Examples**: [USE_CASES.md](USE_CASES.md) — See how templates are filled

### For Understanding Templates

- **In-template hints**: Each template has "How to fill" hints under each section
- **Fill guides**: [FILL_GUIDES.md](FILL_GUIDES.md) — Detailed tables showing what to add
- **Solutions**: `moduleN/.solutions/` — Full worked examples (Stream FIFO)

### For Learning from Examples

- **Stream FIFO**: [USE_CASE_FIFO.md](USE_CASE_FIFO.md) — Primary example with teaching points
- **UART**: [USE_CASE_UART.md](USE_CASE_UART.md) — Transfer example (spec-only)
- **Solutions**: `module1/.solutions/` through `module8/.solutions/` — Full examples

---

## 🛠️ Common Workflows

### Workflow 1: Fill a Section

1. Open template (e.g., `module1/templates/VERIFICATION_PLAN.md`)
2. Read the "How to fill" hint for the section you're working on
3. Copy template to workspace: `cp module1/templates/VERIFICATION_PLAN.md module1/`
4. Fill the section (replace TODO with real content)
5. Run: `./scripts/module1.sh`
6. Fix any reported issues
7. Repeat for next section

### Workflow 2: Check Progress

```bash
# See overall status
./scripts/module1.sh

# See only checklist
./scripts/module1.sh --checklist-status

# See only structure
./scripts/module1.sh --structure-status

# See only traceability
./scripts/module1.sh --traceability-status
```

### Workflow 3: Compare with Solution

1. Fill your workspace files
2. Run validation: `./scripts/module1.sh`
3. Open solution: `module1/.solutions/VERIFICATION_PLAN.md`
4. Compare section by section
5. Adjust your workspace based on solution depth/style

### Workflow 4: Transfer to New DUT

1. Study Stream FIFO solution: `module1/.solutions/`
2. Read [USE_CASE_UART.md](USE_CASE_UART.md) for transfer guidance
3. Copy templates: `cp module1/templates/*.md module1/`
4. Fill with your DUT's details (interfaces, requirements, tests)
5. Run validation and fix issues
6. Use same structure, different content

---

## 💡 Tips and Best Practices

### Tip 1: Start Minimal, Then Deepen

- **First pass**: Fill enough to pass scripts (no TODOs, required sections, basic content)
- **Second pass**: Add detail (risk tables, full test catalogue, traceability)
- **Reference**: See [FILL_GUIDES.md — Minimal vs full](FILL_GUIDES.md#minimal-vs-full)

### Tip 2: Use the Checklist

- Work through `CHECKLIST.md` section by section
- Don't check items until the underlying work is done
- Run `./scripts/module1.sh` to see which items are still unchecked

### Tip 3: Maintain Traceability

- Use consistent Req IDs (R1, R2, …) across all documents
- Reference Req IDs in test catalogue, risk table, etc.
- Run traceability check: `./scripts/module1.sh --traceability-status`
- Fix orphans (IDs in matrix but not referenced elsewhere)

### Tip 4: Learn from Errors

- Read the "How to fix" messages carefully
- They point to specific files, sections, and solutions
- Use `.solutions/` to see what "good" looks like

### Tip 5: Use Fill Guides

- [FILL_GUIDES.md](FILL_GUIDES.md) has tables showing:
  - What to add in each section
  - What "good" looks like
  - Common mistakes to avoid

---

## ❓ Troubleshooting

### "File missing" Error

**Problem**: Script reports file not found

**Solution**:
```bash
# Copy from template
cp module1/templates/VERIFICATION_PLAN.md module1/

# Or create the file
touch module1/VERIFICATION_PLAN.md
```

### "Missing required section" Error

**Problem**: Structure check reports missing `##` heading

**Solution**:
- Check the schema: `scripts/schema/module1.json` (or `module2.json`)
- Add the missing `##` heading to your file
- See solution: `module1/.solutions/VERIFICATION_PLAN.md` for example

### "Orphan requirements" Error

**Problem**: Traceability check reports Req IDs not referenced

**Solution**:
- Reference the Req ID in `VERIFICATION_PLAN.md` (e.g., in test catalogue or risk table)
- Or add it to `HIGH_PRIORITY_REQUIREMENTS_TRACEABILITY.md`
- Example: If R3 is orphan, add "R3" to a test's "Related Req IDs" column

### Checklist Items Not Updating

**Problem**: Script still shows items as unchecked after marking them

**Solution**:
- Use lowercase x: `- [x]` (not `- [X]` or `- [ ]`)
- Make sure there's a space: `- [x]` not `-[x]`
- Run script again: `./scripts/module1.sh`

### Python Not Found

**Problem**: Structure/traceability checks skip with "python3 not found"

**Solution**:
- Install Python 3.10+ or ensure `python3` is in PATH
- Structure/traceability checks are optional; other checks still work

---

## 📊 Progress Tracking

### Module 1 Progress

Track your progress with:

```bash
# See checklist status
./scripts/module1.sh --checklist-status

# See all statuses
./scripts/module1.sh --summary
```

**Checklist items to complete**:
- [ ] DUT chosen and spec collected
- [ ] Requirements extracted (REQUIREMENTS_MATRIX.md §2)
- [ ] Verification plan filled (all 9 sections)
- [ ] Requirements matrix filled (all 8 sections)
- [ ] High-priority traceability filled
- [ ] All checklist items checked

### Module 2 Progress

```bash
./scripts/module2.sh --summary
```

**Checklist items to complete**:
- [ ] Test plan filled (TEST_PLAN.md)
- [ ] Regression plan filled (REGRESSION_PLAN.md)
- [ ] Coverage plan filled (COVERAGE_PLAN.md, optional)
- [ ] All checklist items checked

---

## 🔗 Quick Links

- **Templates**: `moduleN/templates/` — Start here
- **Solutions**: `moduleN/.solutions/` — Reference examples
- **Workspace**: `moduleN/*.md` — Edit these files
- **Scripts**: `scripts/moduleN.sh` — Run validation
- **Schemas**: `scripts/schema/moduleN.json` — Required sections

---

## 📖 Further Reading

- [PLAN.md](PLAN.md) — Improvement plan (for maintainers)
- [VERIFICATION_CHECKLIST.md](VERIFICATION_CHECKLIST.md) — Implementation checklist

---

## 🎓 Learning Path

1. **Module 1**: Verification planning foundations
   - Fill VERIFICATION_PLAN.md, REQUIREMENTS_MATRIX.md
   - Learn structure, traceability, risk assessment

2. **Module 2**: Test planning and strategy
   - Fill TEST_PLAN.md, REGRESSION_PLAN.md, COVERAGE_PLAN.md
   - Learn test taxonomy, regression tiers, coverage planning

3. **Modules 3–8**: Advanced topics
   - Coverage analysis, UVM environment, regression ops, integration, VIP, capstone
   - Use same validation approach (scripts check structure and completeness)

---

*Happy planning! For questions, see the main [README.md](../README.md) or browse [docs/](.) for all documentation.*

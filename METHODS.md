# Self-Paced Methodology: Verification Planning and Management

This repository is designed to be used as a **self-paced** learning path (no TA/lecturer required). The learning loop is:

- **Read** the reference solution when needed.
- **Do** the work using an empty template.
- **Validate** using scripts that check structure and completeness.

---

## 1. Key Idea

Each module is organized so that students can choose between:

- **Templates**: empty/skeleton docs to complete.
- **Solutions**: filled-in reference docs to study.
- **Workspace**: editable copies at the module root that scripts evaluate.

This makes it easy to:

- Learn by example (worked reference).
- Practice by filling templates for a new design.
- Get fast feedback from automation.

---

## 2. Folder Layout (Per Module)

Inside each `moduleN/` folder:

- **`moduleN/templates/`**
  - Empty/skeleton versions of the planning documents.
  - Use these to reset or create fresh copies.

- **`moduleN/.solutions/`**
  - Filled-in reference solutions.
  - Hidden by default (dot-folder) so students can opt-in to viewing.

- **`moduleN/*.md` (module root files)**
  - The student’s **workspace**.
  - These start as copies of the templates and are meant to be edited.
  - The module scripts evaluate these files.

---

## 3. Student Workflow

For each module:

1. **Start in the module root** (e.g. `module3/`).
2. **Edit the workspace files** (e.g. `module3/COVERAGE_DESIGN.md`).
3. If you want a fresh start, **copy from** `moduleN/templates/` back into the module root.
4. If you’re stuck or want to compare, **open** `moduleN/.solutions/`.
5. Run the checker script (from repo root):

```bash
./scripts/moduleN.sh
```

The script reports missing files, TODO markers, and checklist completion.

---

## 4. What the Scripts Check (and What They Don’t)

### 4.1 What scripts can check well

- **Structure**: required files exist at the module root.
- **Completeness**: TODO markers reduced/removed, checklists progressing.
- **Basic consistency**: simple heuristics like item counts, presence of required sections.

### 4.2 What scripts cannot fully check

- **Semantic correctness**: whether your plan is the *best* plan for your chosen design.
- **Quality of reasoning**: whether trade-offs and risk assessments are truly sound.

**Practical guidance:** Use scripts as the fast feedback loop, and use `.solutions/` to learn the intent and expected depth.

---

## 5. How to Choose Designs

You can run this course in two ways:

- **Single-design mode**: Use one DUT throughout all modules (simplest).
- **Transfer mode (recommended)**:
  - Study the reference approach on Design A (via `.solutions/`).
  - Apply the same structure to a different Design B using the templates.

Scripts will validate that your deliverables are complete and well-formed; you use the reference to judge quality and depth.

---

## 6. Repository Mapping

- **Modules 1–8**: student workspace + templates + reference solutions.
- **`scripts/`**: module validators (run locally).
- **`common_dut/`**: shared DUT + shared TB skeletons.

# DXT Engineering Handbook v1.0

## Status

FROZEN — Version 1.0

This handbook is the primary entry point for engineering work on the DXT platform.

It describes how the repository is organized, where canonical artifacts reside, and how engineering work progresses from design through production.

---

# Purpose

The handbook serves as the navigation guide for the DOS-XT engineering repository.

It does not redefine engineering standards or governance policies.

Instead, it directs engineers to the appropriate canonical documents.

---

# Engineering Philosophy

DXT is engineered as a deterministic operational decision platform.

Engineering priorities are:

- correctness
- determinism
- maintainability
- operator trust
- long-term stability

Business logic belongs in Supabase.

WeWeb presents validated backend contracts.

The Git repository preserves the canonical engineering implementation.

---

# Repository Structure

```text
DOS-XT/
│
├── README.md
├── DXT_ENGINEERING_HANDBOOK_v1.0.md
│
├── docs/
│   ├── architecture/
│   ├── governance/
│   ├── ontology/
│   ├── workstreams/
│   └── decisions/
│
├── supabase/
│   ├── canonical/
│   ├── contracts/
│   ├── migrations/
│   ├── registry/
│   └── snapshots/
│
└── weweb/
```

---

# Governance

The engineering governance suite resides in:

```text
docs/governance/
```

Current governance documents include:

- DXT_CANONICAL_OBJECT_REGISTRY_v1.0.md
- DXT_ENGINEERING_STANDARDS_v1.0.md
- DXT_NAMING_STANDARD_v1.0.md
- DXT_SQL_RECONCILIATION_POLICY_v1.0.md
- DXT_CHANGE_CONTROL_v1.0.md
- DXT_RELEASE_POLICY_v1.0.md

---

# Canonical Backend

Canonical SQL is organized by object type.

Examples:

```text
supabase/canonical/schema/
supabase/canonical/views/
supabase/canonical/functions/
supabase/canonical/policies/
supabase/canonical/reference_data/
```

Repository filenames match production object names.

Historical P00–P09 workstreams remain part of documentation and Git history rather than repository organization.

---

# Frontend

The WeWeb directory contains:

- collection contracts
- workflow documentation
- binding audits
- frontend validation artifacts

Business logic must not be duplicated in WeWeb.

---

# Standard Engineering Workflow

Every engineering task should follow this sequence:

1. Design
2. Review
3. Implement
4. Validate
5. Canonicalize
6. Commit
7. Push
8. Deploy
9. Verify
10. Freeze

---

# Source-of-Truth Hierarchy

Production runtime:

Live Supabase

Engineering implementation:

DOS-XT Git repository

Presentation layer:

WeWeb

---

# Engineering Governance

The governing engineering policies are defined by the governance suite.

Implementation should always conform to those policies.

---

# Freeze

DXT Engineering Handbook v1.0

Approved as the primary engineering navigation document for the DXT platform.
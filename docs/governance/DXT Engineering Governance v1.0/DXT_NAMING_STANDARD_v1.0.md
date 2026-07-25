# DXT Naming Standard v1.0

## Status

FROZEN — Version 1.0

This document defines the canonical naming conventions for the DXT platform.

---

# Purpose

Consistent naming improves:

- readability
- maintainability
- discoverability
- onboarding
- long-term platform stability

These standards apply to database objects, repository artifacts, frontend contracts, documentation, and engineering assets.

---

# General Principles

Names should be:

- descriptive
- deterministic
- singular where appropriate
- stable
- implementation independent

Avoid abbreviations unless they are platform standards.

---

# Repository

Directory names use:

- lowercase
- words separated by underscores only when required
- otherwise simple lowercase directory names

Examples:

docs/
supabase/
weweb/
governance/
architecture/

---

# SQL Objects

Tables use:

noun-based names

Examples:

rel_upload_batch
op_recommendation
eng_margin_fact_line

Views use:

ui_
out_

Examples:

ui_margin_portfolio_summary
ui_margin_decision_workspace

Functions

Prefix:

fn_

Procedures / RPC

Prefix:

op_

Examples:

op_transition_decision

Reference tables

Prefix:

ref_

Examples:

ref_recommendation_type

Staging

Prefix:

stg_

Engine

Prefix:

eng_

Operational

Prefix:

op_

Relationship

Prefix:

rel_

UI

Prefix:

ui_

Output

Prefix:

out_

---

# SQL Files

Canonical SQL files are organized by object type rather than historical implementation workstream.

Each canonical file should represent exactly one production object.

## Canonical filename format

Use the object name only:

```text
ui_margin_portfolio_summary.sql
op_transition_decision.sql
op_recommendation.sql

---

# Views

View names should describe what they expose rather than where they are used.

Preferred:

ui_margin_decision_workspace

Avoid:

decision_page_data

---

# Columns

Column names use:

snake_case

Boolean fields should read naturally.

Examples:

is_latest_run

validation_required

has_leading_alternative

Avoid:

flag1

status2

temp_value

---

# WeWeb

Collections should mirror canonical SQL contracts whenever practical.

Avoid frontend-specific reinterpretations of backend terminology.

---

# Documentation

Governance documents:

DXT_<TOPIC>_v1.0.md

Examples:

DXT_ENGINEERING_STANDARDS_v1.0.md

DXT_SQL_RECONCILIATION_POLICY_v1.0.md

Architecture Decision Records:

ADR-001.md

ADR-002.md

---

# Reserved Prefixes

| Prefix | Meaning |
|---------|---------|
| ref_ | Reference |
| rel_ | Relationship |
| stg_ | Staging |
| eng_ | Engine |
| op_ | Operational |
| out_ | Output |
| ui_ | UI contract |
| fn_ | Function |
| op_ | RPC / operation |

---

# Stability

Names are part of the platform contract.

Renaming production objects requires:

- impact analysis
- dependency review
- frontend validation
- repository update
- change documentation

---

# Freeze

DXT Naming Standard v1.0

Approved as the canonical naming standard for the DXT platform.
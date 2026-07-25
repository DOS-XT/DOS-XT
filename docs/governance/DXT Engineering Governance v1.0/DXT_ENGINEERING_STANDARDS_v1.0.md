# DXT Engineering Standards v1.0

## Status

FROZEN — Version 1.0

This document defines the engineering principles governing development of the DXT platform.

---

# Purpose

The objective of these standards is to ensure that DXT remains:

- deterministic
- maintainable
- auditable
- secure
- version controlled
- backend-driven

These standards apply to every engineering change regardless of implementation technology.

---

# Core Principles

## 1. Backend First

Business logic belongs in Supabase.

WeWeb is a presentation layer and must consume canonical backend contracts rather than recreate business logic.

---

## 2. Single Source of Truth

Every production object has exactly one canonical engineering definition.

The live Supabase runtime defines current production behavior.

The Git repository defines the approved engineering implementation.

---

## 3. Deterministic Behavior

Platform behavior must not depend upon frontend calculations, hidden workflows, or manual interpretation.

Given identical inputs, DXT must produce identical outputs.

---

## 4. SQL Owns Business Rules

Business calculations belong in SQL.

Examples include:

- recommendation generation
- prioritization
- confidence scoring
- financial impact calculations
- lifecycle status
- validation state

The frontend displays results but does not calculate them.

---

## 5. Explicit Contracts

Every exposed backend object must publish a stable contract.

Contracts include:

- tables
- views
- RPCs
- functions
- API-facing objects

Breaking contract changes require documented approval.

---

## 6. Security by Default

All production objects are assumed private until explicitly exposed.

Least-privilege access is the default.

Row Level Security (RLS) is preferred whenever appropriate.

---

## 7. Auditability

Engineering changes must be reproducible.

Every production change should be traceable through:

- Git history
- engineering documentation
- canonical SQL
- validation evidence

---

## 8. Version Control

Canonical engineering artifacts belong in Git.

Supabase Saved Queries are working copies and are not independently authoritative.

---

## 9. Validation Before Promotion

Changes must be validated before becoming canonical.

Validation should include:

- functional correctness
- contract compatibility
- frontend compatibility
- security review

---

## 10. Continuous Simplification

Engineering complexity should decrease over time.

Duplicate logic, obsolete objects, and unnecessary abstractions should be removed whenever practical without compromising stability.

---

# Engineering Workflow

The standard engineering lifecycle is:

1. Design
2. Review
3. Implement
4. Validate
5. Canonicalize
6. Commit
7. Deploy
8. Monitor

---

# Engineering Philosophy

DXT is engineered as an operational decision platform rather than a traditional reporting application.

The platform prioritizes:

- correctness
- determinism
- maintainability
- operator trust
- long-term stability

over rapid implementation or frontend convenience.

---

# Freeze

DXT Engineering Standards v1.0

Approved as the governing engineering principles for the DXT platform.
# DXT Release Policy v1.0

## Status

FROZEN — Version 1.0

This document defines the release governance for the DXT platform.

---

# Purpose

The purpose of this policy is to ensure that every production release is:

- validated
- reproducible
- traceable
- reversible
- low risk

A release is the controlled promotion of approved engineering changes into the production DXT environment.

---

# Release Principles

## 1. Stability Before Speed

Production stability is always more important than release frequency.

---

## 2. Canonical First

Only validated canonical engineering artifacts may be released.

Prototype, provisional, or experimental implementations are never production releases.

---

## 3. One Source of Truth

Every release must correspond to:

- the validated live Supabase implementation
- the canonical Git repository
- approved engineering governance

All three must remain synchronized.

---

## 4. Reproducibility

A production release should be reproducible from the canonical repository.

No release should depend upon undocumented manual changes.

---

# Release Requirements

A production release requires:

- validated implementation
- updated canonical SQL
- updated documentation where applicable
- updated Canonical Object Registry
- completed validation
- committed and pushed Git history

---

# Release Validation

Validation should confirm:

- runtime behavior
- SQL contracts
- frontend compatibility
- authenticated access
- security
- WeWeb bindings
- regression stability

---

# Release Types

## Major Release

Introduces significant architectural or platform capability.

Example:

MarginOS v2

---

## Minor Release

Adds new capabilities while maintaining compatibility.

Example:

Decision Support enhancements

---

## Maintenance Release

Corrects defects, improves reliability, or resolves implementation drift.

Example:

Canonical SQL reconciliation

---

## Emergency Release

Addresses production-impacting issues.

Emergency releases require:

- immediate validation
- post-release documentation
- repository reconciliation

---

# Release Workflow

1. Engineering complete
2. Validation complete
3. Canonical repository updated
4. Governance updated (if required)
5. Git committed and pushed
6. Production deployment
7. Post-release validation
8. Freeze release

---

# Release Freeze

A release is considered frozen when:

- production behavior is validated
- repository artifacts match production
- governance reflects the approved implementation

---

# Repository Expectations

Every release should produce:

- Git commit history
- updated canonical SQL (if applicable)
- updated governance (if applicable)
- updated documentation (if applicable)

---

# Release Notes

Every release should record:

- objectives
- implemented changes
- validation summary
- known limitations
- next planned work

---

# Engineering Philosophy

A release represents an engineering commitment.

The goal is not to release frequently.

The goal is to release confidently.

---

# Freeze

DXT Release Policy v1.0

Approved as the canonical release governance policy for the DXT platform.
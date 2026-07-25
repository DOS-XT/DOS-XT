# DXT Canonical Object Registry v1.0

## Status

PROVISIONAL — Registry framework established.  
The object inventory must be populated and validated against the live DXT | v1.0 Supabase runtime before this document is frozen.

## Purpose

This registry is the authoritative engineering index of DXT Supabase objects.

It records:

- Which database objects exist.
- Which objects are canonical.
- Which objects require replacement, retirement, or further validation.
- Where each canonical definition is stored in the repository.
- Which frontend contracts depend on each object.

## Source-of-Truth Hierarchy

1. The live DXT | v1.0 Supabase database is authoritative for current production runtime behavior.
2. The DOS-XT Git repository is authoritative for approved engineering source code and documentation.
3. Supabase SQL Editor saved queries are working copies only and are not independently authoritative.
4. WeWeb consumes canonical Supabase contracts and must not redefine backend business logic.

## Classification

### CANONICAL

The object is approved for continued production use and its repository definition matches the validated live runtime.

### REPLACE

The object remains required, but its saved or repository definition does not match the approved live runtime and must be replaced.

### RETIRE

The object is obsolete, superseded, duplicated, or no longer part of the approved DXT architecture.

### PROVISIONAL

The object requires additional validation before it can be classified as canonical, replaced, or retired.

## Registry Rules

- One production object must have one canonical repository definition.
- Canonical SQL must reproduce the validated production contract.
- Historical SQL must not be stored as canonical SQL.
- Replacement and retirement actions require explicit validation.
- No object may be deleted solely because it appears unused.
- WeWeb dependencies must be audited before replacing or retiring an exposed UI view or RPC.
- Secrets, credentials, access tokens, and private keys must never be stored in this registry or repository.

## Canonical Repository Locations

| Object Type | Repository Location |
|---|---|
| Tables, schemas, types, sequences | `supabase/canonical/schema/` |
| Views and materialized views | `supabase/canonical/views/` |
| Functions, procedures, triggers, RPCs | `supabase/canonical/functions/` |
| RLS policies, grants, and security contracts | `supabase/canonical/policies/` |
| Approved reference and seed data | `supabase/canonical/reference_data/` |
| Registry definitions and supporting SQL | `supabase/canonical/registry/` |
| Reconciliation reports and object indexes | `supabase/registry/` |
| Versioned deployment changes | `supabase/migrations/` |
| Point-in-time runtime captures | `supabase/snapshots/` |

## Object Registry

| Object Type | Schema | Object Name | Classification | Runtime Status | Repository Definition | WeWeb Dependency | Notes |
|---|---|---|---|---|---|---|---|
| Pending audit | — | — | PROVISIONAL | Live inventory required | — | — | Registry framework created; no object classifications frozen yet. |

## Reconciliation Status

| Workstream | Scope | Status |
|---|---|---|
| P00 | Foundations | PENDING |
| P01 | Uploads | PENDING |
| P02 | Raw data | PENDING |
| P03 | Relational layer | PENDING |
| P04 | Engine layer | PENDING |
| P05 | Operational layer | PENDING |
| P06 | Output layer | PENDING |
| P07 | Functions and RPCs | PENDING |
| P08 | UI views | CURRENT |
| P09 | Security | PENDING |

## Freeze Requirements

This registry may be frozen as DXT Canonical Object Registry v1.0 only after:

1. The live Supabase object inventory has been captured.
2. Every in-scope object has been classified.
3. Canonical runtime definitions have been validated.
4. Repository locations have been assigned.
5. WeWeb dependencies have been checked for exposed views and RPCs.
6. Identified drift has been documented.
7. The registry has been committed and pushed to the DOS-XT repository.

## Change Control

Every later registry update must include:

- The affected object.
- The previous classification or contract.
- The approved change.
- Validation evidence.
- The associated Git commit or migration.
- Any corresponding WeWeb contract update.
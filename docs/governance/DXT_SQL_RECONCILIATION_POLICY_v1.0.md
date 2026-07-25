# DXT SQL Reconciliation Policy v1.0

## Status

FROZEN — Version 1.0

This policy defines how DXT keeps the live Supabase runtime, the canonical Git repository, and legacy Supabase Saved Queries aligned.

## Purpose

The reconciliation process exists to prevent schema drift, duplicate definitions, obsolete SQL, and frontend dependency failures.

It applies to:

- tables
- views
- materialized views
- functions
- procedures
- RPCs
- triggers
- policies
- grants
- reference data
- API-facing contracts

## Source-of-Truth Model

The live DXT | v1.0 Supabase database is authoritative for current production runtime behavior.

The DOS-XT Git repository is authoritative for approved engineering source code and documentation.

Supabase SQL Editor Saved Queries are working copies only. They are not independently authoritative.

WeWeb is a consumer of canonical Supabase contracts and must not redefine backend business logic.

## Core Rule

One production object must have one canonical repository definition.

A canonical SQL file must:

- represent one production object
- match the validated live definition
- use the production object name as the filename
- reside in the correct object-type directory
- include required owner, security, grant, and comment statements where applicable

## Reconciliation Classifications

### CANONICAL

The live object is approved and the repository definition matches it.

### REPLACE

The object remains required, but the saved or repository definition does not match the approved live runtime.

### RETIRE

The object is obsolete, superseded, duplicated, or no longer part of the approved architecture.

### PROVISIONAL

The object requires additional validation before final classification.

## Reconciliation Workflow

For each object:

1. Identify the live production object.
2. Capture its exact live definition and metadata.
3. Locate any repository and Supabase Saved Query definitions.
4. Compare structure, behavior, security, grants, comments, and dependencies.
5. Assign a reconciliation classification.
6. Produce the exact canonical replacement SQL when required.
7. Validate dependent WeWeb collections, workflows, bindings, and API paths.
8. Update the canonical repository file.
9. Update the Canonical Object Registry.
10. Commit and push the approved change.
11. Update or retire the Supabase Saved Query only after the repository and runtime are confirmed.

## Live Definition Requirements

A live-object capture should include, where applicable:

- schema
- object name
- object type
- owner
- SQL definition
- column names and order
- data types
- constraints
- indexes
- triggers
- RLS status
- policies
- grants
- security options
- comments
- dependencies
- PostgREST exposure
- authenticated behavior

## Comparison Requirements

A reconciliation must check more than SQL text.

It must also compare:

- output contract
- column order
- data types
- nullability
- default values
- deterministic ordering
- filtering behavior
- owner isolation
- RLS behavior
- authenticated access
- anonymous access
- dependent objects
- frontend dependencies

## Saved Query Handling

Supabase Saved Queries may be retained for convenience, but they must not become a second source of truth.

Each saved query must eventually be classified as:

- synchronized
- replaced
- retired
- provisional

Saved queries must not be updated before the live runtime and canonical repository definition have been validated.

## Repository Handling

Canonical SQL files are organized by object type.

Examples:

```text
supabase/canonical/views/ui_margin_portfolio_summary.sql
supabase/canonical/functions/op_transition_decision.sql
supabase/canonical/schema/op_recommendation.sql
supabase/canonical/policies/op_recommendation_policies.sql
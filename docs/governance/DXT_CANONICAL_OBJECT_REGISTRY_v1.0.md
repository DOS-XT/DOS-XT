# DXT Canonical Object Registry v1.0

## Governance Status

- Runtime system of record: Supabase `DXT | v1.0`
- Audit scope: P08 UI views
- Audit date: 2026-07-25
- Audit mode: Read-only
- Approved classifications: `CANONICAL`, `REPLACE`, `RETIRE`, `PROVISIONAL`
- Pipeline: `RAW → REL → ENG → OP → OUT → UI → WeWeb`

## P08 Runtime Registry

| Schema | Object | Type | Layer | Classification | Direct dependency | WeWeb status | Canonical repository path | Retirement gate / required action |
|---|---|---|---|---|---|---|---|---|
| public | ui_margin_portfolio_summary | view | UI | REPLACE | out_margin_portfolio_summary | Legacy compatibility only; active page cut over to v2 | supabase/canonical/views/ui_margin_portfolio_summary.sql | Retire only after repository reconciliation and zero downstream consumers |
| public | ui_margin_portfolio_summary_v2 | view | UI | CANONICAL | out_margin_portfolio_summary_v2 | Active Decision Portfolio summary contract | supabase/canonical/views/ui_margin_portfolio_summary_v2.sql | Preserve; validate authenticated PostgREST and downstream bindings before P08 freeze |
| public | ui_margin_portfolio_decision | view | UI | REPLACE | out_margin_portfolio_decision | Legacy compatibility only; active page cut over to v2 | supabase/canonical/views/ui_margin_portfolio_decision.sql | Retire only after repository reconciliation and zero downstream consumers |
| public | ui_margin_portfolio_decision_v2 | view | UI | CANONICAL | out_margin_portfolio_decision_v2 | Active Prioritized Decisions contract | supabase/canonical/views/ui_margin_portfolio_decision_v2.sql | Preserve; validate authenticated PostgREST and downstream bindings before P08 freeze |
| public | ui_margin_decision_workspace | view | UI | REPLACE | out_margin_decision_workspace | Legacy workspace dependency remains through action contract | supabase/canonical/views/ui_margin_decision_workspace.sql | Cannot retire until action chain is rebuilt and no WeWeb consumers remain |
| public | ui_margin_decision_workspace_v2 | view | UI | CANONICAL | out_margin_decision_workspace_v2 | V2 Decision Review workspace contract | supabase/canonical/views/ui_margin_decision_workspace_v2.sql | Preserve; resolve exact WeWeb collection binding and validate |
| public | ui_margin_decision_support_summary | view | UI | REPLACE | out_margin_portfolio_decision; op_evidence_pack; rel_recommendation_source_record | Current legacy support source | supabase/canonical/views/ui_margin_decision_support_summary.sql | Replace only after v2 becomes direct-source canonical contract |
| public | ui_margin_decision_support_summary_v2 | view | UI | PROVISIONAL | ui_margin_decision_support_summary | Exact WeWeb collection binding still to be resolved | supabase/canonical/views/ui_margin_decision_support_summary_v2.sql | Rebuild from OUT/OP/REL; remove UI-to-UI dependency before freeze |
| public | ui_margin_decision_support_fact | view | UI | REPLACE | out_margin_portfolio_decision; op_evidence_pack; rel_recommendation_source_record | Current legacy support-fact source | supabase/canonical/views/ui_margin_decision_support_fact.sql | Replace only after v2 becomes direct-source canonical contract |
| public | ui_margin_decision_support_fact_v2 | view | UI | PROVISIONAL | ui_margin_decision_support_fact | Exact WeWeb collection binding still to be resolved | supabase/canonical/views/ui_margin_decision_support_fact_v2.sql | Rebuild from OUT/OP/REL; remove UI-to-UI dependency before freeze |
| public | ui_margin_decision_source_record | view | UI | REPLACE | out_margin_decision_workspace_evidence_source | Current Source Records contract | supabase/canonical/views/ui_margin_decision_source_record.sql | Replace only after v2 becomes direct-source canonical contract |
| public | ui_margin_decision_source_record_v2 | view | UI | PROVISIONAL | ui_margin_decision_source_record | Exact WeWeb collection binding still to be resolved | supabase/canonical/views/ui_margin_decision_source_record_v2.sql | Rebuild from OUT; remove UI-to-UI dependency before freeze |
| public | ui_margin_decision_action | view | UI | REPLACE | ui_margin_decision_workspace | Legacy action manifest and current dependency source | supabase/canonical/views/ui_margin_decision_action.sql | Cannot retire until v2 action contract is rebuilt from canonical source |
| public | ui_margin_decision_action_v2 | view | UI | PROVISIONAL | ui_margin_decision_action | Exact WeWeb collection binding still to be resolved | supabase/canonical/views/ui_margin_decision_action_v2.sql | Rebuild against v2 workspace or independent OP/OUT action contract |
| public | ui_dxt_conflict_classification_v1 | view | UI | CANONICAL | out_dxt_conflict_classification_v1 | Backend conflict classification contract | supabase/canonical/views/ui_dxt_conflict_classification_v1.sql | Preserve and validate consumers |
| public | ui_dxt_object_registry_v1 | view | UI | CANONICAL | ref_dxt_object_registry_v1 | Governance-facing registry view | supabase/canonical/views/ui_dxt_object_registry_v1.sql | Reconcile obsolete classification vocabulary before governance freeze |

## Verified Security Contract

All sixteen audited views were verified with:

- Owner: `postgres`
- Reloption: `security_invoker=true`
- `anon`: no SELECT
- `authenticated`: SELECT granted
- `service_role`: SELECT granted

## Architectural Drift

1. `ui_margin_decision_support_summary_v2`, `ui_margin_decision_support_fact_v2`, `ui_margin_decision_source_record_v2`, and `ui_margin_decision_action_v2` depend on UI-layer objects. They are not eligible for P08 freeze until rebuilt from the correct backend layer.
2. `ui_margin_decision_action_v2` ultimately depends on legacy `ui_margin_decision_workspace`.
3. `ui_dxt_object_registry_v1` still orders obsolete classifications including `CLEAN_BUILD` and `COMPATIBILITY`; the approved governance vocabulary is `CANONICAL`, `REPLACE`, `RETIRE`, `PROVISIONAL`.
4. The legacy support summary and support fact views have no object comments. Do not patch comments independently unless these objects remain compatibility contracts.

## P08 Freeze Gates

- [ ] Exact SQL for every P08 runtime object extracted into Git
- [ ] Saved Supabase queries reconciled against runtime definitions
- [ ] Exact WeWeb collection dependencies resolved
- [ ] Provisional UI-to-UI v2 contracts rebuilt from correct source layers
- [ ] Authenticated PostgREST validation completed
- [ ] Zero unapproved legacy consumers
- [ ] Registry vocabulary reconciled
- [ ] P08 classified and frozen

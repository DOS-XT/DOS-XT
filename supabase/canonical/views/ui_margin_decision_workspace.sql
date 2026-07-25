-- DXT P08 RUNTIME BASELINE
-- Classification: REPLACE
-- Source: verified live Supabase runtime

create or replace view public.ui_margin_decision_workspace
with (security_invoker = true)
as
select
    owner_email, run_id, upload_batch_id, is_latest_run, run_status,
    data_readiness_status, run_completed_at, recommendation_id,
    selected_candidate_id, evidence_pack_id, decision_position,
    total_decision_count, priority_level, priority_score, decision_title,
    decision_subject_primary, decision_subject_secondary, entity_primary,
    entity_secondary, category_primary, category_secondary,
    estimated_financial_outcome_amount,
    estimated_financial_outcome_amount_display,
    estimated_financial_outcome_type, row_status_code, row_status_label,
    row_status_tone, row_status_message, status_supporting_display,
    next_action_label, recommended_move, target_change_display,
    prescriptive_summary, diagnosis, root_cause_name, because_summary,
    selection_explanation, tradeoff_risk, implementation_note,
    confidence_score, confidence_score_display, confidence_explanation,
    financial_impact_score, financial_impact_score_display,
    evidence_validation_code, evidence_validation_label, evidence_display,
    evidence_source_count, evidence_pack_status, validation_required,
    blocking_data_gap, evidence_data_quality_level, data_quality_score,
    root_cause_evidence_summary, current_state_value, current_state_display,
    recommended_target_value, recommended_target_display,
    monthly_impact_estimate, ninety_day_impact_estimate,
    annualized_impact_estimate, observed_period_start, observed_period_end,
    observed_period_display, affected_order_count, affected_sku_count,
    affected_unit_count, observed_revenue, observed_revenue_display,
    observed_cost, observed_cost_display, observed_margin,
    observed_margin_display, observed_margin_pct, target_margin_pct,
    estimated_leak_amount, estimated_leak_amount_display, loss_per_event,
    loss_per_event_display, observed_loss_amount,
    observed_loss_amount_display, recoverable_amount,
    recoverable_amount_display, monthly_impact_estimate_display,
    ninety_day_impact_estimate_display, annualized_impact_estimate_display,
    impact_formula, impact_inputs, impact_confidence_level,
    target_calculation_method, target_calculation_formula,
    target_calculation_inputs, rounded_target_value, rounding_rule,
    source_record_types, source_file_names, source_upload_ids,
    source_record_date_range, required_fields_present, missing_fields,
    stale_fields, conflicting_fields, evidence_empty_state_display,
    has_leading_alternative, alternative_candidate_id, alternative_move,
    alternative_target_value, alternative_target_display,
    alternative_estimated_financial_impact,
    alternative_estimated_financial_impact_display,
    alternative_impact_type, alternative_recommendation_score,
    alternative_tradeoff_risk, alternative_evidence_summary,
    alternative_reason_not_selected, alternative_moves_considered,
    rejected_move_reasons, alternatives_empty_state_display,
    recommendation_detail_path, evidence_pack_path,
    recommendation_created_at, recommendation_updated_at,
    recommendation_code, alternative_recommendation_code
from public.out_margin_decision_workspace;

alter view public.ui_margin_decision_workspace owner to postgres;
revoke all on public.ui_margin_decision_workspace from anon;
grant select on public.ui_margin_decision_workspace to authenticated;
grant select on public.ui_margin_decision_workspace to service_role;
comment on view public.ui_margin_decision_workspace is
'Explicit security-invoker pass-through for the DOS XT split-pane Decision Workspace.';

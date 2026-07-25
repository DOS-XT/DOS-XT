-- DXT P08 RUNTIME BASELINE
-- Classification: REPLACE
-- Source: verified live Supabase runtime

create or replace view public.ui_margin_portfolio_decision
with (security_invoker = true)
as
select
    owner_email, run_id, upload_batch_id, is_latest_run, run_status,
    data_readiness_status, run_completed_at, total_decision_count,
    decision_position, is_top_priority, recommendation_id,
    selected_candidate_id, evidence_pack_id, priority_level,
    priority_score, sku, sku_name, scope_display_primary,
    scope_display_secondary, scope_coverage_display,
    affected_order_count, affected_sku_count, recommended_move,
    recommendation_type, business_lever, current_state_value,
    recommended_target_value, current_state_display,
    recommended_target_display, target_change_display,
    affected_entity_type, affected_entity_id, affected_entity_name,
    leak_type, root_cause_name, diagnosis, because_summary,
    prescriptive_summary, estimated_financial_outcome_amount,
    estimated_financial_outcome_amount_display,
    estimated_financial_outcome_type, financial_impact_score,
    financial_impact_score_display, confidence_score,
    confidence_score_display, monthly_impact_estimate,
    ninety_day_impact_estimate, annualized_impact_estimate,
    evidence_validation_code, evidence_validation_label,
    evidence_display, evidence_source_count, evidence_pack_status,
    validation_required, blocking_data_gap,
    recommendation_data_quality_level, evidence_data_quality_level,
    data_quality_score, root_cause_evidence_summary,
    selection_explanation, confidence_explanation, tradeoff_risk,
    implementation_note, alternative_candidate_id, alternative_move,
    alternative_target_value, alternative_estimated_financial_impact,
    alternative_impact_type, alternative_recommendation_score,
    alternative_tradeoff_risk, alternative_evidence_summary,
    alternative_reason_not_selected, has_leading_alternative,
    decision_status, row_status_code, row_status_label, row_status_tone,
    row_status_message, next_action_label, recommendation_detail_path,
    evidence_pack_path, search_text, recommendation_created_at,
    recommendation_updated_at, decision_title,
    decision_subject_primary, decision_subject_secondary, entity_primary,
    entity_secondary, category_primary, category_secondary,
    status_supporting_display, decision_priority_display,
    priority_explanation, next_action_code, next_action_is_executable,
    recommendation_code, alternative_recommendation_code
from public.out_margin_portfolio_decision;

alter view public.ui_margin_portfolio_decision owner to postgres;
revoke all on public.ui_margin_portfolio_decision from anon;
grant select on public.ui_margin_portfolio_decision to authenticated;
grant select on public.ui_margin_portfolio_decision to service_role;
comment on view public.ui_margin_portfolio_decision is
'UI projection of out_margin_portfolio_decision. Contains no independent lifecycle or action business logic.';

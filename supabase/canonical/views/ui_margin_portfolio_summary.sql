-- DXT P08 RUNTIME BASELINE
-- Classification: REPLACE
-- Source: verified live Supabase runtime

create or replace view public.ui_margin_portfolio_summary
with (security_invoker = true)
as
select
    owner_email,
    run_id,
    upload_batch_id,
    run_status,
    data_readiness_status,
    observed_period_start,
    observed_period_end,
    run_completed_at,
    latest_recommendation_created_at,
    recommended_moves_count,
    recommended_moves_display,
    headline_metric_label,
    headline_amount,
    headline_amount_display,
    recoverable_amount,
    recoverable_amount_display,
    margin_protected,
    margin_protected_display,
    loss_prevented,
    loss_prevented_display,
    validation_required_count,
    blocked_count,
    evidence_pack_count,
    evidence_source_record_count,
    system_status_code,
    system_status_label,
    system_status_tone,
    system_status_message,
    empty_state_title,
    empty_state_message,
    summary_context_text,
    ready_count,
    is_latest_run,
    total_estimated_impact,
    total_estimated_impact_display,
    recovered_amount,
    recovered_amount_display,
    measured_recovery_count,
    has_measured_recovery,
    financial_impact_reconciliation_delta,
    financial_impact_is_reconciled,
    implemented_count,
    dismissed_count,
    evidence_gap_count,
    under_review_count,
    attention_count,
    in_progress_count,
    result_count,
    latest_recommendation_updated_at
from public.out_margin_portfolio_summary;

alter view public.ui_margin_portfolio_summary owner to postgres;
revoke all on public.ui_margin_portfolio_summary from anon;
grant select on public.ui_margin_portfolio_summary to authenticated;
grant select on public.ui_margin_portfolio_summary to service_role;
comment on view public.ui_margin_portfolio_summary is
'WeWeb-facing Decision Portfolio Financial Impact and Analysis Summary contract. Preserves legacy-compatible field names while exposing current DXT presentation copy.';

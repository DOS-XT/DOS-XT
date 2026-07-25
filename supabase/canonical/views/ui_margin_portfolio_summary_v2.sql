-- DXT P08 canonical runtime extraction
-- Classification: CANONICAL
-- Source verified from live Supabase runtime on 2026-07-25.

create or replace view public.ui_margin_portfolio_summary_v2
with (security_invoker = true)
as
select
    owner_email,
    run_id,
    upload_batch_id,
    is_latest_run,
    run_status,
    data_readiness_status,
    observed_period_start,
    observed_period_end,
    run_completed_at,
    estimated_financial_impact,
    estimated_financial_impact_display,
    recoverable_amount,
    recoverable_amount_display,
    margin_protection,
    margin_protection_display,
    preventable_loss,
    preventable_loss_display,
    records_analyzed,
    recommended_moves,
    policy_conflicts,
    policy_conflicts_is_ready,
    policy_conflicts_readiness_message,
    data_blocks,
    validation_required_count,
    blocked_count,
    support_gap_count,
    validated_decision_count,
    under_review_count,
    implemented_count,
    dismissed_count,
    attention_count,
    in_progress_count,
    result_count,
    analysis_status_code,
    analysis_status_label,
    analysis_status_tone,
    analysis_status_message,
    empty_state_title,
    empty_state_message,
    summary_context_text,
    financial_impact_reconciliation_delta,
    financial_impact_is_reconciled,
    latest_recommendation_created_at,
    latest_recommendation_updated_at
from public.out_margin_portfolio_summary_v2;

alter view public.ui_margin_portfolio_summary_v2 owner to postgres;
revoke all on public.ui_margin_portfolio_summary_v2 from anon;
grant select on public.ui_margin_portfolio_summary_v2 to authenticated;
grant select on public.ui_margin_portfolio_summary_v2 to service_role;
comment on view public.ui_margin_portfolio_summary_v2 is
'WeWeb-facing Decision Portfolio Summary v2 contract for clean DXT builds. New frontend bindings should use this contract instead of extending legacy summary projections.';

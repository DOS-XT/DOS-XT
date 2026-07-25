-- DXT P08 live runtime extraction
-- Classification: PROVISIONAL — SOURCE BOUNDARY REPLACEMENT REQUIRED

create or replace view public.ui_margin_decision_support_summary_v2
with (security_invoker = true)
as
select
    owner_email,
    run_id,
    is_latest_run,
    recommendation_id,
    evidence_pack_id as support_pack_id,
    support_status_code,
    support_status_label,
    support_status_tone,
    support_fact_count,
    source_record_count,
    validated_source_count,
    pending_validation_count,
    confidence_score,
    confidence_display,
    confidence_support_state,
    confidence_support_explanation,
    data_quality_score,
    data_quality_level,
    blocking_data_gap,
    validation_required,
    validation_summary,
    selection_reason,
    selection_explanation,
    decision_support_updated_at
from public.ui_margin_decision_support_summary;

alter view public.ui_margin_decision_support_summary_v2 owner to postgres;
revoke all on public.ui_margin_decision_support_summary_v2 from anon;
grant select on public.ui_margin_decision_support_summary_v2 to authenticated;
grant select on public.ui_margin_decision_support_summary_v2 to service_role;
comment on view public.ui_margin_decision_support_summary_v2 is
'Clean-build Decision Support summary contract. Preserves SQL-derived support semantics while replacing evidence-pack identifiers with support-pack presentation terminology.';

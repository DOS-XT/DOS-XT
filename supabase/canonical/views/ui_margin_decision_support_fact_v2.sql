-- DXT P08 live runtime extraction
-- Classification: PROVISIONAL — SOURCE BOUNDARY REPLACEMENT REQUIRED

create or replace view public.ui_margin_decision_support_fact_v2
with (security_invoker = true)
as
select
    owner_email,
    run_id,
    is_latest_run,
    recommendation_id,
    evidence_pack_id as support_pack_id,
    fact_order,
    fact_type,
    fact_title,
    fact_summary,
    validation_status_code,
    validation_status_label,
    validation_tone,
    source_count
from public.ui_margin_decision_support_fact;

alter view public.ui_margin_decision_support_fact_v2 owner to postgres;
revoke all on public.ui_margin_decision_support_fact_v2 from anon;
grant select on public.ui_margin_decision_support_fact_v2 to authenticated;
grant select on public.ui_margin_decision_support_fact_v2 to service_role;
comment on view public.ui_margin_decision_support_fact_v2 is
'Clean-build ordered Decision Support fact contract.';

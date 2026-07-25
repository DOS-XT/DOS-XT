-- DXT P08 canonical runtime extraction
-- Classification: CANONICAL
-- Source verified from live Supabase runtime on 2026-07-25.

create or replace view public.ui_dxt_conflict_classification_v1
with (security_invoker = true)
as
select
    owner_email,
    run_id,
    upload_batch_id,
    recommendation_id,
    leak_id,
    root_cause_id,
    platform_domain,
    engine_conflict_type,
    conflict_code,
    conflict_status,
    is_policy_conflict,
    policy_conflict_classification,
    is_data_block,
    data_block_classification,
    leak_type,
    root_cause_code,
    root_cause_name,
    root_cause_category,
    recommendation_code,
    recommendation_type,
    business_lever,
    current_state_value,
    recommended_target_value,
    detection_outcome,
    data_quality_level,
    blocking_data_gap,
    policy_setting_id,
    policy_type,
    policy_scope_type,
    policy_scope_value,
    current_policy_value,
    has_matching_policy_setting,
    classification_reason,
    created_at,
    updated_at
from public.out_dxt_conflict_classification_v1;

alter view public.ui_dxt_conflict_classification_v1 owner to postgres;
revoke all on public.ui_dxt_conflict_classification_v1 from anon;
grant select on public.ui_dxt_conflict_classification_v1 to authenticated;
grant select on public.ui_dxt_conflict_classification_v1 to service_role;
comment on view public.ui_dxt_conflict_classification_v1 is
'Authenticated WeWeb-facing DXT Conflict Classification v1.0 contract.';

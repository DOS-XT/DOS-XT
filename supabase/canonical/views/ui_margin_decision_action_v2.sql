-- DXT P08 live runtime extraction
-- Classification: PROVISIONAL — SOURCE BOUNDARY REPLACEMENT REQUIRED

create or replace view public.ui_margin_decision_action_v2
with (security_invoker = true)
as
select
    owner_email,
    run_id,
    recommendation_id,
    case
        when row_status_code = 'READY' then 'VALIDATED'
        else row_status_code
    end as decision_status_code,
    decision_title,
    decision_subject_primary,
    decision_subject_secondary,
    action_rank,
    action_role,
    action_code,
    action_label,
    action_tone,
    action_is_executable,
    requires_confirmation,
    requires_decision_reason,
    accepts_decision_note,
    accepts_actual_implemented_value,
    accepts_implementation_channel,
    accepts_implementation_reference,
    confirmation_title,
    confirmation_message,
    rpc_function_name
from public.ui_margin_decision_action;

alter view public.ui_margin_decision_action_v2 owner to postgres;
revoke all on public.ui_margin_decision_action_v2 from anon;
grant select on public.ui_margin_decision_action_v2 to authenticated;
grant select on public.ui_margin_decision_action_v2 to service_role;
comment on view public.ui_margin_decision_action_v2 is
'Clean-build context-aware Decision Action contract. Exposes VALIDATED rather than legacy READY while preserving op_transition_decision execution semantics.';

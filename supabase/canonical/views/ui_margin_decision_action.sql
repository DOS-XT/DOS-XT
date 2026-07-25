-- DXT P08 RUNTIME BASELINE
-- Classification: REPLACE
-- Source: verified live Supabase runtime

create or replace view public.ui_margin_decision_action
with (security_invoker = true)
as
with action_definition as (
    select x.action_code, x.action_label, x.action_tone,
           x.requires_confirmation, x.requires_decision_reason,
           x.accepts_decision_note, x.accepts_actual_implemented_value,
           x.accepts_implementation_channel,
           x.accepts_implementation_reference,
           x.confirmation_title, x.confirmation_message
    from (values
        ('START_REVIEW'::text,'Review'::text,'primary'::text,false,false,true,false,false,false,
         'Start decision review?'::text,'This decision will move into active review.'::text),
        ('ACCEPT_DECISION'::text,'Accept'::text,'primary'::text,true,false,true,false,false,false,
         'Accept this decision?'::text,'The decision will be accepted and become ready for deployment.'::text),
        ('DEPLOY_DECISION'::text,'Deploy'::text,'primary'::text,true,false,true,true,true,true,
         'Deploy this decision?'::text,'The decision will be recorded as implemented. Deployment details may be added now.'::text),
        ('DISMISS_DECISION'::text,'Dismiss'::text,'danger'::text,true,true,true,false,false,false,
         'Dismiss this decision?'::text,'The decision will be removed from the active workflow. A reason is required.'::text),
        ('REOPEN_DECISION'::text,'Reopen'::text,'primary'::text,true,false,true,false,false,false,
         'Reopen this decision?'::text,'The decision will return to the active workflow as a new decision.'::text)
    ) x(action_code, action_label, action_tone, requires_confirmation,
        requires_decision_reason, accepts_decision_note,
        accepts_actual_implemented_value, accepts_implementation_channel,
        accepts_implementation_reference, confirmation_title,
        confirmation_message)
), applicability as (
    select x.row_status_code, x.action_rank, x.action_role, x.action_code
    from (values
        ('READY'::text,1,'primary'::text,'START_REVIEW'::text),
        ('READY'::text,2,'secondary'::text,'DISMISS_DECISION'::text),
        ('UNDER_REVIEW'::text,1,'primary'::text,'ACCEPT_DECISION'::text),
        ('UNDER_REVIEW'::text,2,'secondary'::text,'DISMISS_DECISION'::text),
        ('ACCEPTED'::text,1,'primary'::text,'DEPLOY_DECISION'::text),
        ('DISMISSED'::text,1,'primary'::text,'REOPEN_DECISION'::text)
    ) x(row_status_code, action_rank, action_role, action_code)
)
select
    d.owner_email, d.run_id, d.recommendation_id, d.row_status_code,
    d.decision_title, d.decision_subject_primary,
    d.decision_subject_secondary, a.action_rank, a.action_role,
    ad.action_code, ad.action_label, ad.action_tone,
    true as action_is_executable, ad.requires_confirmation,
    ad.requires_decision_reason, ad.accepts_decision_note,
    ad.accepts_actual_implemented_value,
    ad.accepts_implementation_channel,
    ad.accepts_implementation_reference, ad.confirmation_title,
    ad.confirmation_message, 'op_transition_decision'::text as rpc_function_name
from public.ui_margin_decision_workspace d
join applicability a on a.row_status_code = d.row_status_code
join action_definition ad on ad.action_code = a.action_code;

alter view public.ui_margin_decision_action owner to postgres;
revoke all on public.ui_margin_decision_action from anon;
grant select on public.ui_margin_decision_action to authenticated;
grant select on public.ui_margin_decision_action to service_role;
comment on view public.ui_margin_decision_action is
'Canonical P4.2 operator-action manifest. SQL owns allowed actions, confirmation requirements, input requirements, labels, and the RPC function name; WeWeb renders and invokes only.';

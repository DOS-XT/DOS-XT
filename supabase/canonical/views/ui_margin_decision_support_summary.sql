-- DXT P08 RUNTIME BASELINE
-- Classification: REPLACE
-- Source: verified live Supabase runtime

create or replace view public.ui_margin_decision_support_summary
with (security_invoker = true)
as
with source_counts as (
    select
        owner_email,
        run_id,
        recommendation_id,
        count(*)::integer as source_record_count,
        count(*) filter (where included_in_sample)::integer as validated_source_count,
        count(*) filter (where not included_in_sample)::integer as pending_validation_count
    from public.rel_recommendation_source_record
    group by owner_email, run_id, recommendation_id
), support_base as (
    select
        d.owner_email,
        d.run_id,
        d.is_latest_run,
        d.recommendation_id,
        ep.evidence_pack_id,
        coalesce(nullif(btrim(ep.confidence_support_state), ''::text),
            case
                when nullif(btrim(ep.blocking_data_gap), ''::text) is not null then 'BLOCKED'::text
                when ep.validation_required then 'VALIDATION_REQUIRED'::text
                else 'VALIDATED'::text
            end) as support_status_code,
        coalesce(sc.source_record_count, ep.source_record_count, 0) as source_record_count,
        coalesce(sc.validated_source_count, 0) as validated_source_count,
        coalesce(sc.pending_validation_count, 0) as pending_validation_count,
        d.confidence_score,
        d.confidence_score_display as confidence_display,
        ep.confidence_support_state,
        coalesce(nullif(btrim(d.confidence_explanation), ''::text),
            case coalesce(nullif(btrim(ep.confidence_support_state), ''::text),
                case
                    when nullif(btrim(ep.blocking_data_gap), ''::text) is not null then 'BLOCKED'::text
                    when ep.validation_required then 'VALIDATION_REQUIRED'::text
                    else 'VALIDATED'::text
                end)
                when 'VALIDATED'::text then 'Supporting data is validated for this recommendation.'::text
                when 'VALIDATION_REQUIRED'::text then 'One or more supporting records require validation.'::text
                when 'EVIDENCE_GAP'::text then 'Confidence is constrained by a supporting-data gap.'::text
                when 'BLOCKED'::text then 'Confidence is blocked by a material data gap.'::text
                else 'Confidence reflects the available supporting data.'::text
            end) as confidence_support_explanation,
        ep.data_quality_score,
        ep.data_quality_level,
        ep.blocking_data_gap,
        ep.validation_required,
        case
            when nullif(btrim(ep.blocking_data_gap), ''::text) is not null then btrim(ep.blocking_data_gap)
            when ep.validation_required and coalesce(sc.pending_validation_count, 0) > 0 then
                concat(coalesce(sc.pending_validation_count, 0),
                    case
                        when coalesce(sc.pending_validation_count, 0) = 1 then ' supporting source requires validation.'::text
                        else ' supporting sources require validation.'::text
                    end)
            when ep.validation_required then 'Supporting data requires validation before action.'::text
            else 'No validation is currently required.'::text
        end as validation_summary,
        ep.selection_reason,
        d.selection_explanation,
        ep.updated_at as decision_support_updated_at,
        ep.root_cause_evidence_summary
    from public.out_margin_portfolio_decision d
    join public.op_evidence_pack ep
      on ep.owner_email = d.owner_email
     and ep.run_id = d.run_id
     and ep.recommendation_id = d.recommendation_id
    left join source_counts sc
      on sc.owner_email = d.owner_email
     and sc.run_id = d.run_id
     and sc.recommendation_id = d.recommendation_id
)
select
    owner_email,
    run_id,
    is_latest_run,
    recommendation_id,
    evidence_pack_id,
    support_status_code,
    case support_status_code
        when 'VALIDATED'::text then 'Validated'::text
        when 'VALIDATION_REQUIRED'::text then 'Validation Required'::text
        when 'EVIDENCE_GAP'::text then 'Support Gap'::text
        when 'BLOCKED'::text then 'Blocked'::text
        else 'Review Required'::text
    end as support_status_label,
    case support_status_code
        when 'VALIDATED'::text then 'success'::text
        when 'VALIDATION_REQUIRED'::text then 'warning'::text
        when 'EVIDENCE_GAP'::text then 'warning'::text
        when 'BLOCKED'::text then 'danger'::text
        else 'neutral'::text
    end as support_status_tone,
    case when nullif(btrim(root_cause_evidence_summary), ''::text) is not null then 1 else 0 end
  + case when nullif(btrim(confidence_support_explanation), ''::text) is not null then 1 else 0 end
  + case when source_record_count > 0 then 1 else 0 end
  + case when nullif(btrim(data_quality_level), ''::text) is not null
              or nullif(btrim(blocking_data_gap), ''::text) is not null then 1 else 0 end
      as support_fact_count,
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
from support_base;

alter view public.ui_margin_decision_support_summary owner to postgres;
revoke all on public.ui_margin_decision_support_summary from anon;
grant select on public.ui_margin_decision_support_summary to authenticated;
grant select on public.ui_margin_decision_support_summary to service_role;
comment on view public.ui_margin_decision_support_summary is null;

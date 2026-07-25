-- DXT P08 RUNTIME BASELINE
-- Classification: REPLACE
-- Source: verified live Supabase runtime

create or replace view public.ui_margin_decision_support_fact
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
), base as (
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
        ep.source_record_date_range,
        ep.root_cause_evidence_summary,
        coalesce(nullif(btrim(d.confidence_explanation), ''::text),
            case
                when ep.validation_required then 'One or more supporting records require validation.'::text
                when nullif(btrim(ep.blocking_data_gap), ''::text) is not null then 'Confidence is blocked by a material data gap.'::text
                else 'Supporting data is validated for this recommendation.'::text
            end) as confidence_support_explanation,
        ep.data_quality_level,
        ep.blocking_data_gap
    from public.out_margin_portfolio_decision d
    join public.op_evidence_pack ep
      on ep.owner_email = d.owner_email
     and ep.run_id = d.run_id
     and ep.recommendation_id = d.recommendation_id
    left join source_counts sc
      on sc.owner_email = d.owner_email
     and sc.run_id = d.run_id
     and sc.recommendation_id = d.recommendation_id
), facts as (
    select
        owner_email, run_id, is_latest_run, recommendation_id, evidence_pack_id,
        1 as fact_order,
        'ROOT_CAUSE'::text as fact_type,
        'Observed pattern'::text as fact_title,
        btrim(root_cause_evidence_summary) as fact_summary,
        support_status_code,
        source_record_count
    from base
    where nullif(btrim(root_cause_evidence_summary), ''::text) is not null

    union all

    select
        owner_email, run_id, is_latest_run, recommendation_id, evidence_pack_id,
        2,
        'SOURCE_COVERAGE'::text,
        'Supporting records'::text,
        concat(source_record_count,
            case when source_record_count = 1
                 then ' source record supports this recommendation'::text
                 else ' source records support this recommendation'::text end,
            case when nullif(btrim(source_record_date_range), ''::text) is not null
                 then concat(' • ', btrim(source_record_date_range))
                 else ''::text end,
            '.') as fact_summary,
        case when pending_validation_count > 0
             then 'VALIDATION_REQUIRED'::text
             else 'VALIDATED'::text end as support_status_code,
        source_record_count
    from base
    where source_record_count > 0

    union all

    select
        owner_email, run_id, is_latest_run, recommendation_id, evidence_pack_id,
        3,
        'CONFIDENCE'::text,
        'Confidence support'::text,
        btrim(confidence_support_explanation),
        support_status_code,
        source_record_count
    from base
    where nullif(btrim(confidence_support_explanation), ''::text) is not null

    union all

    select
        owner_email, run_id, is_latest_run, recommendation_id, evidence_pack_id,
        4,
        'DATA_QUALITY'::text,
        'Data quality'::text,
        case when nullif(btrim(blocking_data_gap), ''::text) is not null
             then btrim(blocking_data_gap)
             else concat('Data quality is ', lower(btrim(data_quality_level)), '.') end,
        case when nullif(btrim(blocking_data_gap), ''::text) is not null
             then 'BLOCKED'::text
             when lower(coalesce(data_quality_level, ''::text)) = any(array['needs review'::text, 'validation required'::text])
             then 'VALIDATION_REQUIRED'::text
             else 'VALIDATED'::text end,
        source_record_count
    from base
    where nullif(btrim(data_quality_level), ''::text) is not null
       or nullif(btrim(blocking_data_gap), ''::text) is not null
)
select
    owner_email,
    run_id,
    is_latest_run,
    recommendation_id,
    evidence_pack_id,
    fact_order,
    fact_type,
    fact_title,
    fact_summary,
    support_status_code as validation_status_code,
    case support_status_code
        when 'VALIDATED'::text then 'Validated'::text
        when 'VALIDATION_REQUIRED'::text then 'Validation Required'::text
        when 'EVIDENCE_GAP'::text then 'Support Gap'::text
        when 'BLOCKED'::text then 'Blocked'::text
        else 'Review Required'::text
    end as validation_status_label,
    case support_status_code
        when 'VALIDATED'::text then 'success'::text
        when 'VALIDATION_REQUIRED'::text then 'warning'::text
        when 'EVIDENCE_GAP'::text then 'warning'::text
        when 'BLOCKED'::text then 'danger'::text
        else 'neutral'::text
    end as validation_tone,
    source_record_count as source_count
from facts;

alter view public.ui_margin_decision_support_fact owner to postgres;
revoke all on public.ui_margin_decision_support_fact from anon;
grant select on public.ui_margin_decision_support_fact to authenticated;
grant select on public.ui_margin_decision_support_fact to service_role;
comment on view public.ui_margin_decision_support_fact is null;

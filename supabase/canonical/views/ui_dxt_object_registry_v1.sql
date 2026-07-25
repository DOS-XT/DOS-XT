-- DXT P08 canonical runtime extraction
-- Classification: CANONICAL (governance vocabulary correction pending)
-- Source verified from live Supabase runtime on 2026-07-25.

create or replace view public.ui_dxt_object_registry_v1
with (security_invoker = true)
as
select
    schema_name,
    object_name,
    object_type,
    architecture_layer,
    classification,
    clean_build_use,
    replacement_object,
    retirement_gate,
    rationale,
    audited_at
from public.ref_dxt_object_registry_v1
order by
    case classification
        when 'CLEAN_BUILD' then 1
        when 'CANONICAL' then 2
        when 'COMPATIBILITY' then 3
        when 'PROVISIONAL' then 4
        when 'RETIRE' then 5
        else null
    end,
    architecture_layer,
    object_name;

alter view public.ui_dxt_object_registry_v1 owner to postgres;
revoke all on public.ui_dxt_object_registry_v1 from anon;
grant select on public.ui_dxt_object_registry_v1 to authenticated;
grant select on public.ui_dxt_object_registry_v1 to service_role;
comment on view public.ui_dxt_object_registry_v1 is
'Authenticated read-only DXT backend object registry v1 for the clean WeWeb build and controlled legacy retirement.';

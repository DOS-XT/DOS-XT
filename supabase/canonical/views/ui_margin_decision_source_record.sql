-- DXT P08 RUNTIME BASELINE
-- Classification: REPLACE
-- Source: verified live Supabase runtime

create or replace view public.ui_margin_decision_source_record
with (security_invoker = true)
as
select
    owner_email, run_id, upload_batch_id, is_latest_run,
    recommendation_id, evidence_pack_id, source_position, source_link_id,
    source_record_type, source_table_name, source_record_id,
    source_file_name, source_raw_row_id, source_type_label, order_id,
    sku, sku_name, source_identity_display, source_record_date,
    observed_period_display, source_summary_display,
    source_validation_status_label, source_validation_tone, channel,
    quantity, revenue, revenue_display, unit_selling_price, unit_cost,
    product_cost_total, fulfillment_cost, shipping_cost,
    customer_paid_shipping, refund_amount, fees_allocated,
    gross_margin_before_ops, observed_margin, observed_margin_display,
    contribution_margin_pct, margin_after_shipping, estimated_leak_amount,
    estimated_leak_amount_display, fully_loaded_unit_cost, break_even_price,
    target_margin_pct, shipping_zone, package_size_class, data_quality_level,
    blocking_data_gap, included_in_sample, created_at
from public.out_margin_decision_workspace_evidence_source;

alter view public.ui_margin_decision_source_record owner to postgres;
revoke all on public.ui_margin_decision_source_record from anon;
grant select on public.ui_margin_decision_source_record to authenticated;
grant select on public.ui_margin_decision_source_record to service_role;
comment on view public.ui_margin_decision_source_record is
'Canonical Source Records UI contract for Decision Review. Grain: one row per source_link_id. Supersedes ui_margin_decision_workspace_evidence_source and ui_recommendation_source_records for new frontend bindings.';

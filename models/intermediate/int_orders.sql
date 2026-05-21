{{config (materialized='incremental',unique_key='order_id')}}


select
{{ dbt_utils.generate_surrogate_key(['order_id', 'customer_id']) }} as order_key,
 order_id, order_date, customer_id, clerk_name, 
total_price_usd, status_code, order_priority, ship_priority, comment,upd_date
 from {{ ref('stg_orders')}}
 

 {%if is_incremental ()%}
where upd_date >(select max(upd_date) from {{this}})
{% endif %}
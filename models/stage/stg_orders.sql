{{ config(materialized ='view')}}

with source as (
    select * from {{ source('src', 'orders2')}}
),

changed as (
    select
    -- id
        o_orderkey as order_id,
        o_custkey as customer_id,

    -- descriptions
        o_comment as comment,
        o_clerk as clerk_name,

    -- numbers
        o_totalprice as total_price_usd,
        {{usd_eur('o_totalprice')}} as total_price_eur,

    -- statuses
        o_orderstatus as status_code,
        upd_date as upd_date,
        o_orderpriority as order_priority,
        o_shippriority as ship_priority,
        o_orderdate as order_date
    from source
)

select * from changed


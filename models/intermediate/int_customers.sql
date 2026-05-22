with nations as (

    select 
        nation_id as nation_id,
        name as nation_name,
        region_id as region_id

    from {{ ref('stg_nations') }}

),

region as (

    select 
        region_id ,
        name as region_name

    from {{ ref('stg_region') }}

),

customers as (

    select 
        customer_id as customer_id,
        nation_id as nation_id,
        name as customer_name,
        address as address,
        phone_number as phone_number,
        account_balance as account_balance,
        market_segment as market_segment,
        comment as comment

    from {{ ref('stg_customers') }}
)

select 
    c.customer_id,
    c.customer_name,
    n.nation_name,
    r.region_name,
    c.address,
    c.phone_number,
    c.account_balance,
    c.market_segment,
    c.comment

from customers c

left join nations n
    on c.nation_id = n.nation_id

left join region r
    on n.region_id = r.region_id
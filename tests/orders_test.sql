select *
from {{ ref('int_orders') }}
where inventory_value_euro / 0.86 != inventory_value_usd

select inventory_value_euro / 0.86 != inventory_value_usd as test from {{ref('int_statistics')}} where test=true


select

    -- keys
    p.part_id,
    p.name as part_name,
    ps.supplier_id,
    s.supplier_name,

    -- raw fields
    p.retail_price,
    ps.cost as supply_cost,
    ps.available_quantity,
    s.account_balance,
    s.phone_number,
    s.supplier_address,

    -- audit columns
    current_user() as loaded_by,
    current_role() as loaded_role,
    current_timestamp() as loaded_at,

    -- 1. Inventory Value USD
    ps.available_quantity * ps.cost
        as inventory_value_usd,

    -- 2. Inventory Value EURO (approx conversion)
    (ps.available_quantity * ps.cost) * 0.86
        as inventory_value_euro,

    -- 3. Unit Margin
    p.retail_price - ps.cost as unit_margin,

    -- 4. Margin Percent
    coalesce(
        round(
            ((p.retail_price - ps.cost) / nullif(p.retail_price, 0)) * 100,
            2
        ),
        0
    ) as margin_percent,

    -- 5. Inventory Level
    case
        when ps.available_quantity >= 8000 then 'HIGH'
        when ps.available_quantity >= 3000 then 'MEDIUM'
        else 'LOW'
    end as inventory_level,

    -- 6. Supplier Financial Health
    case
        when s.account_balance <= 0 then 'RISK'
        when s.account_balance > 5000 then 'PREMIUM'
        else 'STANDARD'
    end as supplier_financial_health,

    -- 7. Supplier Data Status
    case
        when s.phone_number is null
          or s.supplier_address is null then false
        else true
    end as supplier_data_status,

    -- 8. Margin Status Normal
    case
        when ps.cost > p.retail_price then false
        else true
    end as margin_status_normal

from ANALYTICS.DBT_MRAJHN.STG_PARTS p

join ANALYTICS.DBT_MRAJHN.STG_PART_SUPPS ps
    on p.part_id = ps.part_id

join ANALYTICS.DBT_MRAJHN.STG_SUPPLIERS s
    on ps.supplier_id = s.supplier_id

order by supplier_id, 1, 2
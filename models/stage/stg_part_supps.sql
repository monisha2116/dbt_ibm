with part_supps as (
    select
        ps_partkey       as part_id,
        ps_suppkey       as supplier_id,
        ps_comment       as comment,
        ps_availqty      as available_quantity,
        ps_supplycost    as cost
    from SOURCEDB.MK_MALL.PARTSUPPS
)

select *from part_supps
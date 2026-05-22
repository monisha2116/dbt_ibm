with
    outnations as (
        select N_NATIONKEY as Nation_id,N_REGIONKEY as region_id, N_NAME as name,  N_COMMENT as comment
        from {{ source('src','nations') }}
    )

select *
from outnations
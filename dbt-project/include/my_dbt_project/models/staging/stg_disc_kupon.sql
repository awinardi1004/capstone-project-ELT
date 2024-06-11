

{{ config(
    materialized='table',
    schema='staging'
) }}

with discount_tabel as (

     select *
    from {{ source('source', 'DISCOUNT_KUPON') }} 
)

select *
from discount_tabel
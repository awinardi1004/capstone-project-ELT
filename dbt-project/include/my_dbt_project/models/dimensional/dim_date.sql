select distinct
    PARSE_DATE('%m/%d/%Y', Transaction_Date) as date,
    EXTRACT(day from PARSE_DATE('%m/%d/%Y', Transaction_Date)) as day,
    FORMAT_DATE('%b', PARSE_DATE('%m/%d/%Y', Transaction_Date)) as month,
    EXTRACT(year from PARSE_DATE('%m/%d/%Y', Transaction_Date)) as year
from {{ ref('stg_online_sales') }}

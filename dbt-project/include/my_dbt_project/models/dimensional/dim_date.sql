select distinct
    sales_date as date,
    EXTRACT(day from sales_date) as day,
    FORMAT_DATE('%b', sales_date) as month,
    EXTRACT(year from sales_date) as year
from {{ ref('int_online_sales') }}

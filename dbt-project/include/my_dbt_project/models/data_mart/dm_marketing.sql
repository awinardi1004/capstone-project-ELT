select
    fs.sales_date,
    dd.month as sales_month,
    fs.transaction_id,
    fs.customer_id,
    dc.gender as customer_gender,
    dc.location as customer_location,
    dp.product_category,
    fs.quantity,
    fs.amount,
    fs.coupon_code,
    fs.coupon_status,
from 
    {{ ref('fct_online_sales') }} as fs
left join 
    {{ ref('dim_date') }} as dd on fs.sales_date=dd.date
left join
    {{ ref('dim_customers') }} as dc on fs.customer_id=dc.customer_id
left join
    {{ref('dim_product') }} as dp on fs.product_id=dp.product_id
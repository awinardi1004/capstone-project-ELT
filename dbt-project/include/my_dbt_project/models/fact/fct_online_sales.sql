select
    os.transaction_id,
    os.customer_id,
    os.sales_date,
    os.product_id,
    os.quantity,
    os.amount,
     {{ get_coupon_code('os.coupon_status', 'dc.coupon_code') }} AS coupon_code,
from 
    {{ ref('int_online_sales') }} as os
join 
    {{ ref('dim_product') }} as dp on os.product_id=dp.product_id
join
    {{ ref('dim_date') }} as dd on os.sales_date=dd.date
left join
    {{ ref('dim_coupon') }} as dc on dd.month=dc.month_coupon and dp.product_category=dc.product_category_coupon and os.coupon_status ='Used'

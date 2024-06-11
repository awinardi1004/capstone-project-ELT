select
    Coupon_Code as coupon_code,
    Month as month_coupon,
    Discount_pct as  discount_pct,
    Product_Category as product_category_coupon
from {{ ref('stg_disc_kupon') }}
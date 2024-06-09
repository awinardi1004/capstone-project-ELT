select 
    Transaction_ID as transaction_id,
    CustomerID as customer_id,
    PARSE_DATE('%m/%d/%Y', Transaction_Date) as sales_date,
    Product_SKU as product_id,
    Quantity as quantity,
    Avg_Price as price,
    Quantity * Avg_Price as amount,
    Coupon_Status as coupon_Status
from {{ ref('stg_online_sales') }}
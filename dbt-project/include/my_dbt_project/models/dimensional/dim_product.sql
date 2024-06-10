select
    Product_SKU as product_id,
    ANY_VALUE(Product_Description) as product_description,
    ANY_VALUE(Product_Category) as product_category,
    AVG(Avg_Price) as price
from {{ ref('stg_online_sales') }}
group by Product_SKU


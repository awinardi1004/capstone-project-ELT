select
    ms.date,
    ms.offline_spend,
    ms.online_spend as ads_spend,
    sum(os.amount) as amount,
    count(os.transaction_id) as total_transaction
from
    {{ ref('fct_marketing_spend')}} as ms
join 
    {{ ref('fct_online_sales')}} as os on os.sales_date=ms.date
group by
    ms.date, ms.offline_spend, ms.online_spend
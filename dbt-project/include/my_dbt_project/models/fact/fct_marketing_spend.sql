select
    PARSE_DATE('%m/%d/%Y', Date) as date,
    Offline_Spend as offline_spend,
    Online_Spend as online_spend
from {{ ref('stg_marketing_spend') }}
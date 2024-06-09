SELECT DISTINCT
    PARSE_DATE('%m/%d/%Y', Transaction_Date) as date,
    EXTRACT(DAY FROM PARSE_DATE('%m/%d/%Y', Transaction_Date)) AS day,
    FORMAT_DATE('%b', PARSE_DATE('%m/%d/%Y', Transaction_Date)) AS month,
    EXTRACT(YEAR FROM PARSE_DATE('%m/%d/%Y', Transaction_Date)) AS year
FROM {{ ref('stg_online_sales') }}

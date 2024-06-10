select
    CustomerID as customer_id,
    Gender as gender,
    Location as location,
    Tenure_Months as tenure_months
from {{ ref('stg_customers') }}
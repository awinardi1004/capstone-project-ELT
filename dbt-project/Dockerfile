FROM quay.io/astronomer/astro-runtime:11.4.0

RUN python -m venv dbt_venv && source dbt_venv/bin/activate && \
    pip install --no-cache-dir dbt-bigquery==1.8.1 && deactivate

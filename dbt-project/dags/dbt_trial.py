from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import days_ago

# Define default arguments
default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2023, 1, 1),
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

# Define the DAG
dag = DAG(
    "scheduled_dbt_trial",
    default_args=default_args,
    catchup=False,
    schedule_interval="@daily",
)

# Task to run dbt run
dbt_run = BashOperator(
    task_id="dbt_run",
    bash_command="cd /usr/local/airflow/my_dbt_project && source usr/local/airflow/dbt_venv/Scripts/activate && dbt run --profiles-dir /usr/local/airflow/dbt-project/my_dbt_project/dbt-profiles/",
    dag=dag,
)

# Task to run dbt test
dbt_test = BashOperator(
    task_id="dbt_test",
    bash_command="cd /usr/local/airflow/my_dbt_project && source usr/local/airflow/dbt_venv/Scripts/activate && dbt run --profiles-dir /usr/local/airflow/dbt-project/my_dbt_project/dbt-profiles/",
    dag=dag,
)

# Set task dependencies
dbt_run >> dbt_test

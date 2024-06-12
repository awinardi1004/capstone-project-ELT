# capstone-project-ELT


## Tools
* Snowflake (Data Source 1)
* CSV (Data Source 2)
* Postgres (Data Source 3)
* BigQuery (Data Warehouse)
* Airbyte (Ingestion)
* Airflow (Orchestration)
* DBT (Transformation)

## Data Pipeline Design
This data pipeline uses the ELT concept, because it uses Airbyte as an ingestion tool
![data_pipeline](assets/pipeline_data.png)

## ERD
![erd](assets/ERD_logical.png)

## Clone This Repository
```
git clone https://github.com/awinardi1004/capstone-project-ELT.git
```
## Ingesting data on Airbyte
Run docker [compose](airbyte/docker-compose.yml) to use airbyte
```
docker-compose -f airbyte/docker-compose.yml up
```
Then open `localhost:8000` to access Airbyte.
```
Username: airbyte
Password: password
```
Create your source.

![source](assets/create_source.PNG)

Create your destination.

![destination](assets/create_destination.PNG)

Connect your data source with your data destination on Airbyte. At this stage you can schedule the data load.

![conection_airbyte](assets/create_conection_on_airbyte.PNG)

## Data Modeling on DBT
### Install using pip and virtual environments
Create new venv
```
python -m venv dbt_venv              # create the environment
```
Activate virtual environment         
```
dbt_venv\Scripts\activate            # activate the environment for Windows
```
### Install and Setup dbt
Install dbt-bigquery
```
python -m pip install dbt-bigquery
```
Run dbt cli to init dbt with BigQuery as data platform
```
dbt init my_dbt_project
```
Testing dbt connection
```
dbt debug
```
Setup DBT Project configuration
```
models:
  my_dbt_project:
    # Config indicated by + and applies to all files under models/example/
    staging:
      +materialized: table
      +schema: staging
    intermediate:
      +materialized: table
      +schema: intermediate
    dimensional:
      +materialized: table
      +schema: dimensional
    fact:
      +materialized: table
      +schema: fact
    data_mart:
      +materialized: table
      +schema: data_mart
```



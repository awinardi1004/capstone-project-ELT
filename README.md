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
Testing dbt connection. Make sure you are in your DBT project directory when testing the connection
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
Defining Source and creating your a Model
```
version: 2

sources:
  - name: source  
    tables:
      - name: DISCOUNT_KUPON
      - name: customers     
      - name: marketing_spend   
      - name: online_sales 

models:
  - name: stg_disc_kupon
    description: "A starter dbt model"
    columns:
      - name: COUPON_CODE
        description: "The primary key for this table"
        data_tests:
          - not_null
    
  - name: stg_customers
    description: "A customers staging model"
    columns:
      - name: CustomerID
        description: "The primary key for this table"
        data_tests:
          - not_null 
          - unique 
  
  - name: stg_marketing_spend
    description: "A marketing_spend staging model"
    columns:
      - name: Date
        description: "The primary key for this table"
        data_tests:
          - not_null

  - name: stg_online_sales
    description: "A online sales staging model"
    columns:
      - name: Transaction_ID
        description: "The primary key for this table"
        data_tests:
          - not_null 
```
### Run and test your model
Once you create a model, you can then run your model
```
dbt run
dbt test
```
### Results after creating the model
This is the result on your bigquery after running dbt successfully

![reult_dbt](assets/data%20warehouse.PNG)

## dbt automation with airflow
Before you run the Astro CLI you need to [download](https://github.com/astronomer/astro-cli/releases) the installer and add the installer path to your local environment variables.

<b>Create an Astro project</b>
</br>
```
astro dev init
```
This command generates all of the project files you need to run Airflow locally, including example DAGs that you can run out of the box.

<b>Run Airflow locally</b>
</br>
Before you run Airflow locally you need to add the following command to the [dockerfile](dbt-project/Dockerfile).
```
RUN python -m venv dbt_venv && source dbt_venv/bin/activate && \
    pip install --no-cache-dir dbt-bigquery==1.8.1 && deactivate
```
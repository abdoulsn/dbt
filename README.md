# dmo dbt Project

## Overview

This dbt project is designed to transform and model data from various sources, including Snowflake, into a structured format for analysis and reporting. The project includes models, seeds, and macros to facilitate data transformation and aggregation.

## Project Structure

- `models/`: Contains SQL files that define the dbt models.
- `seeds/`: Contains CSV files that are loaded into the database as tables.
- `macros/`: Contains reusable SQL snippets and macros.
- `analyses/`: Contains analysis queries.
- `tests/`: Contains tests for validating data models.
- `snapshots/`: Contains snapshot definitions for capturing historical data.

## Configuration

The project configuration is defined in the `dbt_project.yml` file. Key configurations include:

- `name`: The name of the project.
- `version`: The version of the project.
- `profile`: The dbt profile to use for this project.
- `model-paths`, `seed-paths`, `macro-paths`, etc.: Directories where dbt looks for different types of files.

## Models

### Example Model: `snf_sample_data_store_sales.sql`

This model transforms the `store_sales` data from the Snowflake sample source.

```sql
with source_store_sales as (
    select
        ss_sold_date_sk,
        ss_item_sk,
        ss_customer_sk,
        ss_cdemo_sk,
        ss_hdemo_sk,
        ss_addr_sk,
        ss_store_sk,
        ss_promo_sk,
        ss_ticket_number,
        ss_quantity,
        ss_wholesale_cost,
        ss_list_price,
        ss_sales_price,
        ss_ext_discount_amt,
        ss_ext_sales_price,
        ss_ext_wholesale_cost,
        ss_ext_list_price,
        ss_ext_tax,
        ss_coupon_amt,
        ss_net_paid,
        ss_net_paid_inc_tax,
        ss_net_profit
    from
        {{ source('snowflake_sample_src', 'store_sales') }}
),
store_sales as (
    select
        *
    from
        source_store_sales
)
select * from store_sales
```
Example Model: ``my_first_dbt_model.sql``
This model aggregates user sessions data from a raw sessions table.
````snowflake
{{ config(materialized='table') }}

with raw_sessions as (
    select
        user_id,
        session_id,
        session_start,
        session_end
    from
        raw.sessions
    )
select
    user_id,
    count(session_id) as total_sessions,
    min(session_start) as first_session,
    max(session_end) as last_session
from
    raw_sessions
group by
    user_id
````
## Seeds
**Example Seed**: `country_codes.csv`
This seed file contains a list of country codes and their corresponding country names.
```csv
country_code,country_name
US,United States
CA,Canada
GB,United Kingdom
```
## Macros
**Example Macro**: `get_current_date.sql`
This macro returns the current date in the format `YYYY-MM-DD`.
```sql
{% macro get_current_date() %}
    select
        current_date() as current_date
{% endmacro %}
```
### Running the project
To run the dbt project, you can use the following commands:
- `dbt run`: Compiles the SQL files in the `models/` directory and runs them in the target database.
- `dbt test`: Runs the tests in the `tests/` directory to validate the data models.
- `dbt snapshot`: Runs the snapshot definitions in the `snapshots/` directory to capture historical data.
- `dbt compile`: Compiles the SQL files in the `models/` directory without running them.
- `dbt docs generate`: Generates documentation for the project.
- `dbt seed`: Loads the seed files in the `seeds/` directory into the target database.
- `dbt run-operation <operation-name>`: Runs a custom operation defined in the `operations/` directory.
- `dbt run-operation <operation-name> --args <arguments>`: Runs a custom operation with arguments.
- `dbt run --models <model-name>`: Runs a specific model.
- `dbt run --exclude <model-name>`: Excludes a specific model from the run.
- `dbt run --full-refresh`: Runs the project with full refresh.
- `dbt run --fail-fast`: Stops the run on the first failure.
- `dbt run --profiles-dir <path>`: Specifies the directory where the dbt profiles are located.
- `dbt run --target <target-name>`: Specifies the target profile to use for the run.
- `dbt run --vars <key:value,key:value>`: Specifies variables to pass to the project.
- `dbt run --no-write`: Runs the project without writing to the target database.
- `dbt run --no-partial-parse`: Runs the project without partial parsing.
- `dbt run --no-partial-parsing`: Runs the project without partial parsing.
- `dbt run --no-cache`: Runs the project without using the cache.
- `dbt run --no-deps`: Runs the project without evaluating dependencies.
- `dbt run --state`: Runs the project with the specified state.
- `dbt run --state <state>`: Runs the project with the specified state.
- `dbt run --state <state> --models <model-name>`: Runs the specified model with the specified state.
- `dbt run --state <state> --full-refresh`: Runs the project with the specified state and full refresh.
- `dbt run --state <state> --fail-fast`: Runs the project with the specified state and stops on the first failure.
- `dbt run --state <state> --profiles-dir <path>`: Runs the project with the specified state and profiles directory.
- `dbt run --state <state> --target <target-name>`: Runs the project with the specified state and target profile.
- `dbt run --state <state> --vars <key:value,key:value>`: Runs the project with the specified state and variables.
- `dbt run --state <state> --no-write`: Runs the project with the specified state without writing to the target database.
- `dbt run --state <state> --no-partial-parse`: Runs the project with the specified state without partial parsing.
- `dbt run --state <state> --no-partial-parsing`: Runs the project with the specified state without partial parsing.
- `dbt run --state <state> --no-cache`: Runs the project with the specified state without using the cache.
- `dbt run --state <state> --no-deps`: Runs the project with the specified state without evaluating dependencies.
- `dbt run --state <state> --full-refresh --fail-fast`: Runs the project with the specified state, full refresh, and stops on the first failure.
- `dbt run --state <state> --full-refresh --fail-fast --profiles-dir <path>`: Runs the project with the specified state, full refresh, stops on the first failure, and specifies the profiles directory.
- `dbt run --state <state> --full-refresh --fail-fast --profiles-dir <path> --target <target-name>`: Runs the project with the specified state, full refresh, stops on the first failure, specifies the profiles directory, and specifies the target profile.
- `dbt run --state <state> --full-refresh --fail-fast --profiles-dir <path> --target <target-name> --vars <key:value,key:value>`: Runs the project with the specified state, full refresh, stops on the first failure, specifies the profiles directory, specifies the target profile, and specifies variables.
- `dbt run --state <state> --full-refresh --fail-fast --profiles-dir <path> --target <target-name> --vars <key:value,key:value> --no-write`: Runs the project with the specified state, full refresh, stops on the first failure, specifies the profiles directory, specifies the target profile, specifies variables, and runs without writing to the target database.
- 


# E-commerce Analytics Pipeline

## Overview

This project implements an end-to-end analytics data pipeline for e-commerce event data using **Docker, Python, PostgreSQL and dbt**. It ingests raw event logs from a CSV file, processes them through a layered transformation architecture, and exposes business-ready data marts for analytics and reporting.

The system follows an **Kimball-style dimensional modeling approach**, where user behavior (events) is the primary source of truth.

---

## Architecture

The project is structured using a standard dbt layered approach:

```
staging → intermediate → marts
```

### 1. Staging Layer

* Cleans and standardizes raw data
* Applies basic transformations (casting, renaming)
* Source: raw CSV loaded into PostgreSQL (Downloaded from Kaggle: https://www.kaggle.com/datasets/mkechinov/ecommerce-events-history-in-electronics-store, https://rees46.com/)

### 2. Intermediate Layer

Defines core business grains and reusable models:

* **int_events** → 1 row per event (deduplicated)
* **int_sessions** → 1 row per session
* **int_user_daily_activity** → 1 row per user per day

Also includes derived dimensions:

* **dim_product** → product attributes derived from events
* **dim_user** → user lifecycle (first/last seen)
* **dim_date** → calendar dimension (using 'dbt_utils.date_spine' to generate a full sequence of days, even on days without events) 

### 3. Marts Layer

Business-facing models designed for analytics use cases:

* **fct_revenue_daily** → daily revenue and monetization metrics
* **fct_funnel_daily** → user conversion funnel (view → cart → purchase)
* **fct_product_performance** → product-level engagement and revenue
* **fct_session_performance** → session-level engagement and conversion

---

## Data Modeling Approach

This project uses an **event-first data modeling strategy**:

* Events are the most granular and reliable source of truth
* Higher-level entities (sessions, users, products) are derived from events
* Dimensions are "best-effort" due to the nature of the data and the lack of authentic source systems

Key modeling principles:

* Clear grain definition per model
* Separation of facts and dimensions
* Reuse of intermediate models to avoid duplication
* Business-oriented marts aligned with analytical use cases and stakeholders needs

---

## Data Pipeline

### Ingestion

* Python scripts download and load CSV data into PostgreSQL (raw schema)

### Transformation

* dbt models transform raw data into structured layers

---

## Data Quality

The project includes dbt tests to ensure data reliability:

* **Not null tests** on key fields
* **Uniqueness tests** for primary keys
* **Range tests** for metrics (e.g. conversion rates between 0–100)
* **Business logic tests** (e.g. purchases ≤ carts ≤ views)

---

## Key Metrics

The marts expose core e-commerce metrics:

* Revenue, Orders, Average Order Value (AOV)
* Conversion rates (view → cart → purchase)
* Revenue per user
* Session conversion and duration
* Product performance metrics

---

## Project Structure

```
├── README.md
├── .gitignore
├── .env  # Env variables (db credentials, kaggle credentials)
├── conda-env.yaml # Conda environment for python tools
├── Makefile
│
├── infrastructure/
│   ├── docker-compose.yml
│   └── sql/
│       └── init.sql
│
├── ingestion/
│   ├── sources/
│   │   └── download_data.py  # Script to get the data
│   │   └── events.csv  # CSV source file
│   │
│   └── loaders/
│       └── load.py  # Load raw data from CSV file to raw.events table
│
└── warehouse/  # dbt project root directory
    ├── dbt_project.yml
    ├── packages.yml  # dbt utils tools
    │
    ├── .dbt/
    │   └── profiles.yml
    │
    ├── macros/
    │   └── generate_schema_name.sql
    │
    ├── models/  # dbt models divide in three different layers (staging - intermediate - marts)
    │   ├── staging/
    │   │   └── stg_events.sql
    │   │
    │   ├── intermediate/
    │   │   ├── int_events.sql
    │   │   ├── int_sessions.sql
    │   │   ├── int_user_daily_activity.sql
    │   │   ├── dim_date.sql
    │   │   ├── dim_users.sql
    │   │   ├── dim_products.sql
    │   │   └── int_schemas.yml # schemas definition and simple tests for intermediate models
    │   │
    │   └── marts/
    │       ├── mart_funnel_daily.sql
    │       ├── mart_revenue_daily.sql
    │       ├── mart_product_performance.sql
    │       ├── mart_session_performance.sql
    │       └── marts_schemas.yml  # schemas definition and simple tests for marts models
    │
    └── tests/ # Singular dbt tests
        ├── existing_sessions.sql
        ├── valid_funnel.sql
        ├── valid_revenue.sql
        └── valid_session_time.sql
```

---

## Stack

* **Docker** → environment setup
* **Python** → data ingestion (CSV download + load)
* **PostgreSQL** → data warehouse
* **dbt** → data transformations and modeling

---

## How to Run

### Pre requisites

- Docker and Docker Compose
- Conda (MiniConda or Anaconda environment managers)

### Setup

1. Clone the repository

	- **HTTPS:**`git clone https://github.com/mt-gonzalez/de-projects.git`
	- **SSH:** `git clone git@github.com:mt-gonzalez/de-projects.git`

`cd data-warehouse-elt-pipeline`

2. Create and activate the conda environmen

`conda env create -f conda-env.yaml`

`conda activate pipeline-env`

3. Start the containers (you can use make shortcuts)

	- Define .env file with your credentials! (check .env.example)
	
`make up`

4. Download raw data (you need a Kaggle account)

`python ingestion/source/download_data.py`

5. Load raw data to Postgresql DB

`python ingestion/loader/load.py`

6. Install dbt Dependencies

`make dbt-deps`

7. Run the transformation models

`make dbt-build <!-- This runs models and tests -->`

- To run specifics models use:

`make run-model -s m=<model-name>`

`make run-model -s m=+<model-name> <!-- The prefix '+' runs needed references to the actual model -->`

8. Inspect the generated models in the database

`docker exec -it  postgres_db psql -U <POSTGRES_USER> -d <POSTGRES_DB>`

---

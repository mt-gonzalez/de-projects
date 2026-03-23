# Modern ELT Data Pipeline #

## Description

Data engineering project that implements an ELT (extract-transform-load) data pipeline using PostgreSQL as a data warehouse, dbt (Data Building Tool) to model the data into a star schema and then serving this data in specialized data marts.

[SOURCE] -> [INGESTION] -> [RAW DATA] -> [STAGING] -> [INTERMEDIATE] -> [MARTS] -> [BI]

```
├── README.md
├── .gitignore
├── requirements.txt
│
├── infrastructure/          # (opcional) setup DB, docker, etc.
│   ├── docker/
│   │   ├── docker-compose.yml
│   │   └── airflow.Dockerfile 
│   └── sql/
│       └── init.sql
│
├── ingestion/
│   ├── sources/
│   │   └── download_data.py  # Script to get the data
│   │   └── events.csv  # CSV source file
│   ├── loaders/
│   └── pipelines/
```

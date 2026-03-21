# Modern ELT Data Pipeline #

## Description

Data engineering project that implements an ELT (extract-transform-load) data pipeline using PostgreSQL as a data warehouse, dbt (Data Building Tool) to model the data into a star schema and then serving this data in specialized data marts.

[SOURCE] -> [INGESTION] -> [RAW DATA] -> [STAGING] -> [INTERMEDIATE] -> [MARTS] -> [BI]


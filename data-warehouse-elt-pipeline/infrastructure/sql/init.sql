CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE SCHEMA IF NOT EXISTS raw;

CREATE TABLE IF NOT EXISTS raw.events (
    event_time timestamp,
    event_type text,
    product_id bigint,
    category_id bigint,
    category_code text,
    brand text,
    price numeric(10,2),
    user_id bigint,
    user_session text
);

CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS marts;

# PostgreSQL (Debezium) - Kafka - Spark Delta Lake
## Description

This project is a demo for testing a CDC (Change Data Capture). All infraestructure is build by docker.
![alt text](https://github.com/masfworld/cdc_deltaLake/blob/main/img/architecture.png?raw=true)

## Features

- PostgreSql as Legacy database
- Debezium as Change Data Capture
- Kafka to ingest data from Debezium
- KSQLDB to transform Avro messages into JSON
- Spark Delta Lake to manage events from legacy database
<h1 align="center"> 
    About
</h1>

-------------------------

Moses is an acronym for Motor Milestone, which is the final project of the internship program at Telkom Indonesia, created by Alfath, Eci, and Wulan, mentored by Billy. The reason for choosing this name is that it represents our first step towards becoming Data Engineers in the professional world. Just like the developmental milestones in a baby's movement, we hope this project will guide us to navigate well in the Data Engineering field.

This final project is an ETL pipeline with the infrastructure depicted in the diagram below. All components operate within an Azure VM, each with its own container.

1. PostgreSQL serves as the data source used in this pipeline.
2. Airbyte functions to perform data ingestion from the data source.
3. Airflow serves as the orchestration of each process in the pipeline.
4. DBT functions to transform the data source into raw data stored in the data warehouse.
5. Clickhouse serves as the data warehouse.
6. Superset functions to visualize the data.

<h1 align="center"> 
    Documentation
</h1>

-------------------------

## Important Docker Command

### Check Running Docker Container
```
docker ps
```

### Run Docker Compose
```
docker compose -f <DOCKER COMPOSE FILE NAME> up -d
```
- -f: Specify the name of the Docker Compose file
- -d: Run compose in background

### Starts new shell session in the container
```
docker exec -it <ID/NAME CONTAINER> bash
```

### Shutdownn Docker Compose
```
docker compose -f <DOCKER COMPOSE FILE NAME> down
```

### Delete Container
```
docker rm <DOCKER COMPOSE FILE NAME>
```

## DBT Documentation

### Run DBT Container
1. Go to main folder
2. Run docker compose
3. Check container ID dbt
4. Starts new shell session in the container
5. Create folder project in host machine (not in dbt container)
    ```
    dbt init <FOLDER NAME>
    ```
    *Note: If successful, a new folder will appear*
6. Test connection with clickhouse
    ```
    dbt debug
    ```
    *Note: If successful, the message "Connection test: [OK connection ok]" will appear in the terminal*
7. Run dbt
    ```
    dbt run
    ```
8. After usage, shut down Docker Compose

**For complete documentation, you can refer to the [ClickHouse website](https://clickhouse.com/docs/en/integrations/dbt)**

### Port Usage
- 2222:22 &#8594; SSH

## Airflow Documentation

### Dashboard Password
- Username: Airflow
- Password: Airflow

### Port Usage
- 8080:8080 &#8594; Webserver

## ClickHouse Documentation

### Run Clickhouse Container
1. Go to main folder
2. Run docker compose
3. Check container ID clickhouse
4. Starts new shell session in the container
5. Start clickhouse client
    ```
    clickhouse-client --user=<USERNAME> --password=<PASSWORD>
    ```
6. After usage, shut down Docker Compose
   
### Admin Access
- USERNAME: admin
- PASSWORD: admin

### Default Access
- USERNAME: default
- PASSWORD: test

### Port Usage
- 8123:9123 &#8594; ClickHouser server
- 9000:8002 &#8594; ClickHouser client

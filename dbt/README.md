# DBT Documentation

## Run Clickhouse
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

## Docker Compose File Explaination
### Port Usage
- 2222:22 -> SSH

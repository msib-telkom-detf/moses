# ClickHouse Documentation

## Run Clickhouse
1. Go to main folder
2. Run docker compose
3. Check container ID clickhouse
4. Starts new shell session in the container
5. Start clickhouse client
    ```
    clickhouse-client --user=<USERNAME> --password=<PASSWORD>
    ```
    - For admin access
        - USERNAME = admin
        - PASSWORD = admin
    - For default access
        - USERNAME = default
        - PASSWORD = test
6. After usage, shut down Docker Compose

## Docker Compose File Explaination
- Port Container
    - 8123: ClickHouser server
    - 9000: ClickHouser client
- Port Host
    - 9123: Port forward ClickHouse server on host
    - 8002: Port forward ClickHouse client on host

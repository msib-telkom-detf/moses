# ClickHouse Documentation

## Run Clickhouse
1. Go to clickhouse folder
2. Run docker compose clickhouse
3. Check container ID
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
7. After usage, shut down Docker Compose.

## Docker Compose File Explaination
- Port Container
    - 8123: ClickHouser server
    - 9000: ClickHouser client
- Port Host
    - 9123: Port forward ClickHouser server on host
    - 8002: Port forward ClickHouser client on host

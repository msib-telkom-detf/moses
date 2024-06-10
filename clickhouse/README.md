# ClickHouse Documentation

## Run Clickhouse Container
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

## Port Usage
- 8123:9123 &#8594; ClickHouser server
- 9000:8002 &#8594; ClickHouser client

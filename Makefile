_require_username_clickhouse:
ifndef username_clickhouse
	$(error username_clickhouse must be defined.)
endif

_require_password_clickhouse:
ifndef password_clickhouse
	$(error password_clickhouse must be defined.)
endif

_require_username_postgres:
ifndef username_clickhouse
	$(error username_postgres must be defined.)
endif

# Build container image
build:
	docker-compose --env-file=./airbyte/airbyte.env build

# Deploy container
up:
	docker-compose --env-file=./airbyte/airbyte.env up -d

# Build the image and deploy the container if there are any changes to any Dockerfile
container_deploy: build up

container_down:
	up:
	docker-compose --env-file=./airbyte/airbyte.env down -d

# Run clickhouse client container
run_clickhouse_client: _require_username_clickhouse _require_password_clickhouse
	docker exec -it clickhouse clickhouse-client --user $(username_clickhouse) --password $(password_clickhouse)

run_dbt:
	docker exec -it dbt bash

run_postgres:
	docker exec -it psql -U $(usename_postgres)



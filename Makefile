_require_username_clickhouse:
ifndef username
	$(error username must be defined.)
endif

_require_password_clickhouse:
ifndef password
	$(error password must be defined.)
endif

_require_username_postgres:
ifndef username
	$(error username must be defined.)
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
	docker exec -it clickhouse clickhouse-client --user $(username) --password $(password)

run_dbt:
	docker exec -it dbt bash

run_postgres: _require_username_postgres
	docker exec -it postgres psql -U $(username)



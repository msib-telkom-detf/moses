_require_username_clickhouse:
ifndef username_clickhouse
	$(error username_clickhouse must be defined.)

_require_password_clickhouse:
ifndef password_clickhouse
	$(error username_clickhouse must be defined.)


# Build container image
build:
    docker-compose --env-file=./airbyte/airbyte.env build

# Deploy container
up:
    docker-compose --env-file=./airbyte/airbyte.env up -d

# Build the image and deploy the container if there are any changes to any Dockerfile
container_deploy: build up

# Run clickhouse client container
run_clickhouse_client:
	@read -p "Enter username: " USERNAME; \
	read -p "Enter password: " PASSWORD; \
	docker exec -it clickhouse clickhouse-client --user $(username_clickhouse) --password $(password_clickhouse)
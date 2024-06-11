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
	docker exec -it clickhouse clickhouse-client --user $$USERNAME --password $$PASSWORD
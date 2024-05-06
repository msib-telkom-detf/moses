<h1 align="center"> 
    About
</h1>

-------------------------

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
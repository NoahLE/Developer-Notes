# Docker

## Useful commands

- Build the Docker environment

```bash
docker-compose up
```

- List all running Docker containers

```bash
docker ps -a
```

- Execute a command on a running Docker container

```bash
docker exec -it <CONTAINER_ID_OR_NAME> <COMMAND>
```

- Cleanup stopped containers, networks not used by any containers, dangling images, build cache

```bash
docker system prune
```

- Rebuild a Docker container

```bash
docker build --no-cache .
``` 
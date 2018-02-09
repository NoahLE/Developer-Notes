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

## Backing up a container

1. Find out what the name of the container is

```bash
# Shows a list of running containers
docker ps
```

2. Create a backup of the container using the `commit` command

```bash
docker commit -p <CONTAINER_ID> <NAME_OF_BACKUP>
```

3. Create a `.tar` version of the backup image for off-site storage

```bash
docker save -o <BACKUP_NAME>.tar <BACKUP_NAME>
```

4. Copy off the backup using `rsync` or `scp`. It is also possible to use something like [docker backup](https://hub.docker.com/r/boombatower/docker-backup/)

See [the rsync page](server/rsync) for more information
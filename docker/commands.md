# Docker Commands

- Current Docker status

```bash
docker info
```

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

- Build a container with a tag name

```bash
docker build -t <IMAGE_NAME>
```

- Change the port a Container is accessible from

```bash
docker run -p <PORT_YOU_WILL_ACCESS:CONTAINER_PORT> <IMAGE_TAG>
```

- Start and stop a container in the background (detached mode)

```bash
# Start
docker run -d <CONTAINER_NAME>

# Stop
docker container stop <CONTAINER_ID>
```

- Login to Docker Cloud

```bash
docker login
```

- Add tag to image

```bash
# Tag is used for versioning the images
docker tag <IMAGE_NAME> <USERNAME>/<REPOSITORY>:<TAG>
```

- Push image to Docker Cloud

```bash
docker push <USERNAME>/<REPOSITORY>:<TAG>
```

- Run image from Docker Cloud

```bash
docker run <USERNAME>/<REPOSITORY>:<TAG>
```

- Starting and stopping the Docker Swarm

```bash
# Start the swarm
docker swarm init

# Deploy to the swarm
docker stack deploy -c docker-compose.yml <APP_NAME>

# Stop the swarm
docker swarm leave --force

# Remove the stack from swarm
docker stack rm <APP_NAME>
```

- Show running services

```bash
docker service ls
```

## Cheatsheet - Part 2

```bash
docker build -t friendlyhello .  # Create image using this directory's Dockerfile
docker run -p 4000:80 friendlyhello  # Run "friendlyname" mapping port 4000 to 80
docker run -d -p 4000:80 friendlyhello         # Same thing, but in detached mode
docker container ls                                # List all running containers
docker container ls -a             # List all containers, even those not running
docker container stop <hash>           # Gracefully stop the specified container
docker container kill <hash>         # Force shutdown of the specified container
docker container rm <hash>        # Remove specified container from this machine
docker container rm $(docker container ls -a -q)         # Remove all containers
docker image ls -a                             # List all images on this machine
docker image rm <image id>            # Remove specified image from this machine
docker image rm $(docker image ls -a -q)   # Remove all images from this machine
docker login             # Log in this CLI session using your Docker credentials
docker tag <image> username/repository:tag  # Tag <image> for upload to registry
docker push username/repository:tag            # Upload tagged image to registry
docker run username/repository:tag                   # Run image from a registry
```

## Cheatsheet - Part 3

```bash
docker stack ls                                            # List stacks or apps
docker stack deploy -c <composefile> <appname>  # Run the specified Compose file
docker service ls                 # List running services associated with an app
docker service ps <service>                  # List tasks associated with an app
docker inspect <task or container>                   # Inspect task or container
docker container ls -q                                      # List container IDs
docker stack rm <appname>                             # Tear down an application
docker swarm leave --force      # Take down a single node swarm from the manager
```
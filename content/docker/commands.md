---
title: Docker Commands
date: "2018-02-28"
publish: true
---

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

- List all running Docker containers in the swarm

```bash
docker stack ps <SWARM_NAME>
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

Always run `init` and `join` on port `2377`. Never use port `2376`, since this is the port the Docker daemon uses.

```bash
# Start the swarm
docker swarm init

# Deploy to the swarm
docker stack deploy -c docker-compose.yml <APP_NAME>
# If deploying from a remote registry, add the --with-registry-auth
# docker stack deploy --with-registry-auth -c ...

# Stop the swarm
docker swarm leave --force

# Remove the stack
docker stack rm <APP_NAME>
```

- Show running services

```bash
docker service ls
```

- Creating a switch locally for VMs to connect to each other

```bash
# On Windows
# You may need to open Hyper-V Manager > Virtual Switch Manager > Create Virtual Switch
# It should have an External type
# Give it a name such as "myswitch" and check the box to share the host machine's active network adapter
docker-machine create -d hyperv --hyperv-virtual-switch "myswitch" myvm1
docker-machine create -d hyperv --hyperv-virtual-switch "myswitch" myvm2

# On Linux / Mac
# You may need to install Docker Toolbox or Virtualbox
docker-machine create --driver virtualbox myvm1
docker-machine create --driver virtualbox myvm2
```

- List all VMs

```bash
# The shell must be run as an administrator
docker-machine ls
```

- Send command to a Docker VM

```bash
# If having SSH trouble, try using the --native-ssh flag
# docker-machine --native-ssh ssh ...
docker-machine ssh <VM_NAME> "<COMMAND>"
```

- Create a swarm manager

```bash
# Get the VM IPs
docker-machine ls

# Declare the manager
docker-machine ssh <VM_NAME> "docker swarm init --advertise-addr <VM_IP>"
```

- Add worker to swarm (after adding a manager)

```bash
docker swarm join --token <TOKEN> <MANAGER_VM_IP>:2377
```

- List all swarm machines

```bash
docker-machine ssh <VM_MANAGER_NAME> "docker node ls"
```

- Leave the swarm

```bash
# This must be done on each machine that you wish to remove from the swarm
docker-machine ssh <WORKER_VM_NAME> "docker swarm leave"
```

- Set docker-machine shell to send commands to the swarm manager

```bash
# Run this to get the manager's settings
docker-machine env <VM_MANAGER_NAME>

# Run the last line of the results
# It will say something like: Run this command to configure your shell:

# For Windows
& "C:\Program Files\Docker\Docker\Resources\bin\docker-machine.exe" env <VM_MANAGER_NAME> | Invoke-Expression

# In Linux / Mac
eval $(docker-machine env myvm1)

# Test it worked by seeing if the swarm information appears
docker-machine ls
```

- Unset the shell to send commands to the swarm manager

```bash
eval $(docker-machine env -u)
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

## Cheatsheet - Part 4

```bash
docker-machine create --driver virtualbox myvm1 # Create a VM (Mac, Win7, Linux)
docker-machine create -d hyperv --hyperv-virtual-switch "myswitch" myvm1 # Win10
docker-machine env myvm1                # View basic information about your node
docker-machine ssh myvm1 "docker node ls"         # List the nodes in your swarm
docker-machine ssh myvm1 "docker node inspect <node ID>"        # Inspect a node
docker-machine ssh myvm1 "docker swarm join-token -q worker"   # View join token
docker-machine ssh myvm1   # Open an SSH session with the VM; type "exit" to end
docker node ls                # View nodes in swarm (while logged on to manager)
docker-machine ssh myvm2 "docker swarm leave"  # Make the worker leave the swarm
docker-machine ssh myvm1 "docker swarm leave -f" # Make master leave, kill swarm
docker-machine ls # list VMs, asterisk shows which VM this shell is talking to
docker-machine start myvm1            # Start a VM that is currently not running
docker-machine env myvm1      # show environment variables and command for myvm1
eval $(docker-machine env myvm1)         # Mac command to connect shell to myvm1
& "C:\Program Files\Docker\Docker\Resources\bin\docker-machine.exe" env myvm1 | Invoke-Expression   # Windows command to connect shell to myvm1
docker stack deploy -c <file> <app>  # Deploy an app; command shell must be set to talk to manager (myvm1), uses local Compose file
docker-machine scp docker-compose.yml myvm1:~ # Copy file to node's home dir (only required if you use ssh to connect to manager and deploy the app)
docker-machine ssh myvm1 "docker stack deploy -c <file> <app>"   # Deploy an app using ssh (you must have first copied the Compose file to myvm1)
eval $(docker-machine env -u)     # Disconnect shell from VMs, use native docker
docker-machine stop $(docker-machine ls -q)               # Stop all running VMs
docker-machine rm $(docker-machine ls -q) # Delete all VMs and their disk images
```

## Sources

- [Waiting for host to start error](https://github.com/docker/machine/issues/3832)
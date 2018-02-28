---
title: Docker Backup & Restoration
date: "2018-02-28"
publish: true
---

# Backup and restoration

**Note**: Backups do NOT save the data in the container. If you would like to keep the data too, please check out the section on Docker data volumes below.

## Backing up a container

1. Find out what the name of the container is

```bash
# Shows a list of running containers
docker ps
```

2. Create a backup of the container using the `commit` command

```bash
# Save a copy of the container
docker commit -p <CONTAINER_ID> <NAME_OF_BACKUP>
```

3. Create a `.tar` version of the backup image for off-site storage

```bash
# Show all images
docker images

# Backup the commit of the container
docker save -o <BACKUP_NAME>.tar <BACKUP_NAME>
```

4. Copy off the backup using `rsync` or `scp`. It is also possible to use something like [docker backup](https://hub.docker.com/r/boombatower/docker-backup/)

See [the rsync page](server/rsync) for more information

## How to restore a container

1. Load the image using the `load` command

```bash
docker load -i <BACKUP_NAME>.tar
```

2. Run the image

```bash
docker run <IMAGE_NAME>
```

## Backup data volumes

Data volumes are stored outside of Docker containers and is shared among the containers. The default location is `var/lib/docker/volumes`.

1. List the available volumes

```bash
docker volume ls
```

2. Find the location of the the data-directory of the container

```bash
# It will be located under Mounts: [ "Destination": <DATA_DIRECTORY> ]
docker inspect <CONTAINER_NAME>
```

3. Backup the volume

```bash
# Flags:
docker run --rm --volumes-from <CONTAINER_NAME> -v $(pwd):<BACKUP_LOCATION> ubuntu tar cvf /<BACKUP_LOCATION>/<BACKUP_NAME>.tar /<DATA_DIRECTORY>
```

4. Move the file off-server for save keeping. See the [rsync]() page for more information

## Restore data volumes

1. Create a new container with the data-volume backup and the container

```bash
docker run -v /<DATA_DIRECTORY> --name <CONTAINER_NAME> ubuntu /bin/bash
```

2. Untar the backup file to the new container's data volume

```bash
docker run --rm --volumes-from <CONTAINER_NAME> -v $(pwd):/<BACKUP_LOCATION> ubuntu bash -c "cd /<DATA_DIRECTORY> && tar vxf /<BACKUP_DIRECTORY>/<BACKUP_FILE>.tar --strip 1"
```

## Sources

- [Docker - Easy backup and restore](https://bobcares.com/blog/docker-backup/2/)
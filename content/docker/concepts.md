---
title: Docker Concepts
date: "2018-02-28"
publish: true
---

The Docker setup looks like the following: Stack -> Services -> Containers

## Meta

- Image - executable package with the the code, a runtime, libraries, environment variables, and configuration files
- Container - A runtime instance of an image
- Working directory - When a process refers to a file, the working directory is the top of the hierarchy for where it searches for the file
- Services - The different pieces of the app (storing data to database, video encoder, etc)
- Swarm - A group of machines, running Docker containers, which are joined together to run an application
- Swarm node - Each machine in the swarm is referred to as a node
- Swarm manager - The way commands and load balancing is run in the swarm on all nodes
- Workers - Unlike swarm managers, workers are just there to provide capacity, they cannot control other nodes
- Stack - A group of interrelated services that share dependencies, and can be scaled and orchestrated together

## Files

- Dockerfile - Defines the environment inside your container
- docker-compose.yml - Defines how containers should behave in production
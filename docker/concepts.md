# Concepts

The Docker setup looks like the following: Stack -> Services -> Containers

## Meta

- Image - executable package with the the code, a runtime, libraries, environment variables, and configuration files
- Container - A runtime instance of an image
- Working directory - When a process refers to a file, the working directory is the top of the hierarchy for where it searches for the file
- Services - The different pieces of the app (storing data to database, video encoder, etc)

## Files

- Dockerfile - Defines the environment inside your container
- docker-compose.yml - Defines how containers should behave in production
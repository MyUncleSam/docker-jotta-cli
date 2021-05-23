# Description
This is justa docker container with an installed jotta-cli program.

# Usage
To use this container it needs to be started. After that you can access it like the normal commandline tool. But keep in mind that you need to link all volumes you want to backup or restore. Below are some examples of usage.

## Start the docker container
First of all you need to start the docker container. I highly suggest to use the `docker-compose.yml`.
All commands below need a running container.

## View all commands
`docker exec -it docker-jotta-cli jotta-cli help`

##  Login
You need to login before you can start. The command tells you everything you need to know:
`docker exec -it docker-jotta-cli jotta-cli login`

## Add folder to backup
`docker exec -it docker-jotta-cli jotta-cli add /home`
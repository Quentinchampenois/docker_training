# Install Discourse using Docker

These steps for running a containerized discourse application are extracted from https://rendezvous.alpha.liiib.re/playback/presentation/2.0/playback.html?meetingId=f621b5239d221e578332c34d904600664135d6cb-1595490782964. 

Furthermore, this is a correction this exercice : https://github.com/pierreozoux/docker-training/tree/master/exercises/networks

## Create a docker network

```
docker network create <NETWORK_NAME>
```

This network can be inspected with 

```
docker network inspect <NETWORK_NAME>
```

## Create Redis container attached to network

Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker. (https://redis.io/)

```
docker run --network <NETWORK_NAME> --name <CONTAINER_NAME> -d redis
```

Arguments : 
* `network` : allows to specify a network, enable communication between containers inside an isolated scope
* `name` : allows to specify a name to the running container. Container Name is visible with `docker ps -a`
* `d` : Short format parameter to detach the container, it allows to run the process in background (and not locking the current shell)

## Create Postgres container attached to network

PostgreSQL is a powerful, open source object-relational database. (https://www.postgresql.org/)

```
docker run --name <CONTAINER_NAME> --network <NETWORK_NAME> -e POSTGRES_USER=discourse -e POSTGRES_DB=discourse -e POSTGRES_PASSWORD=discourse -d postgres:13-alpine
```

Arguments : 
* `network` : allows to specify a network, enable communication between containers inside an isolated scope
* `name` : allows to specify a name to the running container. Container Name is visible with `docker ps -a`
* `d` : Short format parameter to detach the container, it allows to run the process in background (and not locking the current shell)
* `e` : Allows to set an environment variable for the docker container


## Run an interactive discourse container

Discourse is the 100% open source discussion platform built for the next decade of the Internet. Use it as a: mailing list, discussion forum, long-form chat room (https://www.discourse.org/)

```
docker run -it --name <CONTAINER_NAME> --network <NETWORK_NAME> -p 80:5000 libresh/discourse:v2.5.0 bash
```

Arguments : 
* `network` : allows to specify a network, enable communication between containers inside an isolated scope
* `name` : allows to specify a name to the running container. Container Name is visible with `docker ps -a`
* `p` : Short format parameter to access app inside the container from host. `80:3000` value means the application running inside the container and running on port `3000` is reachable on the host directly on the `80` port.
* `i` : Keep the process on your shell session
* `t` : Allocate a pseudo-TTY

### Inside the discourse container

After the previous command, you should be inside the discourse container. You can check it looking at the command line prompt that should look like :

`<container_name>@<hash>:~/discourse$` 

When you are inside your container

Exports the env variable needed

```
export POSTGRES_USER=discourse 
export DISCOURSE_DB_PASSWORD=discourse
```
 
precompile the assets

```
bundle exec rake db:migrate
bundle exec rake assets:precompile
```

And then run the server

```
bundle exec rails server -b 0.0.0.0 -p 5000
```

use `exit` command for leaving interactive mode
## Tips

Give a name to container is very usefull to manage easily containers.

## Errors encountered

On running discourse container, an error occured : 

(find the stack trace)

Solution:
Rename containers respectively from random names to `redis`, `postgres`

## Pull Docker image from Docker Hub
```sh
docker pull image-name
```

## Push Docker image to Docker Hub
```sh
docker push image-name:tag
```

## Tag Docker image
```sh
docker tag image-name:tag repository-path
```


## Show all images
```sh
docker images
```


## Delete a docker image
### To delete an image, delete the container from the image first
```sh
docker rmi image-id
```


## List all containers
```sh
docker ps

# List all containers wheather it is running or stoped
docker ps -a
```


## Start and Stop container
```sh
docker start container-id
docker stop container-id
```


## Delete a docker container
### To delete a docker container, stop the container first
```sh
docker rm container-id
```


## Run container
### bind port 6379 from container to host port 6000
```sh
docker run -p 6000:6379 redis
```
### Run container in a new name
```sh
docker run -d -p 6000:6379 ==name new-container-name redis
```

### Run container in detach mode then you can use the terminal again
```sh
docker run -d redis
```
```sh
docker run -d image-name:1.0
```


## Debug
```sh
docker logs container-id
docker logs container-name
```

### Docker interactive terminal
#### Sometime if /bin/bash does not work, try use /bin/sh instead
```sh
# Use container ID
docker exec -it container-id /bin/bash
docker exec -it a18464acf4b2 /bin/sh

# Use container name
docker exec -it new-container-name /bin/bash
```


## Docker Network
```sh
docker network ls
docker network create mongo-network
```
### 
```sh
docker run -p 27017:27017 -d mongo
```


## Docker Run
```sh
docker run -d --name my-mongo 
```



## Setup Web application with MongoDB
```sh
docker pull mongo
docker pull mongo-express
docker images

```
```sh
docker run -d --network mongo-network --name my-mongo \
    -e MONGO_INITDB_ROOT_USERNAME=mongoadmin \
    -e MONGO_INITDB_ROOT_PASSWORD=secret \
    mongo
```
```sh
docker run -it --rm \
    --network mongo-network \
    --name mongo-express \
    -p 8081:8081 \
    -e ME_CONFIG_OPTIONS_EDITORTHEME="ambiance" \
    -e ME_CONFIG_MONGODB_SERVER="my-mongo" \
    -e ME_CONFIG_MONGODB_ADMINUSERNAME=mongoadmin \
    -e ME_CONFIG_MONGODB_ADMINPASSWORD=secret \
    mongo-express
```


## Docker Compose
### Start all containers in the yaml files
```sh
docker-compose -f docker-compose.yaml up
```
### shut down all containers in the yaml files
```sh
docker-compose -f docker-compose.yaml down
```


## Build Docker Image
### Host Voulumes
```sh
doscker build -t image-name:1.0 .
```


## Docker Volumnes
### Start all containers in the yaml files
#### Default Location
#### Windows: c:\ProgramData\docker\volumes
#### Linux: /var/lib/docker/volumes
#### Mac: /var/lib/docker/volumes
```sh
doscker run -v /home/mmount/doat:/var/lib/mysql/data
```
### Anonymous volumes
```sh
doscker run -v /var/lib/mysql/data
```
### Named volumes
```sh
doscker run -v name:/var/lib/mysql/data
```





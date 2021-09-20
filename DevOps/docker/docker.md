## Pull Docker image from Docker Hub
```batch
docker pull image-name
```

## Push Docker image to Docker Hub
```batch
docker push image-name:tag
```

## Tag Docker image
```batch
docker tag image-name:tag repository-path
```


## Show all images
```batch
docker images
```


## Delete a docker image
### To delete an image, delete the container from the image first
```batch
docker rmi image-id
```


## List all containers
```docker
docker ps
docker ps -a
```


## Start and Stop container
```batch
docker start container-id
docker stop container-id
```


## Delete a docker container
### To delete a docker container, stop the container first
```batch
docker rm container-id
```


## Run container
### bind port 6379 from container to host port 6000
```batch
docker run -p6000:6379 redis
```
### Run container in a new name
```batch
docker run -d -p6000:6379 ==name new-container-name redis
```

### Run container in detach mode then you can use the terminal again
```batch
docker run -d redis
```
```batch
docker run -d image-name:1.0
```


## Debug
```batch
docker logs container-id
docker logs container-name
```
### Docker interactive terminal
#### Sometime if /bin/bash does not work, try use /bin/sh instead
```batch
docker exec -it container-id /bin/bash
docker exec -it a18464acf4b2 /bin/sh
docker exec -it new-container-name /bin/bash
```


## DOcker Network
```batch
docker network ls
docker network create mongo-network
```
### 
```batch
docker run -p 27017:27017 -d mongo
```


## Setup Web application with MongoDB
```batch
docker pull mongo
docker pull mongo-express
docker images

```
```
docker run -d --network mongo-network --name my-mongo \
    -e MONGO_INITDB_ROOT_USERNAME=mongoadmin \
    -e MONGO_INITDB_ROOT_PASSWORD=secret \
    mongo
```
```
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
```batch
docker-compose -f docker-compose.yaml up
```
### shut down all containers in the yaml files
```batch
docker-compose -f docker-compose.yaml down
```


## Build Docker Image
### Host Voulumes
```batch
doscker build -t image-name:1.0 .
```


## Docker Volumnes
### Start all containers in the yaml files
#### Default Location
#### Windows: c:\ProgramData\docker\volumes
#### Linux: /var/lib/docker/volumes
#### Mac: /var/lib/docker/volumes
```batch
doscker run -v /home/mmount/doat:/var/lib/mysql/data
```
### Anonymous volumes
```batch
doscker run -v /var/lib/mysql/data
```
### Named volumes
```batch
doscker run -v name:/var/lib/mysql/data
```





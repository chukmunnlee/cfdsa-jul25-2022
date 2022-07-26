#!/bin/env bash

# Create the network
echo "Creating network"
docker network create mynet

# Create the volume
echo "Creating nwdb-vol"
docker volume create nwdb-vol

# Run the northwind-db container, mount myvol to /var/lib/mysql
echo "Creating northwind-db"
docker run -d \
	--name nwdb \
	--network mynet \
	-v nwdb-vol:/var/lib/mysql \
	stackupiss/northwind-db:v1

# Pause to allow database to be ready
echo "Pause for 15 sec"
sleep 15

# Run the northwind-app 
echo "Creating northwind-app"
docker run -d \
	-p 8080:3000 \
	--name nwapp \
	--network mynet \
	-e DB_HOST=nwdb \
	-e DB_USER=root \
	-e DB_PASSWORD=changeit \
	stackupiss/northwind-app:v1

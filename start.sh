#!/bin/bash

echo "Stopping Running Container: "
docker stop $(docker ps | grep eureka-client | awk '{print $1}')
echo "Deleting Existing Container: "
docker rm $(docker ps -a | grep eureka-client | awk '{print $1}')

mvn clean install -DskipTests
mkdir -p target/dependency
cd target/dependency && jar -xf ../*.jar && cd -

TIMESTAMP=$(date +"%Y%m%d%H%M%S")
echo "Tagging Old Binary with: $TIMESTAMP"

docker tag eureka-client:latest eureka-client:$TIMESTAMP
docker build -t eureka-client:latest .

#docker run --name eureka-client -p 8080:8080 -e DB_HOST=postgres --network database -d eureka-client
docker run --name eureka-client-1 --network=host -d eureka-client
docker run --name eureka-client-2 --network=host -d eureka-client
docker run --name eureka-client-3 --network=host -d eureka-client
#!/bin/bash

echo "Stopping Running Container: $(docker stop eureka-client)"
echo "Deleting Existing Container: $(docker rm eureka-client)"

mvn clean install -DskipTests
mkdir -p target/dependency
cd target/dependency && jar -xf ../*.jar && cd -

TIMESTAMP=$(date +"%Y%m%d%H%M%S")
echo "Tagging Old Binary with: $TIMESTAMP"

docker tag eureka-client:latest eureka-client:$TIMESTAMP
docker build -t eureka-client:latest .

#docker run --name eureka-client -p 8080:8080 -e DB_HOST=postgres --network database -d eureka-client
docker run --name eureka-client --network=host -d eureka-client
##!/bin/bash
#
#echo "Stopping Running Container: "
#docker stop $(docker ps -a | grep eureka-client | awk '{print $1}')
#echo "Deleting Existing Container: "
#docker rm $(docker ps -a | grep eureka-client | awk '{print $1}')
#
#mvn clean install -DskipTests
#mkdir -p target/dependency
#cd target/dependency && jar -xf ../*.jar && cd -
#
#TIMESTAMP=$(date +"%Y%m%d%H%M%S")
#echo "Tagging Old Binary with: $TIMESTAMP"
#
#docker tag eureka-client:latest eureka-client:$TIMESTAMP
#docker build -t eureka-client:latest .
#
##docker run --name eureka-client -p 8080:8080 -e DB_HOST=postgres --network database -d eureka-client
#docker run --name eureka-client-1 --network=host -d eureka-client
#docker run --name eureka-client-2 --network=host -d eureka-client
#docker run --name eureka-client-3 --network=host -d eureka-client


#!/bin/bash

# Connect to Minikube's Docker daemon
eval $(minikube -p minikube docker-env)

echo "Stopping Running Container: $(docker stop eureka-client 2>/dev/null || true)"
echo "Deleting Existing Container: $(docker rm eureka-client 2>/dev/null || true)"

# Build the application
mvn clean install -DskipTests
mkdir -p target/dependency
cd target/dependency && jar -xf ../*.jar && cd -

# Tag and build Docker image
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
echo "Tagging Old Binary with: $TIMESTAMP"

docker tag eureka-client:latest eureka-client:$TIMESTAMP 2>/dev/null || true
docker build -t eureka-client:latest .

# Apply k8s config and force restart
kubectl apply -f ./k8s.yml
kubectl rollout restart deployment eureka-client
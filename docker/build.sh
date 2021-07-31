#!/bin/bash

if [[ -z $1 ]]
then
    echo "You must provide a version tag!"
    exit 1
else
    export VERSION=$1
fi

docker build -t markjonestx/pypwa:$VERSION-min -f Dockerfile.minimal .
docker build -t markjonestx/pypwa:$VERSION-cuda -f Dockerfile.cuda .
docker build -t markjonestx/pypwa:$VERSION-all -f Dockerfile.complete .

docker build -t markjonestx/pypwa:latest-min -f Dockerfile.minimal .
docker build -t markjonestx/pypwa:latest-cuda -f Dockerfile.cuda .
docker build -t markjonestx/pypwa:latest-all -f Dockerfile.complete .


# Push the new versions of the containers
if [[ -n $2 ]]
then
    docker push markjonestx/pypwa:$VERSION-min
    docker push markjonestx/pypwa:$VERSION-cuda
    docker push markjonestx/pypwa:$VERSION-all
    docker push markjonestx/pypwa:latest-min
    docker push markjonestx/pypwa:latest-cuda
    docker push markjonestx/pypwa:latest-all
fi

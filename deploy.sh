#!/bin/bash

TAG=$(git log -1 --pretty=%H)

APP_REPOSITORY=rnzdocker1/docker-cpu-runner

docker build --tag $APP_REPOSITORY:$TAG .

docker push $APP_REPOSITORY:$TAG



#!/usr/bin/env bash
#env DOCKER_BUILDKIT=1 docker build --no-cache -t mc303/hass-node-red .
#env DOCKER_BUILDKIT=1 
#create platform buildx env

CONTAINER_NAME="mc303/caddy-transip"
BUILD_PLATFORM="linux/amd64,linux/arm/v7,linux/arm64"
BUILD_NAME="build-caddy-transip"

docker buildx create --platform $BUILD_PLATFORM --name $BUILD_NAME
docker buildx use $BUILD_NAME

# build platforms
docker buildx build --platform=$BUILD_PLATFORM  -t $CONTAINER_NAME --push .

# remove build env
docker buildx rm $BUILD_NAME
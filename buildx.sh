#!/usr/bin/env bash

DOCKER_REPO="ghcr.io/mc303/caddy-transip:latest"
BUIILDX_REPO='build-caddy-transip'
BUILD_PLATFORM="linux/amd64,linux/arm/v7,linux/arm64"
DOCKER_USER_REPO=caddyserver/caddy
DOCKER_API_URL=https://api.github.com/repos/${DOCKER_USER_REPO}/releases/latest 

export CADDY_VERSION=$(curl --silent ${DOCKER_API_URL} | grep -Po '"tag_name": "\K.*\d')

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

#create multiplatform environment
docker buildx create --platform=${BUILD_PLATFORM} --name ${BUIILDX_REPO}
docker buildx use ${BUIILDX_REPO}

#build multiplatform docker image
docker buildx build --platform=${BUILD_PLATFORM} -t ${DOCKER_REPO} --push . --build-arg CADDY_VERSION

#remove multiplatform environment
docker buildx rm ${BUIILDX_REPO}
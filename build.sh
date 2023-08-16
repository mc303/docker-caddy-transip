#!/usr/bin/env bash
#env DOCKER_BUILDKIT=1 docker build --no-cache -t mc303/hass-node-red .
#env DOCKER_BUILDKIT=1 

#create platform buildx env
DOCKER_USER_REPO=caddyserver/caddy
DOCKER_API_URL=https://api.github.com/repos/${DOCKER_USER_REPO}/releases/latest 
CADDY_VERSION=$(curl --silent ${DOCKER_API_URL} | grep -Po '"tag_name": "\K.*\d')
CONTAINER_NAME="ghcr.io/mc303/caddy-transip:latest"
CONTAINER_NAME_TAG_VERSION="ghcr.io/mc303/caddy-transip:${CADDY_VERSION:1}"

docker build --no-cache --tag ${CONTAINER_NAME} --tag ${CONTAINER_NAME_TAG_VERSION} --push . --build-arg CADDY_VERSION=${CADDY_VERSION:1}

##  --rm 	true 	Remove intermediate containers after a successful build
## --tag , -t 		Name and optionally a tag in the name:tag format
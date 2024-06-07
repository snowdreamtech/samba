#!/bin/sh

DOCKER_HUB_PROJECT=snowdreamtech/samba

GITHUB_PROJECT=ghcr.io/snowdreamtech/samba

docker buildx build --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
-t ${DOCKER_HUB_PROJECT}:latest \
-t ${DOCKER_HUB_PROJECT}:4.19.6-r0 \
-t ${DOCKER_HUB_PROJECT}:4.19.6 \
-t ${DOCKER_HUB_PROJECT}:4.19 \
-t ${DOCKER_HUB_PROJECT}:4.19 \
-t ${GITHUB_PROJECT}:latest \
-t ${GITHUB_PROJECT}:4.19.6-r0 \
-t ${GITHUB_PROJECT}:4.19.6 \
-t ${GITHUB_PROJECT}:4.19 \
-t ${GITHUB_PROJECT}:4.19 \
. \
--push

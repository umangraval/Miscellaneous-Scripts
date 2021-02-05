#!/bin/bash

docker run --rm -it \
    -c 4 \
    -m 4096M \
    -v /etc/localtime:/etc/localtime:ro \
    -v /dev/shm:/dev/shm \
    -v "$(pwd):/data" \
    --name ftkimager \
    "${REGISTRY}/${user}/${repo}:${tag}" "${@}"

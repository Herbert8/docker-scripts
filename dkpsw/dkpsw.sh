#!/usr/bin/env bash

REAL_SCRIPT_FILE=$(realpath "${BASH_SOURCE[0]}")
BASE_DIR=$(cd "$(dirname "$REAL_SCRIPT_FILE")" && pwd)
readonly BASE_DIR

if ! CONTAINER_INFO_LIST=$(docker inspect $(docker ps -qa | sort -u)); then
    echo >&2 'Get containers info error!'
    exit 1
fi

if ! VIEWER_TEMPLATE=$(<"$BASE_DIR/container-viewer.template"); then
    echo >&2 'Get viewer error!'
    exit 1
fi

VIEWER_HTML=${VIEWER_TEMPLATE/__DOCKER_CONTAINER_INSPECT_PLACEHOLDER__/$CONTAINER_INFO_LIST}

VIEW_FILE=$(gmktemp --suffix=.html)

echo "$VIEWER_HTML" >"$VIEW_FILE"

open "$VIEW_FILE"

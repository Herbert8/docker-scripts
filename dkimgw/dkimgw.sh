#!/usr/bin/env bash

BASE_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
readonly BASE_DIR

if ! IMG_INFO_LIST=$(docker inspect $(docker images -qa | sort -u)); then
    echo >&2 'Get images info error!'
    exit 1
fi

if ! VIEWER_TEMPLATE=$(<"$BASE_DIR/img-viewer.template"); then
    echo >&2 'Get viewer error!'
    exit 1
fi

VIEWER_HTML=${VIEWER_TEMPLATE/__DOCKER_INSPECT_JSON_PLACEHOLDER__/$IMG_INFO_LIST}

VIEW_FILE=$(gmktemp --suffix=.html)

echo "$VIEWER_HTML" >"$VIEW_FILE"

open "$VIEW_FILE"

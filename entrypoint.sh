#!/bin/bash

set -e 

LOCALPORT=$1
REMOTEHOSTPORT=$2

if [[ -z "$LOCALPORT" || -z "$REMOTEHOSTPORT" ]]; then
    echo "You must specify two parameters: <localport> <remotehost:port>"
    exit 1
fi

echo "Setting up port forwarding for localhost:$1 -> $2"

CMD="socat tcp-listen:$LOCALPORT,reuseaddr,fork tcp:$REMOTEHOSTPORT"

exec $CMD

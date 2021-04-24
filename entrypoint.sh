#!/bin/bash
set -euo pipefail

LOCALPORT=${1:-""}
REMOTEHOSTPORT=${2:-""}
SSL=${3:-""}
PROTOCOL="tcp"

if [[ -z ${LOCALPORT} || -z ${REMOTEHOSTPORT} ]]; then
    echo "You must specify two parameters: <localport> <remotehost:port> [stunnel]"
    exit 1
fi

echo -n "Setting up port forwarding for localhost:${LOCALPORT} -> ${REMOTEHOSTPORT}"

if [[ ${SSL} == "stunnel" ]]; then
    echo " using an SSL tunnel"
    PROTOCOL="openssl-connect"
else
    echo
fi

CMD="socat tcp-listen:$LOCALPORT,reuseaddr,fork ${PROTOCOL}:${REMOTEHOSTPORT}"

exec "${CMD}"

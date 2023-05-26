#!/bin/bash

set -e
export LND_HOST='lnd.embassy'
export LND_PATH="/mnt/lnd/admin.macaroon"
export LND_CERT="/mnt/lnd/tls.cert"
export TOR_ADDRESS=$(yq e '.tor-address' /app/data/start9/config.yaml)
export LAN_ADDRESS=$(yq e '.lan-address' /app/data/start9/config.yaml)
export FILE="/app/.env"
sed -i 's|CERT=.*|CERT="'$LND_CERT'"|' /app/.env
sed -i 's|MACAROON=.*|MACAROON='$LND_PATH'|' /app/.env
sed -i 's|LND_HOST=.*|LND_HOST='$LND_HOST'|' /app/.env
if [ -f $FILE ] ; then {
    echo '.env file exists'
} else {
    echo '.env file does not exist'
} 
fi
if ! [ -f $LND_PATH ] && ! [ -d $CLN_PATH ]; then
    echo "ERROR: A Lightning Node must be running on your Embassy in order to use Last Pay Wins."
    exit 1
fi

echo "Starting Game..."

exec tini -p SIGTERM -- npm run dev

#!/bin/bash

set -eu -o pipefail

MACAROON="/home/lnd/.lnd/data/chain/bitcoin/regtest/admin.macaroon"
TLS_CERT="/home/lnd/.lnd/tls.cert"
DEST_DIR="/home/lnd/share/."

for i in $(seq 1 10); do
  if [ -f ${MACAROON} ]; then
    cp -p ${MACAROON} ${DEST_DIR}
    cp -p ${TLS_CERT} ${DEST_DIR}
    exit
  fi
  sleep 1; echo -n "."
done
echo "timeout error"

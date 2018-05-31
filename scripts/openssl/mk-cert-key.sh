#!/bin/bash

set -e

if [ $# -lt 1 ]; then
    echo "Usage: $0 <CN>"
    exit 1
fi

CN=$1

CA_CERT=$(dirname $0)/../../data/ca/ca.cclin/ca.cert.pem
CA_KEY=$(dirname $0)/../../data/ca/ca.cclin/ca.key.pem

C=TW
ST=Taiwan
L=Taipei
O=cclin
OU=cclin
CN=$CN
emailAddress=no-reply@CN

OUTPUT_DIR=$(dirname $0)/../../data/certs-signed-by-ca.cclin/$CN
OUTPUT_EXT=$OUTPUT_DIR/$CN.ext
OUTPUT_CSR=$OUTPUT_DIR/$CN.csr
OUTPUT_KEY=$OUTPUT_DIR/$CN.key.pem
OUTPUT_CERT=$OUTPUT_DIR/$CN.cert.pem

[-d $OUTPUT_DIR ] || mkdir $OUTPUT_DIR
touch $OUTPUT_EXT
touch $OUTPUT_CSR
touch $OUTPUT_KEY
touch $OUTPUT_CERT

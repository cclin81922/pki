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
emailAddress=no-reply@$CN
subj="/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=$CN/emailAddress=$emailAddress"

OUTPUT_DIR=$(dirname $0)/../../data/certs-signed-by-ca.cclin/$CN
OUTPUT_EXT=$OUTPUT_DIR/$CN.ext
OUTPUT_CSR=$OUTPUT_DIR/$CN.csr
OUTPUT_KEY=$OUTPUT_DIR/$CN.key.pem
OUTPUT_CERT=$OUTPUT_DIR/$CN.cert.pem

[ -d $OUTPUT_DIR ] || mkdir $OUTPUT_DIR
echo subjectAltName = IP.1:127.0.0.1,DNS.1:$CN > $OUTPUT_EXT
openssl req -new -sha256 -keyout $OUTPUT_KEY -out $OUTPUT_CSR -days 365 -newkey rsa:2048 -nodes -subj "$subj"

if [ -f .srl ]; then
    openssl x509 -req -days 365 -sha256 -CAserial .srl -CA $CA_CERT -CAkey $CA_KEY -in $OUTPUT_CSR -extfile $OUTPUT_EXT -out $OUTPUT_CERT
else
    openssl x509 -req -days 365 -sha256 -CAcreateserial -CA $CA_CERT -CAkey $CA_KEY -in $OUTPUT_CSR -extfile $OUTPUT_EXT -out $OUTPUT_CERT
fi

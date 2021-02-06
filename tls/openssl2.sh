#!/bin/bash

echo Generate CA key:
openssl genrsa -passout pass:123456 -out ca.key 2048

echo Generate CA certificate:
openssl req -passin pass:123456 -new -x509 -days 365 -key ca.key -out ca.crt -subj "/CN=192.168.125.125"

echo Generate server key:
openssl genrsa -passout pass:123456 -out server.key 2048

echo Generate server signing request:
openssl req -passin pass:123456 -new -key server.key -out server.csr -subj "/CN=192.168.125.125"

echo Self-sign server certificate:
openssl x509 -req -passin pass:123456 -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt

echo Remove passphrase from server key:
openssl rsa -passin pass:123456 -in server.key -out server.key

echo Generate client key
openssl genrsa -passout pass:123456 -out client.key 2048

echo Generate client signing request:
openssl req -passin pass:123456 -new -key client.key -out client.csr -subj "/CN=192.168.125.125"

echo Self-sign client certificate:
openssl x509 -passin pass:123456 -req -days 365 -in client.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out client.crt

echo Remove passphrase from client key:
openssl rsa -passin pass:123456 -in client.key -out client.key

openssl pkcs8 -topk8 -inform PEM -in server.key -outform pem -nocrypt -out server.pem
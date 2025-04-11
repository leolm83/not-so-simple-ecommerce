#!/bin/bash
password='@DevOpsNaNuvem$%!'
days=365
openssl genrsa \
    -des3 \
    -passout pass:$password \
    -out ../certificates/root-ca.key 4096 
## gerar certificado:
openssl req \
    -x509 \
    -new \
    -key ../certificates/root-ca.key \
    -passin pass:$password \
    -days $days \
    -sha256 \
    -out ../certificates/root-ca.crt \
    -subj '/CN=devopsnanuvem.internal'

## (CSR) Certificate Signing Request - Solicitacao de assinatura de certificado
openssl req \
    -new \
    -noenc \
    -newkey rsa:4096 \
    -keyout ../certificates/signing-request.key \
    -out ../certificates/signing-request.csr \
    -subj '/CN=devopsnanuvem.internal'

## CERTIFICADO PARA O NGINX
openssl x509 \
    -req \
    -in ../certificates/signing-request.csr \
    -CA ../certificates/root-ca.crt \
    -CAkey ../certificates/root-ca.key \
    -passin pass:$password \
    -sha256 \
    -CAcreateserial \
    -days $days \
    -out ../certificates/nginx-certificate.crt \
    -extfile ../certificates/config.ext

## CERTIFICADO PARA O KESTREL
openssl pkcs12 \
    -inkey ../certificates/signing-request.key \
    -in ../certificates/nginx-certificate.crt \
    -export \
    -out ../certificates/kestrel-certificate.pfx \
    -passout pass:$password

#!/bin/bash
#general vars
password='@DevOpsNaNuvem$%!'
days=365
keySize=4096

#rootCA vars
rootCAKey='../certificates/root-ca.key'
rootCACRT='../certificates/root-ca.crt'

#signingRequest vars
signingRequestKey='../certificates/signing-request.key'
signingRequestCSR='../certificates/signing-request.csr' 


extFile='../certificates/config.ext'
nginxCertificate='../certificates/nginx-certificate.crt'

kestrelCertificate='../certificates/kestrel-certificate.pfx'


function generateCACertificate(){
    feedbackMessage='Certificate Authority Certificate'
    

    if [ -f  $rootCAKey ]
    then
        echo "$feedbackMessage Already Exists! in $rootCAKey" 
    else
        echo "$feedbackMessage Don't Exists!" 
        echo "Generating CA certificate"
        openssl genrsa \
            -des3 \
            -passout pass:$password \
            -out $rootCAKey \
            $keySize 
    fi

    if [ -f $rootCAKey ] && [ ! -f $rootCACRT ]
    then
        echo "Generating Root CA Certificate"
        openssl req \
            -x509 \
            -new \
            -key $rootCAKey \
            -passin pass:$password \
            -days $days \
            -sha256 \
            -out $rootCACRT \
            -subj '/CN=devopsnanuvem.internal'
    else
        echo 'Root CA Certificate already exists or Root CA Key doesnt exists'
    fi
}

function generateCertificateSigningRequest(){

    if [ ! -f $signingRequestKey ] && [ ! -f $signingRequestCSR ]
    then
        echo 'Generating Signing Request Key and Signing Request CSR'
        openssl req \
        -new \
        -noenc \
        -newkey rsa:$keySize \
        -keyout $signingRequestKey \
        -out $signingRequestCSR \
        -subj '/CN=devopsnanuvem.internal'
    else
        echo 'Generating Signing Request Key or Signing Request CSR already exists'
    fi
}

function generateNginxCertificate(){
    if [ -f $extFile ] && [ -f $signingRequestCSR ] && [ -f $rootCACRT ] && [ -f $rootCAKey ] && [ ! -f $nginxCertificate ]
    then
        echo 'Generating Nginx x509 certificate'
        openssl x509 \
        -req \
        -in $signingRequestCSR \
        -CA $rootCACRT \
        -CAkey $rootCAKey \
        -passin pass:$password \
        -sha256 \
        -CAcreateserial \
        -days $days \
        -out $nginxCertificate \
        -extfile $extFile
    else
        echo 'Some of the needed files doesnot exist or the Nginx Cert already exists'
    fi
}

function generateKestrelCertificate(){
   
    if [ -f $signingRequestKey ] && [ -f $nginxCertificate ] && [ ! -f $kestrelCertificate ]
    then 
        openssl pkcs12 \
        -inkey $signingRequestKey \
        -in $nginxCertificate \
        -export \
        -out $kestrelCertificate \
        -passout pass:$password
    else
        echo 'Algum dos arquivos necessarios nao existe ou o cerfiticado do Kestrel ja foi gerado anteriormente'
    fi
}

generateCACertificate;
## (CSR) Certificate Signing Request - Solicitacao de assinatura de certificado
generateCertificateSigningRequest;
## CERTIFICADO PARA O NGINX
generateNginxCertificate;

generateKestrelCertificate;


## CERTIFICADO PARA O KESTREL


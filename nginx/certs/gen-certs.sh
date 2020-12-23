#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "É preciso informar o nome do domínio."
    echo "Exemplo: ./gen-certs.sh meudominio.com"
    exit;
fi

DOMINIO=$1

openssl req -x509 -out /etc/ssl/certs/$DOMINIO.crt -keyout /etc/ssl/certs/$DOMINIO.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=$DOMINIO' -extensions EXT -config <( \
   printf "[dn]\nCN=$DOMINIO\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:$DOMINIO\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")






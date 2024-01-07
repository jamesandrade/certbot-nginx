#!/bin/bash
if [ -f .env ]; then
    set -a
    . ./.env
    set +a
    echo "Rotina para renovar o certificado iniciada"
    docker compose run --rm certbot renew
    echo "Aguardando 10 segundos"
    sleep 10
    echo "Copiando certificados"
    cp -L certbot/conf/live/${APPLICATION_DOMAIN}/* nginx/certificates
    docker compose restart nginx
fi
#!/bin/bash

if [ -f .env ]; then
    echo "Criando pastas"
    mkdir -p nginx/conf
    set -a
    . ./.env
    set +a
    #mkdir -p certbot/conf/live/${APPLICATION_DOMAIN}
    echo "Criando config. nginx"
    printf "server {
    listen 80;
    listen [::]:80;

    server_name ${APPLICATION_DOMAIN} www.${APPLICATION_DOMAIN};
    server_tokens off;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        return 301 https://${APPLICATION_DOMAIN}$request_uri;
    }
}" > "nginx/conf/app.conf"
    echo "Iniciando containers"
    docker compose up -d
    echo "Aguardando 10 segundos"
    sleep 10

    echo "Iniciando Primeira config. certbot"
    docker compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot/ --dry-run -d ${APPLICATION_DOMAIN} --email ${APPLICATION_MAIL} --agree-tos --non-interactive
    echo "Iniciando Segunda config. certbot"
    docker compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot/ -d ${APPLICATION_DOMAIN} --email ${APPLICATION_MAIL} --agree-tos --non-interactive
    echo "Down nginx"
    docker compose down nginx
    echo "Reescrevendo config. nginx para https"
    printf "server {
    listen 443 ssl;
    server_name ${APPLICATION_DOMAIN};
    ssl_certificate /etc/nginx/certificates/fullchain1.pem;
    ssl_certificate_key /etc/nginx/certificates/privkey1.pem;
    location / {
        proxy_pass ${APPLICATION_REDIRECT};
    }
}" > "nginx/conf/app.conf"
    echo "Aguardando 10 segundos"
    sleep 10
    echo "Iniciando nginx com as novas configs"
    docker compose up nginx -d
    echo "adicionando cron para atualizar o certificado"
    cat <(crontab -l) <(echo "0 0 1 * * docker run --rm certbot renew && docker restart nginx") | crontab -
    echo "Finalizado!"
fi

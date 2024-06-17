#!/usr/bin/env bash
apt update -y && apt upgrade -y
apt install -y curl apache2
a2enconf php8.2-fpm && a2enmod proxy_fcgi setenvif
systemctl restart apache2
adduser -aG www-data grough
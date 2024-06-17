#!/usr/bin/env bash

apt update
apt install mariadb-server -y
systemctl start mariadb
systemctl enable mariadb


userlaravel="laravel"
passwdlaravel="Ouiouinonnon"

mysql <<EOF

CREATE DATABASE laravel;
CREATE USER '$userlaravel'@'localhost' IDENTIFIED BY '$passwdlaravel';
GRANT ALL PRIVILEGES ON laravel.* TO '$userlaravel'@'localhost';
FLUSH PRIVILEGES;


EOF
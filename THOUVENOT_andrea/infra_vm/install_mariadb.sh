#!/usr/bin/env bash

apt update
apt install mariadb-server -y
systemctl start mariadb
systemctl enable mariadb

user=andreaVM
pwd=1234
databaseName=databaseVm

# Création de la base de données
mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS $databaseName;
CREATE USER '^$user'@'localhost' IDENTIFIED BY '$pwd';
GRANT ALL PRIVILEGES ON $databaseName.* TO '^$user'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Création de la table dans la base de données
mysql -u ^$user -p$pwd $databaseName <<MYSQL_SCRIPT
CREATE TABLE IF NOT EXISTS person (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50),
    age INT
);
INSERT INTO person (nom, age) VALUES ('Andrea', 23);
MYSQL_SCRIPT

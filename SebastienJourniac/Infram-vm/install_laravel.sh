#!/usr/bin/env bash

apt update -y && apt upgrade -y
apt-get install apt-transport-https gnupg2 ca-certificates -y
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
cd /var/www/html || exit
composer create-project --prefer-dist laravel/laravel laravel
chown -R www-data:www-data /var/www/html/laravel
chmod -R 775 /var/www/html/laravel
chown -R www-data:www-data /var/www/html/laravel/storage
chown -R www-data:www-data /var/www/html/laravel/bootstrap/cache
chmod -R 775 /var/www/html/laravel/storage
chmod -R 775 /var/www/html/laravel/bootstrap/cache

CONF_FILE="/etc/apache2/sites-available/laravel.conf"
CONF_CONTENT="<VirtualHost *:80>
    ServerName laravel2.example.com

    ServerAdmin admin@example.com
    DocumentRoot /var/www/html/laravel/public

    <Directory /var/www/html/laravel>
    Options Indexes MultiViews
    AllowOverride None
    Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>"
echo "$CONF_CONTENT" > "$CONF_FILE"
a2enmod rewrite
a2ensite laravel.conf
systemctl reload apache2


ENV_FILE="/var/www/html/laravel/.env"
DB_CONNECTION="mysql"
DB_DATABASE="laravel"
DB_PASSWORD="Ouiouinonnon"
DB_USERNAME="laravel"

update_env() {
  local var_name=$1
  local new_value=$2

  if grep -q "^${var_name}=" "$ENV_FILE"; then
    sed -i "s/^${var_name}=.*/${var_name}=${new_value}/" "$ENV_FILE"
  else
    echo "${var_name}=${new_value}" >> "$ENV_FILE"
  fi
}
cd /var/www/html/laravel || exit
chmod +x artisan

update_env "DB_CONNECTION" "$DB_CONNECTION"
update_env "DB_HOST" "localhost"
update_env "DB_PORT" "3306"
update_env "DB_DATABASE" "$DB_DATABASE"
update_env "DB_USERNAME" "$DB_USERNAME"
update_env "DB_PASSWORD" "$DB_PASSWORD"
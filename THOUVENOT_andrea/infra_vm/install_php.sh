#!/usr/bin/env bash

apt-get update -y
apt-get install php8.2-fpm -y
a2enmod proxy_fcgi setenvif
a2enconf php8.2-fpm
systemctl reload apache2
rm /var/www/html/index.html
cat > /var/www/html/index.php <<-EOF
<?php
        phpinfo();
?>
EOF
systemctl restart apache2
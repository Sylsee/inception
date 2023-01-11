#!/bin/bash

# Download WordPress and extract it
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz -C /var/www/html/
rm latest.tar.gz
chown -R wordpress:wordpress /var/www/html/wordpress

# Generate a WordPress configuration file
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
sed -i "s/database_name_here/$DB_NAME/g" /var/www/html/wordpress/wp-config.php
sed -i "s/username_here/$DB_USER/g" /var/www/html/wordpress/wp-config.php
sed -i "s/password_here/$DB_PASSWORD/g" /var/www/html/wordpress/wp-config.php
sed -i "s/localhost/$DB_HOST/g" /var/www/html/wordpress/wp-config.php

exec "$@"
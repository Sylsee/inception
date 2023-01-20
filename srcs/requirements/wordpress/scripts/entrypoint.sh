#!/bin/bash

# Check if WordPress is already installed
if [ -f /var/www/html/wp-config.php ] ; then
	echo "WordPress is already installed"
else
	# Download WordPress and extract it
	wget https://wordpress.org/latest.tar.gz
	tar --strip-components 1 -xzf latest.tar.gz -C /var/www/html/
	rm latest.tar.gz
	chown -R www-data:www-data /var/www/html
fi

# Create directory for sock-file
mkdir -p /run/php/

# Generate a WordPress configuration file
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/$DB_NAME/g" /var/www/html/wp-config.php
sed -i "s/username_here/$DB_USER/g" /var/www/html/wp-config.php
sed -i "s/password_here/$DB_PASSWORD/g" /var/www/html/wp-config.php
sed -i "s/localhost/$DB_HOST/g" /var/www/html/wp-config.php

sed -i "s/listen = \/run\/php\/php7\.3-fpm\.sock/listen = 0.0.0.0:9000/g" /etc/php/7.3/fpm/pool.d/www.conf

exec "$@"
#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mysql_install_db
fi

# Start the mysql service
/etc/init.d/mysql start

if [ -d "/var/lib/mysql/${DB_NAME}" ]; then
	echo "Database already exists"
	echo ${DB_NAME}
	sleep 5
else

	# Create directory for sock-file
	mkdir -p /var/run/mysqld
	chown -R mysql:mysql /var/run/mysqld
	chmod 777 /var/run/mysqld

	# Secure mysql installation
	cat > mysql_secure_installation.sql << EOF
# Make sure that NOBODY can access the server without a password
UPDATE mysql.user SET Password=PASSWORD('$DB_ROOT') WHERE User='root';
# Kill the anonymous users
DELETE FROM mysql.user WHERE User='';
# Kill off the test database
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
# Make our changes take effect
FLUSH PRIVILEGES;
EOF
	mysql -sfu root < mysql_secure_installation.sql

	# Create the database
	cat > create_db.sql << EOF
# Create the database
CREATE DATABASE IF NOT EXISTS $DB_NAME DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
# Create the user
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
# Grant privileges to the user
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
# Make our changes take effect
FLUSH PRIVILEGES;
EOF
	mysql -sfu root < create_db.sql

	# Clean up
	rm -f create_db.sql mysql_secure_installation.sql
fi

/etc/init.d/mysql stop

exec "$@"
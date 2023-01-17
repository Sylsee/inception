#!/bin/bash

# Start the mysql service
service mysql start

if [ ! -d /var/lib/mysql/$DB_NAME ] ; then 

	# Create directory for sock-file
	mkdir -p /var/run/mysqld
	chown -R mysql:mysql /var/run/mysqld

	# Initialize the database
	mysql_install_db --user=mysql --datadir=/var/lib/mysql --rpm

	# Secure the mysql installation
	cat > mysql_secure_installation.sql << EOF
# Make sure that NOBODY can access the server without a password
UPDATE mysql.user SET Password=PASSWORD('$DB_ROOT') WHERE User='root';
# Kill the anonymous users
DELETE FROM mysql.user WHERE User='';
# Disallow remote login for root
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
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
CREATE DATABASE $DB_NAME DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
# Create the user
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
# Grant privileges to the user
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
# Make our changes take effect
FLUSH PRIVILEGES;
EOF
	mysql -sfu root < create_db.sql

	# Clean up
	rm -f mysql_secure_installation.sql create_db.sql
fi

# tail -f /dev/null

exec "$@"
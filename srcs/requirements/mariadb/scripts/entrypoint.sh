#!/bin/bash
set -e

# initialize the database if necessary
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql
    echo "Database initialized"
fi

exec "$@"
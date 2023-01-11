FROM debian:buster

# Install dependencies
RUN apt-get update && apt-get install -y \
	mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

# Copy database configuration file
COPY conf/my.cnf /etc/mysql/my.cnf

# Create a shell script to install and configure MariaDB
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306

# Start MariaDB
CMD ["mysqld"]

# Run the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
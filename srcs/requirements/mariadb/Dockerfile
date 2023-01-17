FROM debian:buster

ENV DB_NAME $DB_NAME
ENV DB_USER $DB_USER
ENV DB_PASSWORD $DB_PASSWORD
ENV DB_ROOT $DB_ROOT

# Install dependencies
RUN apt-get update && apt-get install -y \
	mariadb-server \
	# mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 3306

# Run shell script to configure MariaDB
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh \
	&& /entrypoint.sh

# Run the entrypoint script

USER mysql

# Start MariaDB
CMD ["mysqld", "--bind-address=0.0.0.0"]
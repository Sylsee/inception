FROM debian:buster

# Install dependencies
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Create ARG variables for database configuration
ARG DB_NAME \
    DB_USER \
    DB_PASSWORD \
    DB_ROOT

# Expose port 3306
EXPOSE 3306

# Run shell script to configure MariaDB
COPY scripts/entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh \
    && sh entrypoint.sh

# Switch to the mysql user
USER mysql

# Start MariaDB
CMD ["mysqld", "--bind-address=0.0.0.0"]
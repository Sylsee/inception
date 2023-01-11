FROM debian:buster

# Create environment variables
ENV DB_NAME $DB_NAME
ENV DB_USER $DB_USER
ENV DB_PASSWORD $DB_PASSWORD
ENV DB_HOST $DB_HOST

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    php \
    curl \
    mariadb-client \
    unzip \
    nginx \
    php-fpm \
    php-cli \
    php-json \
    php-pdo \
    php-mysql \
    php-zip \
    php-gd \
    php-mbstring \
    php-curl \
    php-xml \
    php-pear \
    php-bcmath \
    && rm -rf /var/lib/apt/lists/*

# Create a shell script to install and configure WordPress
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9000 3306

# Run the shell script when the container starts
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/php-fpm"]
FROM debian:buster

# Create ARG variables for WordPress configuration
ARG DB_NAME \
    DB_USER \
    DB_PASSWORD \
    DB_HOST \
    PHP_VERSION=7.3

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    php${PHP_VERSION} \
    curl \
    mariadb-client \
    unzip \
    nginx \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-cgi \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-pdo \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-bcmath \
    && rm -rf /var/lib/apt/lists/*

# Run shell script to install and configure WordPress
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh \
    && /entrypoint.sh

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]
FROM debian:buster

# Create environment variables
ENV DB_NAME $DB_NAME
ENV DB_USER $DB_USER
ENV DB_PASSWORD $DB_PASSWORD
ENV DB_HOST $DB_HOST

ARG PHP_VERSION=7.3

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

# Create a shell script to install and configure WordPress
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9000

# Run the shell script when the container starts
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/php-fpm7.3", "-F"]
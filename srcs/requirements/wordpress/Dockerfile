FROM debian:buster

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    php \
    php-fpm \
    php-mysql \
    && rm -rf /var/lib/apt/lists/*

# Create a shell script to install and configure WordPress
COPY conf/install-wp.sh /usr/local/bin/install-wp.sh
RUN chmod +x /usr/local/bin/install-wp.sh

EXPOSE 9000 3306

# Run the shell script when the container starts
ENTRYPOINT ["/usr/local/bin/install-wp.sh"]

CMD ["/usr/sbin/php-fpm"]
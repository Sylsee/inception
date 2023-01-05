FROM debian:buster

# Install dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Generate SSL certificates
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/key.pem -out /etc/ssl/certs/cert.pem -subj '/CN=localhost'

# Configure nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

# Run nginx
CMD ["nginx", "-g", "daemon off;"]
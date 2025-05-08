#!/bin/bash

# Create a directory for certbot challenge files
mkdir -p /var/www/certbot

# Stop nginx if it's running
systemctl stop nginx

# Request certificates for all domains
certbot certonly --standalone \
  -d gnarlybob.net -d www.gnarlybob.net \
  -d bitspace.org -d www.bitspace.org \
  -d bitspace.dev -d www.bitspace.dev \
  -d chriswoods.dev -d www.chriswoods.dev \
  --email admin@example.com \
  --agree-tos \
  --non-interactive \
  --expand

# Start nginx again
systemctl start nginx

# Set up automatic renewal
echo "0 3 * * * certbot renew --quiet --post-hook 'systemctl reload nginx'" | crontab -
FROM nginx:1.27-alpine AS base

# Install Certbot and Nginx plugin
RUN apk add --no-cache \
    certbot \
    certbot-nginx \
    py3-pip

FROM base AS builder

# Copy custom nginx configuration
COPY sites-available/default /etc/nginx/conf.d/default.conf
COPY conf.d/logging.conf /etc/nginx/conf.d/logging.conf

# Expose port 80 and 443
EXPOSE 80
EXPOSE 443

RUN mkdir -p /var/www/setoutpost.com/
RUN mkdir -p /var/www/setoutpost.com/.well-known/acme-challenge/

# Create the certbot directory
RUN mkdir -p /var/www/certbot
RUN mkdir -p /etc/letsencrypt/live/setoutpost.com

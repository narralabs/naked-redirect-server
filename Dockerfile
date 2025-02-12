FROM ubuntu/nginx:1.18-22.04_beta AS base

# Install Certbot and Nginx plugin
RUN apt-get update && apt-get install -y \
    certbot \
    python3-certbot-nginx \
    && rm -rf /var/lib/apt/lists/*

FROM base as builder

# Copy custom nginx configuration
COPY sites-available/default /etc/nginx/sites-available/default
COPY sites-available/setoutpost.com /etc/nginx/sites-available/setoutpost.com

# Expose port 80 and 443
EXPOSE 80
EXPOSE 443

RUN mkdir -p /var/www/setoutpost.com/
RUN mkdir -p /var/www/setoutpost.com/.well-known/acme-challenge/

# Create the certbot directory
RUN mkdir -p /var/www/certbot
RUN mkdir -p /etc/letsencrypt/live/setoutpost.com

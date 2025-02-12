FROM ubuntu/nginx:1.18-22.04_beta

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 and 443
EXPOSE 80
EXPOSE 443

# Install Certbot and Nginx plugin
RUN apt-get update && apt-get install -y \
    certbot \
    python3-certbot-nginx \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/setoutpost.com/
RUN mkdir -p /var/www/setoutpost.com/.well-known/acme-challenge/

# Create the certbot directory
RUN mkdir -p /var/www/certbot
RUN mkdir -p /etc/letsencrypt/live/setoutpost.com

# Start Nginx
# ENTRYPOINT ["nginx", "-g", "daemon off;"]

server {
    listen 80;
    server_name setoutpost.com;

    # Allow requests to .well-known without redirecting
    location /.well-known/ {
        root /var/www/setoutpost.com/.well-known;
    }

    # Redirect all other traffic to www.setoutpost.com
    location / {
        return 301 $scheme://www.setoutpost.com$request_uri;
    }
}

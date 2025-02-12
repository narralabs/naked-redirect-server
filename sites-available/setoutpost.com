server {
    listen 80;
    server_name setoutpost.com;

    location /up {
        add_header Content-Type text/html;
        return 200 "<html><body><h1>Success</h1><p>Server is up and running!</p></body></html>";
    }

    # Allow requests to .well-known without redirecting
    location /.well-known/ {
        root /var/www/setoutpost.com/.well-known;
    }

    # Redirect all other traffic to www.setoutpost.com
    location / {
        return 301 $scheme://www.setoutpost.com$request_uri;
    }
}

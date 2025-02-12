server {
    listen 80;
    listen 443 ssl;

    server_name setoutpost.com;

    # Redirect non-www to www
    location / {
        return 301 https://www.$host$request_uri;
    }
}

# naked-redirect-server

This is a simple nginx server that redirects all traffic from a naked/root domain to a www subdomain: `yourdomain.com` -> `www.yourdomain.com`. Born out of necessity after deploying a kamal application and it was not easy to redirect a naked domain to a www domain. With this server, you won't need to mess around with nginx configs and only needs the kamal deploy configuration to work! It also includes SSL and renewing it automatically using certbot through kamal-proxy.

Can be used to redirect multiple domains on a single server. You can have:

```
yourfirstdomain.com -> www.yourfirstdomain.com
yourseconddomain.com -> www.yourseconddomain.com
```

The redirect behaviour is as follows:

```
http://yourdomain.com -> https://yourdomain.com      <-- this redirect is done by kamal-proxy due to SSL true in config
https://yourdomain.com -> https://www.yourdomain.com <-- this redirect is done by our nginx server
```

## Requirements

- A server with a public IP.
- A Docker hub account.
- And [kamal](https://kamal-deploy.org/docs/installation/) for deployments.

## Getting Started

1. Create a server. In our case, we used a single server (Ubuntu) in Hetzner. Take note of the IP address.
2. Create docker hub repository. Name is `naked-redirect-server`.
3. Clone this repository: `git clone https://github.com/narralabs/naked-redirect-server.git`
4. Rename the `config/deploy.yml.example` file to `config/deploy.yml`
5. In `config/deploy.yml`, replace image with the docker hub repository name from `2.`
6. In `config/deploy.yml`, add the IP of the server you made in step `1.` to the servers `web` group.
7. In `config/deploy.yml`, add the domains you want to redirect to the proxy `hosts` array.
8. In `config/deploy.yml`, add your docker hub username to the registry `username` field.
9. Run `KAMAL_REGISTRY_PASSWORD=<your-docker-hub-password> kamal setup` to setup the server.
10. Add the IP of the server you made in step `1.` to the A record of your DNS provider (e.g. Hetzner DNS, GoDaddy, AWS Route 53, Cloudflare).
11. You should now be able to access your naked domain and it should redirect to the www subdomain.
12. You can test this using curl: `curl -I http://yourdomain.com`
```
HTTP/1.1 301 Moved Permanently
Server: nginx
Date: Thu, 13 Feb 2025 10:10:10 GMT
Content-Type: text/html
Content-Length: 168
Connection: keep-alive
Location: https://www.yourdomain.com/
```

## Testing Locally

The project is setup to run locally using docker compose.

1. Run `docker compose up` to start the server.
2. Run `curl -I http://localhost:8080` to test the server.

You should see the following output:

```
HTTP/1.1 301 Moved Permanently
Server: nginx
Date: Thu, 13 Feb 2025 10:10:10 GMT
Content-Type: text/html
Content-Length: 168
Connection: keep-alive
Location: https://www.localhost
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

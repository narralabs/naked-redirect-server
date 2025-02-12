# naked-redirect-server

This is a simple nginx server that redirects all traffic from a naked/root domain to a www subdomain: `yourdomain.com` -> `www.yourdomain.com`. Born out of necessity after deploying a kamal application and it was not easy to redirect a naked domain to a www domain. No messing around with nginx configs and only needs the kamal deploy configuration!

Can be used to redirect multiple domains on a single server. You can have:

```
yourfirstdomain.com -> www.yourfirstdomain.com
yourseconddomain.com -> www.yourseconddomain.com
```

Also, includes SSL automatically using certbot through kamal-proxy.

## Requirements

- A server with a public IP. In our case, we used a single server in Hetzner.
- A Docker hub account.
- And [kamal](https://kamal-deploy.org/docs/installation/) for deployments.

## Getting Started

1. Create a server. In our case, we used a single server (Ubuntu) in Hetzner. Take note of the IP address.
2. Clone the repository: `git clone https://github.com/narralabs/naked-redirect-server.git`
3. In `config/deploy.yml`, add the IP of the server you made in step `1.` to the `web` group.
4. In `config/deploy.yml`, add the domains you want to redirect to the `hosts` array.
5. Run `KAMAL_REGISTRY_PASSWORD=<your-docker-hub-password> kamal setup` to setup the server.
6. Add the IP of the server you made in step `1.` to the A record of your naked domain.
7. You will now be able to access your naked domain and it should redirect to the www subdomain.
8. You can test this using curl: `curl -I http://yourdomain.com`
```
HTTP/1.1 301 Moved Permanently
Server: nginx
Date: Thu, 13 Feb 2025 10:10:10 GMT
Content-Type: text/html
Content-Length: 168
Connection: keep-alive
Location: https://www.yourdomain.com/
```

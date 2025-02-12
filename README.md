# naked-redirect-server

This is a simple nginx server that redirects all traffic from a naked domain to a subdomain. Mostly
used for kamal applications but can be used for any other deployment.

## Getting Started

1. Fork the repository.
2. Clone the repository locally: `git clone https://github.com/your-username/naked-redirect-server.git`
3. Configure the A record of your domain to point to the instance's public IP.
3. Configure the A record of your domain to point to the instance's public IP.

## Hetzner Setup

1. Create a server in Hetzner.
2. Add the server to the `web` group in `config/deploy.yml`.
3. Run `kamal setup` to setup the server.
4. Run `kamal deploy` to deploy the application.

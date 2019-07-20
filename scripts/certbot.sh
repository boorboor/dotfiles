#!/usr/bin/env bash

# If ran with sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Add the repository
add-apt-repository -y ppa:certbot/certbot >/dev/null && echo 'certbot ppa added'

# Install Certbot's Nginx package
apt-get install -y -q python-certbot-nginx >/dev/null && echo 'python-certbot-nginx installed'

nginx -t
systemctl reload nginx
sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'

# certbot --nginx -d example.com -d www.example.com
# certbot renew --dry-run


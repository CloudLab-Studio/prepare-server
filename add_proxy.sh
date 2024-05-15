#!/bin/bash

# Prompt for domain name
read -p "Enter the domain name: " domain

# Prompt for the port to proxy
read -p "Enter the port to proxy: " port

# Prompt for the email address for SSL certificate
read -p "Enter your email address for SSL certificate: " email

# Generate Nginx configuration file
cat <<EOF > /etc/nginx/conf.d/${domain}.conf
server {
    listen 80;
    server_name ${domain};

    location / {
        proxy_pass http://localhost:${port};
        
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;

        gzip on;
        gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;
        gzip_min_length 1000;
        gzip_proxied expired no-cache no-store private auth;
        gzip_disable "MSIE [1-6]\.";
        gzip_vary on;

        client_max_body_size 100M;
        
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
EOF

# Restart Nginx
systemctl restart nginx

# Run Certbot to obtain SSL certificate
certbot certonly --nginx -d ${domain} --email ${email} --agree-tos --non-interactive --redirect

# Generate Docker container
docker run -d -p ${port}:80 --name ${domain} nginx

echo "Proxy setup complete!"
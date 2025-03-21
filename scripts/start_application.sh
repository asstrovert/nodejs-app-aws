#!/bin/bash
# Create or update the systemd service file
cat > /etc/systemd/system/nodejs-app.service << 'SERVICEEOF'
[Unit]
Description=Node.js Application
After=network.target

[Service]
Type=simple
User=ec2-user
WorkingDirectory=/opt/nodejs-app
ExecStart=/usr/bin/node /opt/nodejs-app/app.js
Restart=on-failure

[Install]
WantedBy=multi-user.target
SERVICEEOF

# Enable and start the service
systemctl daemon-reload
systemctl enable nodejs-app
systemctl start nodejs-app

# Configure nginx if installed
if command -v nginx &> /dev/null; then
  cat > /etc/nginx/conf.d/nodejs-app.conf << 'NGINXEOF'
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
NGINXEOF

  # Remove default nginx config
  rm -f /etc/nginx/conf.d/default.conf

  # Restart nginx
  systemctl restart nginx
fi

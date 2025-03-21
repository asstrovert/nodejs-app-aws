#!/bin/bash
# Extract the application package
unzip -o /tmp/nodejs-app.zip -d /tmp/nodejs-app-extract

# Move files to application directory
cp -r /tmp/nodejs-app-extract/* /opt/nodejs-app/

# Clean up
rm -rf /tmp/nodejs-app-extract

# Set permissions
chown -R ec2-user:ec2-user /opt/nodejs-app

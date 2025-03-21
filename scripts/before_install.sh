#!/bin/bash
# Update system and install dependencies
yum update -y
if ! command -v node &> /dev/null; then
  curl -sL https://rpm.nodesource.com/setup_18.x | bash -
  yum install -y nodejs
fi

# Create app directory if it doesn't exist
mkdir -p /opt/nodejs-app

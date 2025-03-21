#!/bin/bash
# Stop the application if it's running
if systemctl is-active --quiet nodejs-app; then
  systemctl stop nodejs-app
fi

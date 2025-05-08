#!/bin/bash

# Script to build and deploy the website content

# Stop on errors
set -e

# Build the Astro project
cd "$(dirname "$0")/site-content"
npm run build

# Define the target directories
TARGET_DIRS=(
    "/var/www/gnarlybob.net"
    "/var/www/bitspace.org"
    "/var/www/bitspace.dev"
    "/var/www/chriswoods.dev"
)

# Create directories if they don't exist
for dir in "${TARGET_DIRS[@]}"; do
    sudo mkdir -p "$dir"
done

# Copy the built files to the appropriate web directories
sudo cp -r dist/gnarlybob.html /var/www/gnarlybob.net/index.html
sudo cp -r dist/bitspace-org.html /var/www/bitspace.org/index.html
sudo cp -r dist/bitspace-dev.html /var/www/bitspace.dev/index.html
sudo cp -r dist/chriswoods.html /var/www/chriswoods.dev/index.html

# Copy static assets if they exist
if [ -d "dist/assets" ]; then
    for dir in "${TARGET_DIRS[@]}"; do
        sudo mkdir -p "$dir/assets"
        sudo cp -r dist/assets/* "$dir/assets/"
    done
fi

# Set appropriate permissions
sudo chown -R www-data:www-data /var/www

echo "Deployment complete!"
echo "You may need to restart nginx with: sudo systemctl restart nginx"
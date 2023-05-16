#!/bin/sh

# Prompt for the Keycloak hostname
read -p "Enter the Keycloak hostname (as in the certificate keys directory): " -r KC_HOSTNAME

# Set the certificate directory path
CERT_DIR="/var/lib/docker/volumes/utility-infrastructure_certs/_data/${KC_HOSTNAME}"

# Check if CERT_DIR exists
if [ ! -d "$CERT_DIR" ]; then
  echo "Error: Certificate directory '$CERT_DIR' does not exist."
  exit 1
fi

# Copy certificates to the current directory
echo "Copying certificates from '$CERT_DIR' to the current directory..."
cp -R "$CERT_DIR" .
ls -a .

# Start the Docker Compose setup
echo "Starting Docker Compose..."
docker-compose up -d

# Remove the copied certificates
echo "Removing copied certificates..."
rm -rf "${KC_HOSTNAME}"

echo "Keycloak setup completed."

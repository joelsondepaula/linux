#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if script is being run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

# Check if CSF is already installed
if command -v csf >/dev/null 2>&1; then
  echo "CSF is already installed."
  exit 0
fi

# Move to the root directory
cd /root

# Download CSF package
echo "Downloading CSF package..."
wget https://download.configserver.com/csf.tgz

# Check if the download was successful
if [[ ! -f csf.tgz ]]; then
  echo "Download failed!" >&2
  exit 1
fi

# Extract the downloaded tarball
echo "Extracting CSF package..."
tar -xzf csf.tgz

# Move into the extracted CSF directory
cd csf

# Run the CSF installation script for cPanel
echo "Running CSF installation..."
bash install

# Backup existing CSF configuration before modifying it
echo "Backing up existing CSF configuration..."
cp /etc/csf/csf.conf /etc/csf/csf.conf.bak
cp /etc/csf/csf.allow /etc/csf/csf.allow.bak

# Download and overwrite the csf.conf file
echo "Downloading and overwriting csf.conf..."
wget -O /etc/csf/csf.conf https://raw.githubusercontent.com/joelsondepaula/linux/refs/heads/main/csf.conf

# Download and overwrite the csf.allow file
echo "Downloading and overwriting csf.allow..."
wget -O /etc/csf/csf.allow https://raw.githubusercontent.com/joelsondepaula/linux/refs/heads/main/csf.allow

# Restart CSF to apply the changes
echo "Restarting CSF..."
csf -r

# Clean up: remove the downloaded and extracted files
cd ..
rm -rf csf csf.tgz

# Indicate completion
echo "CSF installation completed successfully, configuration files updated, and CSF restarted."

#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Move to the root directory
cd /root

# Download CSF package
curl -O https://download.configserver.com/csf.tgz

# Check if the download was successful
if [[ ! -f csf.tgz ]]; then
  echo "Download failed!"
  exit 1
fi

# Extract the downloaded tarball
tar -xzf csf.tgz

# Move into the extracted CSF directory
cd csf

# Run the CSF installation script for cPanel
./install.cpanel.sh

# Clean up: remove the downloaded and extracted files
cd ..
rm -rf csf csf.tgz

# Modify the CSF configuration to set TESTING to 0
sed -i 's/^TESTING = "1"/TESTING = "0"/' /etc/csf/csf.conf

# Restart CSF to apply the changes
csf -r

# Indicate completion
echo "CSF installation completed successfully, TESTING set to 0, and CSF restarted."
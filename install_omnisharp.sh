#!/bin/bash

# Specify the GitHub user and repository
USER="OmniSharp"
REPO="omnisharp-roslyn"

# Use GitHub API to get the latest release data
API_URL="https://api.github.com/repos/$USER/$REPO/releases/latest"

echo "Reading from $API_URL"

# Use curl to fetch the JSON response for the latest release
#response=$(curl -s $API_URL)

# Extract the download URL for the latest release
#download_url=$(echo "$response" | grep '"browser_download_url":' | sed -E 's/.*"([^"]+)".*/\1/')

# Download the latest release
#echo "Downloading latest release from $download_url"
#curl -L -o latest_release.tar.gz "$download_url"

#echo "Download complete. File saved as latest_release.tar.gz"


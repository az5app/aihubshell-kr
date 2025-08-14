#!/bin/bash

# AIHub Shell Release Preparation Script
# This script prepares the aihubshell for release and generates SHA256 for Homebrew
# Supports version-based directory structure

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
VERSIONS_DIR="${PROJECT_DIR}/versions"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Get version from argument or prompt
if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage: $0 <version>${NC}"
    echo -e "${YELLOW}Example: $0 0.5${NC}"
    echo ""
    echo "Available versions:"
    if [ -d "$VERSIONS_DIR" ]; then
        ls "$VERSIONS_DIR" | sort -V
    else
        echo "No versions found"
    fi
    exit 1
fi

VERSION="$1"
VERSION_DIR="${VERSIONS_DIR}/${VERSION}"
RELEASE_NAME="aihubshell-${VERSION}"

# Check if version exists
if [ ! -d "$VERSION_DIR" ]; then
    echo -e "${RED}Error: Version ${VERSION} not found in ${VERSIONS_DIR}${NC}"
    echo "Available versions:"
    ls "$VERSIONS_DIR" | sort -V
    exit 1
fi

if [ ! -f "${VERSION_DIR}/aihubshell" ]; then
    echo -e "${RED}Error: aihubshell script not found in ${VERSION_DIR}${NC}"
    exit 1
fi

echo -e "${BLUE}Preparing release ${RELEASE_NAME}...${NC}"

# Create release directory
mkdir -p "${RELEASE_NAME}"

# Copy the shell script from version directory
cp "${VERSION_DIR}/aihubshell" "${RELEASE_NAME}/"

# Create tar.gz archive
tar -czf "${RELEASE_NAME}.tar.gz" "${RELEASE_NAME}"

# Calculate SHA256
SHA256=$(shasum -a 256 "${RELEASE_NAME}.tar.gz" | awk '{print $1}')

echo -e "${GREEN}Release archive created: ${RELEASE_NAME}.tar.gz${NC}"
echo -e "${GREEN}SHA256: ${SHA256}${NC}"
echo ""
echo -e "${YELLOW}To complete the release:${NC}"
echo "1. Upload ${RELEASE_NAME}.tar.gz to GitHub Releases"
echo "2. Update the SHA256 in ../homebrew-tap/Formula/aihubshell.rb to: ${SHA256}"
echo "3. Update the version in ../homebrew-tap/Formula/aihubshell.rb to: ${VERSION}"
echo "4. Commit and push changes to homebrew-tap repository"
echo ""
echo "GitHub Release URL should be:"
echo "https://github.com/az5app/aihubshell-kr/releases/tag/${VERSION}"
echo ""
echo -e "${BLUE}GitHub Release Creation Command:${NC}"
echo "gh release create ${VERSION} ${RELEASE_NAME}.tar.gz --title \"AIHub Shell ${VERSION}\" --notes \"Release version ${VERSION} of AIHub Shell\""

# Clean up
rm -rf "${RELEASE_NAME}"
#!/bin/bash

# AIHub Shell Version Management Script
# This script helps manage different versions of aihubshell

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
VERSIONS_DIR="${PROJECT_DIR}/versions"
CURRENT_LINK="${PROJECT_DIR}/aihubshell"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_usage() {
    echo "AIHub Shell Version Manager"
    echo ""
    echo "Usage: $0 [command] [options]"
    echo ""
    echo "Commands:"
    echo "  list                List all available versions"
    echo "  current             Show current active version"
    echo "  switch <version>    Switch to specified version"
    echo "  add <version>       Add a new version"
    echo "  remove <version>    Remove a version"
    echo "  help                Show this help message"
}

list_versions() {
    echo -e "${BLUE}Available versions:${NC}"
    if [ -d "$VERSIONS_DIR" ]; then
        for version in $(ls "$VERSIONS_DIR" | sort -V); do
            if [ -L "$CURRENT_LINK" ] && [ "$(readlink "$CURRENT_LINK")" == "${VERSIONS_DIR}/${version}/aihubshell" ]; then
                echo -e "  ${GREEN}* ${version} (current)${NC}"
            else
                echo "    ${version}"
            fi
        done
    else
        echo -e "${YELLOW}No versions found${NC}"
    fi
}

get_current_version() {
    if [ -L "$CURRENT_LINK" ]; then
        local link_target=$(readlink "$CURRENT_LINK")
        local version=$(basename $(dirname "$link_target"))
        echo -e "${BLUE}Current version:${NC} ${GREEN}${version}${NC}"
    else
        echo -e "${YELLOW}No version currently selected${NC}"
    fi
}

switch_version() {
    local version=$1
    local version_dir="${VERSIONS_DIR}/${version}"
    local version_script="${version_dir}/aihubshell"
    
    if [ -z "$version" ]; then
        echo -e "${RED}Error: Version not specified${NC}"
        echo "Usage: $0 switch <version>"
        return 1
    fi
    
    if [ ! -d "$version_dir" ]; then
        echo -e "${RED}Error: Version ${version} not found${NC}"
        list_versions
        return 1
    fi
    
    if [ ! -f "$version_script" ]; then
        echo -e "${RED}Error: aihubshell script not found in ${version}${NC}"
        return 1
    fi
    
    # Remove existing symlink if it exists
    if [ -L "$CURRENT_LINK" ] || [ -f "$CURRENT_LINK" ]; then
        rm "$CURRENT_LINK"
    fi
    
    # Create new symlink
    ln -s "${version_script}" "$CURRENT_LINK"
    echo -e "${GREEN}Switched to version ${version}${NC}"
}

add_version() {
    local version=$1
    local version_dir="${VERSIONS_DIR}/${version}"
    
    if [ -z "$version" ]; then
        echo -e "${RED}Error: Version not specified${NC}"
        echo "Usage: $0 add <version>"
        return 1
    fi
    
    if [ -d "$version_dir" ]; then
        echo -e "${YELLOW}Version ${version} already exists${NC}"
        return 1
    fi
    
    mkdir -p "$version_dir"
    echo -e "${GREEN}Created version directory for ${version}${NC}"
    echo "Please copy the aihubshell script to: ${version_dir}/"
}

remove_version() {
    local version=$1
    local version_dir="${VERSIONS_DIR}/${version}"
    
    if [ -z "$version" ]; then
        echo -e "${RED}Error: Version not specified${NC}"
        echo "Usage: $0 remove <version>"
        return 1
    fi
    
    if [ ! -d "$version_dir" ]; then
        echo -e "${RED}Error: Version ${version} not found${NC}"
        return 1
    fi
    
    # Check if this is the current version
    if [ -L "$CURRENT_LINK" ] && [ "$(readlink "$CURRENT_LINK")" == "${version_dir}/aihubshell" ]; then
        echo -e "${YELLOW}Warning: ${version} is the current active version${NC}"
        read -p "Are you sure you want to remove it? (y/N): " confirm
        if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
            echo "Cancelled"
            return 0
        fi
        rm "$CURRENT_LINK"
    fi
    
    rm -rf "$version_dir"
    echo -e "${GREEN}Removed version ${version}${NC}"
}

# Main script logic
case "$1" in
    list)
        list_versions
        ;;
    current)
        get_current_version
        ;;
    switch)
        switch_version "$2"
        ;;
    add)
        add_version "$2"
        ;;
    remove)
        remove_version "$2"
        ;;
    help|--help|-h)
        print_usage
        ;;
    *)
        if [ -z "$1" ]; then
            print_usage
        else
            echo -e "${RED}Unknown command: $1${NC}"
            print_usage
        fi
        exit 1
        ;;
esac
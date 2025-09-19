#!/usr/bin/env bash

# Create the external servicenet network for all services

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Creating servicenet network...${NC}"

# Check if network already exists
if podman network exists servicenet 2>/dev/null; then
    echo -e "${YELLOW}Network 'servicenet' already exists.${NC}"
else
    # Create the network
    if podman network create servicenet; then
        echo -e "${GREEN}Network 'servicenet' created successfully.${NC}"
    else
        echo -e "${RED}Failed to create network 'servicenet'.${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}Done!${NC}"
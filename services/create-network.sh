#!/bin/bash

# Create the external servicenet network for all services
echo "Creating servicenet network..."

# Check if network already exists
if podman network exists servicenet 2>/dev/null; then
    echo "Network 'servicenet' already exists."
else
    # Create the network
    podman network create servicenet
    echo "Network 'servicenet' created successfully."
fi

echo "Done!"
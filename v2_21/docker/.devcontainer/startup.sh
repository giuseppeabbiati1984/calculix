#!/bin/bash

set -e

sleep 5

# Start the VNC server
vncserver :1 -geometry 1280x800 -depth 24

# Keep the container running
# tail -f /dev/null
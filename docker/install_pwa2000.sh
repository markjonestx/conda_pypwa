#!/bin/bash

set -e  # Exit on failure.

# Some environment vairables to allow tzdata to have an automated
# installation
export DEBIAN_FRONTEND="noninteractive"
export TZ="America/New_York"


# Install the build dependencies for PWA2000
apt-get update
apt-get upgrade -y
apt-get install -y --no-install-recommends \
    ca-certificates git build-essential cmake ninja-build


# Setup the build environment
git clone --depth=1 https://github.com/Markjonestx/PyPWA-Utilities \
    /tmp/pwa2000

mkdir /tmp/build
cd /tmp/build

cmake -GNinja -DCMAKE_BUILD_TYPE=minsizerel ../pwa2000


# Build and install
ninja
ninja install


# Cleanup the build
cd ~
rm -rf /tmp/{build,pwa2000}
apt purge -y git build-essential cmake ninja-build
apt autoremove -y
rm -rf /var/lib/apt/lists/*

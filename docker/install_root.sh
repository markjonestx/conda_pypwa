#!/bin/bash

set -e  # Exit on failure.

# Some environment vairables to allow tzdata to have an automated
# installation
export DEBIAN_FRONTEND="noninteractive"
export TZ="America/New_York"


# Install the build dependencies for CERN's ROOT
apt update
apt upgrade -y
apt install -y --no-install-recommends \
    dpkg-dev git make cmake g++ gcc binutils libx11-dev libxpm-dev \
    libxft-dev libxext-dev libssl-dev python3.8-dev build-essential \
    ninja-build libpcre3-dev libglew2.1 libftgl-dev libglew-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev libgraphviz-dev \
    libxml2-dev libgsl-dev mpi-default-dev libsqlite3-dev \
    libx11-6 libxpm4 libxft2 libssl1.1 libpcre3 libmysqlclient21 \
    libftgl2 libfftw3-bin libcfitsio8 graphviz libxml2 libgsl23 \
    gfortran sqlite3


# Setup the build environment
git clone --depth=1 --branch latest-stable \
    https://github.com/root-project/root.git /tmp/root-git

mkdir /tmp/root-build
cd /tmp/root-build

cmake -DCMAKE_BUILD_TYPE=release -GNinja \
    -Dall=ON \
    -Dcxx11=ON \
    -Dcuda=ON \
    -Dcudnn=ON \
    -Dfortran=ON \
    -Dmpi=ON \
    -DPYTHON_EXECUTABLE=/usr/bin/python3.8 \
    -DPYTHON_INCLUDE_DIR=/usr/include/python3.8 \
    -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.8.so \
    -Dtmva-gpu=ON /tmp/root-git


# Build and install
ninja
ninja install


# Cleanup the build
cd ~
rm -rf /tmp/root*
rm -rf /var/lib/apt/lists/*


# Connect ROOT's environment
echo "source /usr/local/bin/thisroot.sh" > ~/.bashrc
echo "source /usr/local/bin/thisroot.csh" > ~/.cshrc

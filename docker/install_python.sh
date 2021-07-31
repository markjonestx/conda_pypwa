#!/bin/bash

set -e  # Exit on failure

# Some environment vairables to allow tzdata to have an automated
# installation
export DEBIAN_FRONTEND="noninteractive"
export ENV TZ="America/New_York"


# Install the build dependencies for PyPWA
apt-get update
apt-get upgrade -y
apt-get install -y --no-install-recommends python3.8-minimal python3-pip \
    git python3.8-dev build-essential gfortran ca-certificates

if [[ -n "$BUILD_CUPY" ]]
then
    apt-get install -y --no-install-recommends libgomp1
fi


# Setup Python extras and install PyPWA
export CFLAGS="-I/usr/local/lib/python3.8/dist-packages/include/"

pip --no-cache-dir install Cython

if [[ -n "$ALL_PYTHON" ]]
then
    pip install --no-cache-dir numpy scipy cupy-cuda$CUPY_VERSION \
        jupyterlab ipython jupyter matplotlib tensorflow scikit-learn
else
    pip install --no-cache-dir numpy scipy cupy-cuda$CUPY_VERSION
fi

pip install --no-cache-dir git+https://github.com/JeffersonLab/PyPWA.git


# Cleanup the build
cd ~
rm -rf /tmp/{build,pwa2000}
apt purge -y git build-essential gfortran python3.8-dev
apt autoremove -y
rm -rf /var/lib/apt/lists/*

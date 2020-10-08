#!/bin/bash

echo "========================================= WARNING =================================================="
echo "This is example of installing SoftHsm2 in docker container based on Alpine Linux manually by script."
echo "The best way of doing this - editing docker file which was used to build this image."
echo "========================================= WARNING =================================================="

export SOFTHSM_SOURCES_PATH=$1

echo "Installing softhsm ..."

# Installation of dependencies
echo "Installing softhsm dependencies..."
apk update
apk add automake
apk add autoconf
apk add libtool
apk add g++
apk add openssl
apk add opensc
apk add curl
apk add libressl-dev
apk add make

# Installation of SoftHSM2
echo "Installing softhsm from sources..."
cd $SOFTHSM_SOURCES_PATH
sh autogen.sh
./configure
make
make install

echo "SoftHsm2 successfully installed"
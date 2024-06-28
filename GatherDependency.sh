#!/bin/bash
# Binary to gather dependencies for
BINARY=./RunHDMaps
# Directory to store dependencies
LIB_DIR=./libs
# Create the directory if it doesn't exist
mkdir -p $LIB_DIR
# List and copy dependencies
for lib in $(ldd $BINARY | grep "=> /" | awk '{print $3}'); do
   cp "$lib" $LIB_DIR/
done
# Modify the binary to use the local libs directory
patchelf --set-rpath '$ORIGIN/libs' $BINARY
echo "Dependencies gathered and binary modified."
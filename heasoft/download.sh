#!/bin/bash

set -xe

HEASOFT_VERSION=6.33.1
aria2c -x6 "https://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/lheasoft${HEASOFT_VERSION}/heasoft-${HEASOFT_VERSION}src.tar.gz"

tar xfz heasoft-${HEASOFT_VERSION}src.tar.gz

# do some cleanup for macos aarch64
# can't seem to get suzaku to compile
rm -r heasoft-${HEASOFT_VERSION}src.tar.gz heasoft-${HEASOFT_VERSION}/suzaku


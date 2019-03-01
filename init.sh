#!/bin/bash

# run this script for init your environment 

set -x
set -e

# check the itrashcan_home
if [ ! -n "$itrashcan_home" ]; then
    echo "Please source config.sh first!"
    exit
fi

# exit if the target exists.
if [ -d "$itrashcan_home" ]; then
    echo "The directory already exists in the target path, please check!"
    exit
fi

# create a trash can
mkdir $itrashcan_home
mkdir $itrashcan_home"/trash"
mkdir $itrashcan_home"/trash_log"

# init permissions


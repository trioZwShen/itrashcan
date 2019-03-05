#!/bin/bash

# run this script for init your environment 
# set -x
set -e

# check the $itrashcan_home.
if [ ! -n "$itrashcan_home" ]; then
    echo "Please set the environment var first!!!"
    exit
fi

# exit if the $itrashcan_home already exists.
if [ -d "$itrashcan_home" ]; then
    echo "The directory already exists in the target path, please check!!!"
    exit
fi

# create trashcan and trash log
mkdir $itrashcan_home
mkdir $itrashcan_home"/trash"
touch $itrashcan_home"/trash.log"

# init permissions
chmod 777 -R $itrashcan_home
chmod 755 -R $itrashcan

echo "Init Done."

#!/bin/bash

echo "Are you sure you want to permanently erase the items in the Trash?[Y/n]"
read ask
if [ $ask = 'y' -o $ask = 'Y' ]
then
    `rm -rf $itrashcan_home/trash/*`
fi


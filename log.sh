#!/bin/bash
log="${itrashcan_home}/trash.log"
# create if log does not exist
if [ ! -d $log  ]; then
    touch $log
fi

echo "trashname:$1 filename:$2; deletetime:$3 fullpath:$4" >> $log

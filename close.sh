#!/bash/bin

# run this script for remove itrashcan config and environmental
set -e
set -x
# clear file and directory
/bin/rm -rf $itrashcan_home

# clear crontab

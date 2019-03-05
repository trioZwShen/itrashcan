#!/bash/bin

# run this script for remove itrashcan config and environmental
# set -x
set -e
# clear file and directory
/bin/rm -rf $itrashcan_home
echo "Remove done."

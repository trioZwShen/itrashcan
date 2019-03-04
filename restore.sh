#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Please enther the target what your want to restore!";
    exit;
fi

for target in $@
do
log="${itrashcan_home}/trash.log"
trashcan="${itrashcan_home}/trash"
findpattern="filename:${target};"

rowcount=`cat -n "$log" | grep "$findpattern" | wc -l`
if [ $rowcount -eq 0 ]; then
    echo "${target} does not exist in LOG"
    exit
elif [ $rowcount -eq 1 ]; then
    output=`cat -n "$log" | grep "$findpattern"`
    # get the origin fullpath and trashnamename
    index=`echo $output | awk '{print $1}'`
else
    cat -n "${itrashcan_home}/trash.log" | grep "${findpattern}"
    echo -n "Please enter the target file line number: "
    read index
    output=`cat -n "$log" | grep "\ ${index}\ *.*${findpattern}.*"`
fi

# get the fullpath and trashname
fullpath=`echo $output | awk '{print $5}'`
fullpath=${fullpath#*:}
trashname=`echo $output | awk '{print $2}'`
trashname=${trashname#*:}

# check the trashname
trashnamepath="${trashcan}/${trashname}"
if [ ! -d "$trashnamepath" -a ! -f "$trashnamepath" ]; then
    echo "${target} does not exist in TRASHCAN"
    exit
fi 
# check the origin path
if [ -d $fullpath -o -f $fullpath ]; then
    echo "The original path has a duplicate file [$fullpath]!!!"
    exit
fi
basepath=`dirname $fullpath`
if [ ! -d $basepath ]; then
    echo "The original path [${basepath}] does not exist!!!"
    exit
fi

# restore the trash
if ! mv -f "$trashnamepath" "$fullpath" ; then
    echo "failed"
    exit
else
    # delete the log
    sed -i "${index}d" $log
    echo "${fullpath} restored"
fi
done

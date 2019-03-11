#!/bin/bash
# set -x
set -e
realrm="/bin/rm"

# init if the $itrashcan_home not exists
if [ ! -d "$itrashcan_home" ]; then
    bash init.sh
fi

# usage tips
if [ $# -eq 0 ]; then
    echo "Usage:delete file [file2 file3 ...]"
    echo "If the options contain -f then the script will exec 'rm' directly."
fi

# identify input options, if f is point then exec realrm
while getopts "dfiPRrvw" opt
do
    case $opt in
        f)
            echo "real rm done"
            exec $realrm "$@"
            ;;
        d)
            # do nothing
            ;;
        i)
            # do nothing
            ;;
        P)
            # do nothing
            ;;
        R)
            # do nothing
            ;;
        r)
            # do nothing
            ;;
        v)
            # do nothing
            ;;
        w)
            # do nothing
            ;;
        ?) 	# unknow argument
            exit
            ;;
    esac
done

# travel the input file
for file in $@
do
    if [ -f "$file" -o -d "$file" ]; then
        # real rm if size is larger than 2G
        if [ -f "$file" ] && [ `ls -l $file|awk '{print $5}'` -gt 2147483648 ]
        then
            echo "$file size is lager than 2G, will be deleted directly"
            rm -rf $file
        fi
        if [ -d "$file" ] && [ `du -sb $file|awk '{print $1}'` -gt 2147483648 ]
        then
            echo "The directory: $file size is lager than 2G, will be deleted directly"
            rm -rf $file
        fi

        # rename
        now=`date +%Y-%m-%d_%H_%M_%S`
        filename=`basename $file`
        newfilename="${filename}_${now}"

        # get fullpath
        basepath=$(cd `dirname $file`; pwd)
        fullpath="${basepath}/${filename}"

        # mv to trashcan
        if mv -f "$fullpath" "$itrashcan_home/trash/$newfilename"
        then
            bash $itrashcan/log.sh $newfilename $filename $now $fullpath
            echo "$fullpath is move to trashcan"
        else
            echo "fail"
        fi

    else
        echo "$file is not exist"
    fi
done

# trashcan size > 10G remider user
if [ `du -sb "${itrashcan_home}"/trash|awk '{print $1}'` -gt 5368709120 ]; then
    echo "Warning: trashcan's size[`du -sh "${itrashcan_home}/trash"|awk '{print $1}'`] is biger than 5G."
fi

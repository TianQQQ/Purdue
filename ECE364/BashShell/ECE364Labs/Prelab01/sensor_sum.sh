#! /bin/bash
#
#    $Author: ee364d08 $
#    $Date: 2015-08-31 21:58:23 -0400 (Mon, 31 Aug 2015) $
#    $HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/F15/students/ee364d08/Prelab01/sensor_sum.sh $
#    $Revision: 80951 $


if [[ -z $1 ]]
then
    echo "Usage: sensor_sum.sh <filename>"
elif [[ ! -r $1 ]]
then
    echo "Error: $1 is not a readable file!"
else
    while read ln
    do
        sensor=$(echo "$ln" | cut -d '-' -f 1)  # delete -, field first element
        sum=$(($(echo $ln | cut -f 2 -d ' ')+$(echo $ln | cut -d ' ' -f 3)+$(echo $ln | cut -d ' ' -f 4)))
        echo "$sensor $sum"
    done < $1
fi

exit 0

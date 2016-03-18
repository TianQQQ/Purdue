#! /bin/bash
#
#$Author: ee364d08 $
#$Date: 2015-09-01 16:33:50 -0400 (Tue, 01 Sep 2015) $
#$HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/F15/students/ee364d08/Lab01/advCalc.bash $
#$Revision: 81242 $

if [[ $# != 1 ]]
then 
    echo "Wrong number args"
    exit 1
fi

while read ln
do 
    echo -n "$ln: " 
    simpleCalc.bash $ln
done < $1



exit 0

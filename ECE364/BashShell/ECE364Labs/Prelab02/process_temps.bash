#! /bin/bash
#
#   $Author: ee364d08 $
#   $Date: 2015-09-07 20:41:46 -0400 (Mon, 07 Sep 2015) $
#   $HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/F15/students/ee364d08/Prelab02/process_temps.bash $
#   $Revision: 81540 $

if [[ $# != 1 ]]
then
    echo "Usage: proces_temps.bash <input file>"
    exit 1
elif [[ ! -r $1 ]]
then 
    echo "Error: $1 is not a readable file."
    exit 2
else
    while read -a line
    do 
        if [[ $line != "time" ]]
        then 
            let num=${#line[*]}-1
            sum=0
            for i in ${line[*]}    #for every element in line
            do
                if (( i != ${line[0]} ))
                then
                    let sum+=$i
                fi
            done
            let average=$sum/$num
            echo "Average temperature for time ${line[0]} is $average C."
        fi
    done < $1
fi
            

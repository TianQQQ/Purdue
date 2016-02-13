#! /bin/bash
#
#   $Author: ee364d08 $
#   $Date: 2015-09-07 20:41:46 -0400 (Mon, 07 Sep 2015) $
#   $HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/F15/students/ee364d08/Prelab02/run.bash $
#   $Revision: 81540 $

gcc $1 -o quick_sim
runtime=0
fastesttime=99999
fastwidth=0
fastcache=0
procc="Intel Core i7"
if (($? == 1))           # $?check error code of the last excuted command(=1)
then
    echo "error: quick_sim could not be compiled!"
    exit 1
fi

if [ -e $2 ]
then
    read -p "$2 exists. Would you like to delete it? " answer  #prompt
    if [[ $answer == "y" ]]
    then
        rm $2
        file=$2
        touch $file
        #exec 4>>$file    # assign file decriptor n to file for appending 
    elif [[ $answer == "n" ]]
    then 
        read -p "Enter a new filename: " file
        touch $file
       # exec 4>>$file
    else
        echo "Please enter y or n"
        exit 0
    fi
else
    file=$2
    touch $file
fi

cache=(1 2 4 8 16 32)
width=(1 2 4 8 16)
fastest=100000
for i in ${cache[*]}
do
    for f in ${width[*]}
    do
        string_a=$(quick_sim $i $f a)
        #echo $string_a
        processor=$(echo $string_a | cut -d ':' -f 2)
        cache_s=$(echo $string_a | cut -d ':' -f 4)
        issue_w=$(echo $string_a | cut -d ':' -f 6)
        CPI=$(echo $string_a | cut -d ':' -f 8)
        exectime=$(echo $string_a | cut -d ':' -f 10)
    #    echo $exectime
        echo "$processor:$cache_s:$issue_w:$CPI:$exectime" >> $file
        if (( $fastest > $exectime ))
        then
            fastest=$exectime
            fastest_w=$issue_w
            fastest_c=$cache_s
            fastest_p=$processor
        fi
        string_i=$(quick_sim $i $f i)
        processor=$(echo $string_i | cut -d ':' -f 2)
        cache_s=$(echo $string_i | cut -d ':' -f 4)
        issue_w=$(echo $string_i | cut -d ':' -f 6)
        CPI=$(echo $string_i | cut -d ':' -f 8)
        exectime=$(echo $string_i | cut -d ':' -f 10)
        echo "$processor:$cache_s:$issue_w:$CPI:$exectime" >> $file
        if (( $fastest > $exectime ))
        then
            fastest=$exectime
            fastest_w=$issue_w
            fastest_c=$cache_s
            fastest_p=$processor
        fi
    done
   # echo $fastest
done
echo "Fastest run time achieved by $fastest_p with cache size $fastest_c and issue width $fastest_w was $fastest"
exit 0




























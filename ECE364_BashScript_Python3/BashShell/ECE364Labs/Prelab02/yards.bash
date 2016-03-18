#! /bin/bash
#
#       $Author: ee364d08 $
#       $Date: 2015-09-07 20:41:46 -0400 (Mon, 07 Sep 2015) $
#       $HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/F15/students/ee364d08/Prelab02/yards.bash $
#       $Revision: 81540 $
if [[ $# != 1 ]]
then
    echo "Usage: yards.bash <filename>"
    exit 1
fi

if [[ ! -r $1 ]]
then 
    echo "Error: $1 is no readable"
    exit 1
fi

exec 8<$1    # assigns file descriptor n to file for reading
max=0
while read -a line       # read line to array from $1i
do
    sum=0
    average=0
    var=0
    element=0
    num_s=0
    #let num_s=${#line[*]-1}  # number of elements - 1
    let num_s=${#line[*]}-1
    #echo $num_s
    for ((i = 1; i < ${#line[*]} ; i++))  # calculate average
    do
        let sum=sum+${line[$i]}
    done
    
    let average=sum/num_s
    
    if(($average > max))
    then 
        let max=average
    fi  
    for ((i = 1; i < ${#line[*]}; i++))    # calculate var
    do
        let element=${line[$i]}-average
        let element*=element
        let var+=element
    done

    let var=var/num_s

    echo "${line[0]} schools averaged $average yards reveiving with a variance of $var"

done <&8
echo "The largest average yardage was $max"












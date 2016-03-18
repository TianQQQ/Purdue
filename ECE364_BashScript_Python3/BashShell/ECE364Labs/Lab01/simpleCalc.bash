#! /bin/bash
#
#$Author: ee364d08 $
#$Date: 2015-09-01 15:22:46 -0400 (Tue, 01 Sep 2015) $
#$HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/F15/students/ee364d08/Lab01/simpleCalc.bash $
#$Revision: 81200 $

if [[ $# != 3 ]]
then 
    echo "Usage: .SimpleCalc.bash <operator> <operand1> <operand2>"
    exit 1
fi

if [[ $1 != "add" && $1 != "sub" && $1 != "mul" && $1 != "div" && $1 != "exp" && $1 != "mod" ]]
then
    echo "Error: invalid operator."
    exit 2
fi


if [[ $1 == "add" ]]
then 
    let res=$2+$3
    echo "$2 + $3 = $res"

elif [[ $1 == "sub" ]]
then 
    let res=$2-$3
    echo "$2 - $3 = $res"

elif [[ $1 == "mul" ]]
then 
    let res=$2*$3
    echo "$2 * $3 = $res"

elif [[ $1 == "exp" ]]
then 
    let res=$2**$3
    echo "$2 ^ $3 = $res"

elif [[ $1 == "div" ]]
then 
    let res=$2/$3
    echo "$2 / $3 = $res"

elif [[ $1 == "mod" ]]
then 
    let res=$2%$3
    echo "$2 % $3 = $res"

fi

exit 0

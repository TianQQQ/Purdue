#/bin/bash
#
#    $Author: ee364d08 $
#    $Date: 2015-08-31 21:24:24 -0400 (Mon, 31 Aug 2015) $
#    $HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/F15/students/ee364d08/Prelab01/line_num.bash $
#    $Revision: 80908 $

[[ -z "$@" ]] && echo "Usage: line_num.bash <file_name>"
# -z is $@ should not be empty 

# $1 is the first arguments second items
for ind in "$@";

do
    if [[ -r $ind ]]
    then 
        lineNum=1
        while read l    
        do 
            echo "$lineNum:$l"
            let lineNum=$lineNum+1
        done < $1       # read line of $1 !!!
    else
        echo "Cannot read unreadable"
    fi
done

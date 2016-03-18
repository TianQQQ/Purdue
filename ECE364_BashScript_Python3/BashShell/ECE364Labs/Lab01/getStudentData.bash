#! /bin/bash
#
#$Author: ee364d08 $
#$Date: 2015-09-01 15:22:46 -0400 (Tue, 01 Sep 2015) $
#$HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/F15/students/ee364d08/Lab01/getStudentData.bash $
#$Revision: 81200 $

cd gradebooks
max=0

if [[ $# != 1 ]]
then
    echo "Usage: ./getStudentData.bash <course name>"
    exit 1
fi

if [[ $1 != "ece364" && $1 != "ece337" ]]
then
    echo "Error: cource <$1> is not a valid option."

elif [[ $1 == "ece364" ]]
then 
    while read line
    do
        ((counter++))
        let grade=$(echo $line | cut -f 2 -d ',' )
        let sum+=$grade
    
        if (( max < grade ))
        then
            let max=$grade
            name=$(echo "$line" | cut -d ',' -f 1)
        fi
    
    done < ece364_1.txt
    while read line
    do
        ((counter++))
        let grade=$(echo $line | cut -f 2 -d ',' )
        let sum+=$grade
    
        if (( max < grade ))
        then
            let max=$grade
            name=$(echo "$line" | cut -f 1 -d ',')
        fi
    
    
    done < ece364_2.txt
    while read line
    do
        ((counter++))
        let grade=$(echo $line | cut -f 2 -d ',' )
        let sum+=$grade
    
        if (( max < grade ))
        then
            let max=$grade
            name=$(echo "$line" | cut -f 1 -d ',')
        fi
    
    done < ece364_3.txt

    let ave=$sum/$counter
    echo "Total students: $counter"
    echo "Average score: $ave"
    echo "$name had the highest score of $max"
elif [[ $1 == "ece337" ]]
then 
    while read line
    do
        ((counter++))
        let grade=$(echo $line | cut -f 2 -d ',' )
        let sum+=$grade
    
        if (( max < grade ))
        then
            let max=$grade
            name=$(echo "$line" | cut -f 1 -d ',')
        fi
    
    done < ece337_1.txt
    while read line
    do
        ((counter++))
        let grade=$(echo $line | cut -f 2 -d ',' )
        let sum+=$grade
    
        if (( max < grade ))
        then
            let max=$grade
            name=$(echo "$line" | cut -f 1 -d ',')
        fi
    done < ece337_2.txt

    let ave=$sum/$counter
    echo "Total students: $counter"
    echo "Average score: $ave"

    echo "$name had the highest score of $max"
fi





#! /bin/bash
#
#   $Author: ee364d08 $
#   $Date: 2015-09-08 15:22:43 -0400 (Tue, 08 Sep 2015) $
#   $HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/F15/students/ee364d08/Lab02/printUsageStats.bash $
#   $Revision: 81652 $

if [[ $# != 1 ]]
then
    echo "Usage: ./printUsageStats.bash <input file>"
    exit 1
elif [[ ! -e $1 ]]
then 
    echo "Error: $1 does not exist"
    exit 2
else

    ts=$(head -n 1 logfile1 | cut -d ',' -f 1 | cut -d ' ' -f 3)
    echo Parsing file "$1". Timestamp: $ts

    echo "Your choices are:"
    echo "1) Active user IDs"
    echo "2) Highest CPU usage"
    echo "3) Top 3 longest running processes"
    echo "4) All processes by a specific user"
    echo "5) Exit"

    while [[ $choice != "5" ]]
    do
        printf "Please enter your choice: "
        read choice

        if [[ $choice == "1" ]]
        then
            printf "Total number of active user IDs: "
            head -n 1 $1 | cut -d ',' -f 3 | cut -d ' ' -f 2
            echo
        elif [[ $choice == "2" ]]
        then
            u=$(head -n 8  $1 | tail -n 1  | cut -d ' ' -f 2)
            c=$(head -n 8  $1 | tail -n 1  | cut -d ' ' -f 9)
            echo User $u is utilizing the highest CPU resouces at $c%
            echo
        elif [[ $choice == "3" ]]
        then
            tail -n +8 $1 | sort -n -t ' ' -rk 11 | head -n 3
            echo
        elif [[ $choice == "4" ]]
        then
            printf "Please enter a valid username: "
            read choice_name
            printf "Please enter a filename to save user's processes: "
            read filename
            while read line
            do
                name=$(echo $line | cut -d ' ' -f 2)
                if [[ $name == $choice_name ]]
                then 
                    echo $line >> $filename
                    counter=1
                fi
            done <$1

            if ((counter == 1))
            then
                echo Output written to file $filename
            else
                echo No match found
            fi
            echo
        elif [[ $choice == "5" ]]
        then
            exit 0
        else
            echo "Error! Invalid Selection!"
        fi
    done
fi






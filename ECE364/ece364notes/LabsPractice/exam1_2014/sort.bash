#! /bin/bash

if [[ $# < 3 ]]
then
    echo "Error: Insufficient information."
    exit 1
elif [[ ! -e $2 ]]
then
    echo "Error: File does not exist."
    exit 1
else
    while getopts f:-: thisopt
    do
	case $thisopt in
	    f)[[ ! -e $OPTARG ]] && echo "Error: File does not exist.";;
	    -)colnum=$(echo $OPTARG | cut -d'=' -f2)
	    string=$(head -n 1 $2)
	    if [[ $colnum < 1 ]] || [[ $colnum > lencol ]]
		then
		echo "Error: Column number $colnum does not exist."
	    fi
	    val=$(cat $2 | sort -k$colnum)
	    output=$2'.sorted'
	    echo "File sorted."
	    echo $(cat $2 | sort -k$colnum) > $output;;
	    *)echo "Error: Unknown option."
		exit 1;;
	esac
    done
    exit 0
fi

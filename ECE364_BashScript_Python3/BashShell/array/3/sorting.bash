

if [[ $# != 1 ]]
then
    echo "Usage: ./sorting.bash <input file>"
    exit 1
elif [[ ! -r $1 ]]
then
    echo "Error: $1 is not a readable file."
    exit 2
else
    while [[ $choice != "6" ]]
    do
	echo "Your choices are:"
	echo "1) First 10 people"
	echo "2) Last 5 names by highest zipcode"
	echo "3) Address of 6th-10th by reverse e-mail"
	echo "4) First 12 companies"
	echo "5) Pick a number of people"
	echo "6) Exit"
	printf "Your choice: "
	read choice
	if [[ $choice == "1" ]]
	then
	    tail -n +2 $1 | sort -t ',' -k7,7 -k5,5 -k2,2 -k1,1 | head -n 10
#    all except first 2 lines,then sort tab is ,   for [7] element, then take first 10 line
	elif [[ $choice == "2" ]]
	then
#       last 5 names by highest zip
	    tail -n +2 $1 | sort -r -t ',' -k9,9 | cut -d ',' -f1,2 | head -n 5
	elif [[ $choice == "3" ]]
	then
#       reverse sort
	    tail -n +2 $1 | sort -r -t ',' -k11,11 | cut -d ',' -f4 | head -n 10 | tail -n 5
	elif [[ $choice == "4" ]]
	then
	    tail -n +2 $1 | sort -t ',' -k3,3 | cut -d ',' -f3 | head -n 12
	elif [[ $choice == "5" ]]
	then
	    printf "Enter a number: "
	    read choice2
	    tail -n +2 $1 | sort -t ',' -k2,2 | head -n $choice2
	elif [[ $choice == "6" ]]
	    then
	    echo "Have a nice day!"
	    exit 0
	else
	    echo "Error! Invalid Selection!"
	fi
    done
fi
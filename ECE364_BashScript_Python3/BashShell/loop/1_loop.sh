NumParam=$#          #number of input parameter
Param_Values=$@      #take input parameter
i=$Param_Values
for((n=i; n >= 0; n--))
do
    echo "$n"
done
exit 0

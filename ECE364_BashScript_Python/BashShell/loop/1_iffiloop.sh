NumParam=$#
Param_Values=$@
i=$Param_Values
for((n=i; n >= 0; n--))
do
    if(( $n % 3 == 0))
	then
		echo "$n"
	fi	
done

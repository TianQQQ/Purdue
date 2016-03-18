##! /bin/bash
#  $Author$
#  $Date$
#  $HeadURL$
#  $Revision$

head -n 10 benchmarks.txt > first10.txt

tail -n 5 first10.txt

read -p "yes or no? " answer
echo $answer

user="/home/ecegrid/ee364d08/Prelab03"
cut -d "," -f 3 ',home,ecegrid,ee364d08,Prelab03'

gcc a.c >> compile.out 2>&1
if (($? == 1))
then
    echo " compiled error "
fi

wc -w first10.txt

i=1
exec 4<$1
while read line <&4
do
echo $i:$line
(( i=$i+1 ))
done

for line in $(ls f*.txt)
do
    echo C Program: $line
    gcc $line
    if(( $? == 0))
    then echo success!
    fi
done



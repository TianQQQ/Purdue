arrVar=(1 alex, 3)   # space is seperate, comma is not
echo $arrVar   # first elements of array
echo ${arrVar[*]}   # echo all elements of array
echo ${arrVar[1]}   # echo second element

#IFS=","  # change to comma seperate

oneElement="This is a single variable where words are space-separated."
arrVar=($oneElement)
echo ${arrVar[*]}
echo ${#arrVar[*]}  # number of array
echo ${!arrVar[*]}  # index of array

arrVar[4]=sentence
arrVar[15]=weirdo   # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! easy-wrong
echo ${#arrVar[*]} 
echo ${!arrVar[*]}

A=(foo bar baz) A[5]=cosby A[10]=jello
for item in ${A[*]} 
do
	echo $item
done

echo ==============second loop==========================
for item in ${!A[*]} 
do
    echo ${A[$item]}
done

echo ==============third loop==========================
for ((I = 0; I < ${#A[*]}; I++))
do
	echo ${A[$I]} 
done

# > Redirect stdout into txt file
myCommand="ls"
$myCommand > comFile.txt
ls > list.txt

# >> Append stdout into file
ls *.sh >> list.txt

# File Descriptors
# stdin 0
# standard output stdout 1
# stderr 2

#exec n<file # assigns file descriptor n to file for reading
#exec n>>file # assigns file decriptor n to file for appending
exec 13>someTextFile.txt # Assigns file descriptor 13 to file for writing

# >&n Redirects stdout to file descriptor n out to stdout
# n>file Redirect output from file descriptor n into file

echo this is the begining of the file >&13
echo ................................ >&13
echo $(date) >&13
echo this is the end >&13
echo


exec 224>inputParam.txt
echo 13 127 19 >&224

exec 99<inputParam.txt
read x y z <&99
echo "Elemt x is $x"

echo
# -n is number of lines wanted
head -n 2 list.txt
tail -n 3 list.txt

# pipe | is sending output to next command
tail -n 10 list.txt | head -n 5 list.txt

# ? local have, svn not have, not added
# M local modified, but not commit new version
# A local have added, svn not have
# blank    same


echo
ls | tee -a .txt | wc -l



exit 0




















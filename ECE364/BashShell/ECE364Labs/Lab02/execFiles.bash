#! /bin/bash
#
#   $Author: ee364d08 $
#   $Date: 2015-09-08 15:22:43 -0400 (Tue, 08 Sep 2015) $
#   $HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/F15/students/ee364d08/Lab02/execFiles.bash $
#   $Revision: 81652 $

cd c-files

for line in $(ls *.c)
do
    echo Attemping to compile $line
    gcc -Wall -Werror $line 2>/dev/null
    if (($? == 1))
    then
	echo Compiling file $line... Error: Compilation failed.
        
    else
	echo Compiling file $line... Compilation succeeded.
        file=$line
        filename=$(echo $file | cut -d '.' -f 1)
        a.out > $filename.out
    fi
done 

exit 0

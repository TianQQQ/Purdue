#! /bin/bash
#
#    $Author: ee364d08 $
#    $Date: 2015-08-31 21:46:58 -0400 (Mon, 31 Aug 2015) $
#    $HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/F15/students/ee364d08/Prelab01/svncheck.bash $
#    $Revision: 80937 $

ls > file_list 

while read -r -u11 ln
do 
    stt=$(svn status $ln | head -c 1) # get the first line of ln
    echo $ln
    if [[ $stt == "?" && -e $ln ]]    # check exists local and not exists on svn
    then
        if [[ ! -x $ln ]]             # local is not executable
        then
            echo "Would you like to make this file execuable? (y/n)"
            read YorN                 # read user's input
            [[ $YorN == "y" ]] && chomd +x $ln
        fi
        svn add $ln
    elif [[ ! -x $ln && -e $ln && $stt == "" ]]   # not executable, exists local, the same
    then
        svn propset svn:executable ON $ln
    fi
    # iff does not exist, print error
    [[ ! -e $ln ]] && echo "Error: File $ln appears to not to exist here or in svn"
done 11<file_list    # search all lines which have space
svn commit
echo "Auto-commiting code"


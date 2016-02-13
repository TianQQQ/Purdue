#! /bin/bash
#
#    $Author: ee364d08 $
#    $Date: 2015-08-31 21:24:24 -0400 (Mon, 31 Aug 2015) $
#    $HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/F15/students/ee364d08/Prelab01/exist.bash $
#    $Revision: 80908 $

for ind in "$@"
    do
        if [[ -r $ind ]]
        then
            echo "File $ind is readable!"
        else
            touch $ind
        fi
    done

exit 0

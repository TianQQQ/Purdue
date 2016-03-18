#! /bin/bash
#
#$Author: ee364d08 $
#$Date: 2015-08-31 21:25:41 -0400 (Mon, 31 Aug 2015) $
#$HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/F15/students/ee364d08/Prelab01/check_file.bash $
#$Revision: 80914 $

if (($# == 1))
then

    [[ -e $1 ]] && echo "$1 exists"
    [[ ! -e $1 ]] && echo "$1 does not exist"

    [[ -d $1 ]] && echo "$1 is a directory"
    [[ ! -d $1 ]] && echo "$1 is not a directory"

    [[ -f $1 ]] && echo "$1 is an ordinary file"
    [[ ! -f $1 ]] && echo "$1 is not an ordinary file"

    [[ -r $1 ]] && echo "$1 is readable"
    [[ ! -r $1 ]] && echo "$1 is not readable"

    [[ -w $1 ]] && echo "$1 is writable"
    [[ ! -w $1 ]] && echo "$1 is not writable"

    [[ -x $1 ]] && echo "$1 is executable"
    [[ ! -x $1 ]] && echo "$1 is not executable"


else
    echo "Usage: ./check_file.bash <filename>"
fi

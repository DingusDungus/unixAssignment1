#!/bin/bash

isSubDir=0;

if [[ $# > 1 || $# == 0 ]];
then
    echo "Error; too many or too little parameters given to program (Accepted amount is 1)"
    exit -1;
fi
if [[ ! -d $1 ]];
then
    echo "Error; Directory does not exist, given directory $1"
    exit -1;
fi
dirArray=()

if [[ `test -d ./$1` ]];
then
    echo "Error; dir given is not a subdir to workingdir"
    exit -1;
fi

currentDir=`pwd`

if [[ !`find $currentDir -maxdepth 0 -writable` == $currentDir ]];
then
    echo "Cannot write the compressed file to the current directory"
    exit -1;
fi
duOutput=`du -s $currentDir`
size=()
readarray -d " " -t size<<<"$duOutput"

if [[ $(( $size[0] )) > 520000 ]];
then
    echo "Warning the file is 520MB. Proceed? [y/n]"
    read input
    if [[ input == "y" ]];
    then
        tar -cvf $1.tar /
    else
        exit 0;
    fi
fi

tar -cvf $1.tar .

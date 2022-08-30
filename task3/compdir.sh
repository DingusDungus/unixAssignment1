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

for file in `pwd`/*;
do 
    echo $file
    
done

if [[ $isSubDir != 1 ]];
then
    echo "Error; dir given is not a subdir to workingdir"
    exit -1;
fi


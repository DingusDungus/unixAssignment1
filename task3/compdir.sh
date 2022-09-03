#!/bin/bash

nrOfParams=$#
dirName=$1
workingDir=$(pwd)

# check number of parameters is 1
if [[ $nrOfParams -gt 1 || $nrOfParams == 0 ]];
then
    echo "compdir.sh: too many or too little parameters given to program (Accepted amount is 1)"
    exit 1;
fi

# check that the directory exists
if [[ ! -d $dirName ]];
then
    echo "compdir.sh: cannot find directory $dirName"
    exit 1;
fi

# check that the directory is a subdirectory to current directory (parent directory)
if [[ $(test -d "$workingDir/$dirName") ]];
then
    echo "compdir.sh: dir given is not a subdir to current working directory"
    exit 1;
fi

# check for write permissions
if [[ ! $(find "$dirName" -maxdepth 0 -writable) == "$dirName" ]];
then
    echo "Cannot write the compressed file to the current directory"
    exit 1;
fi

# get directory size
dirSize=$(du -s "$dirName" | awk "{print \$1}")
# check directory size
if [[ $(( dirSize )) -gt 520000 ]];
then
    read -rp "Warning: the directory is 520MB. Proceed? [y/n]" confirm && [[ $confirm == [yY] ]] || exit 1
fi

tar -cvf "$1.tgz" "$dirName"

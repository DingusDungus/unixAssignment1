#!/bin/bash

nrOfParams=$#
targetDir=$1

# check number of parameters is 1
if [[ $nrOfParams == 0 ]];
then
    echo "No arguments given! Give a directory as input"
    exit 1;
fi
if [[ $nrOfParams -gt 1 ]];
then
    echo "To many arguments given! Give a directory as input"
    exit 1;
fi

# check that the directory exists
if [[ ! -d $targetDir ]];
then
    echo "compdir.sh: cannot find directory $targetDir"
    exit 1;
fi

# check that target is a direct subdirectory of the current directory
if [[ $targetDir == *"/"* ]]; then
    echo "compdir.sh: you must specify a subdirectory"
    exit 1;
fi

# check for write permissions
if [[ $(find "$targetDir" -maxdepth 0 -writable) != "$targetDir" ]];
then
    echo "Cannot write the compressed file to the current directory"
    exit 1;
fi

# get directory size
dirSize=$(du -s "$targetDir" | awk "{print \$1}")
# check directory size
if [[ $(( dirSize )) -lt 512000 ]];
then
    read -rp "Warning: the directory is 512MB. Proceed? [y/n]" confirm && [[ $confirm == [yY] ]] || exit 1
fi

# compress directory
tar -cvf "$1.tgz" "$targetDir"

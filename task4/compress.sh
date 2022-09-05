#!/bin/bash
# write rm <test file>.* to remove all files again

fileName=$1

# define job functions
function gzip_file()
{
    gzip --keep "$1"
}

function bzip2_file()
{
    bzip2 --keep "$1"
}

function p7zip_file()
{
    7z a "$1.7z" "$1" > /dev/null # redirect output to /dev/null since p7zip has no quiet mode.
}

function lzop_file()
{
    lzop -q "$1"
}

# start all jobs in parallel sending filename as a parameter
gzip_file "$fileName" &
bzip2_file "$fileName" &
p7zip_file "$fileName" &
lzop_file "$fileName" &

# wait for all jobs to finish
wait

# get smallest file
smallestFile=$(find . -type f -printf "%p\t%s\n" | grep "$fileName" | sort -n -k2 | head -1)

# check which compression was the best and remove the rest.
case "$smallestFile" in
    *gz*)
        echo "Most compression obtained with gzip, Compressed file is $fileName.gz"
        rm "$fileName.bz2" "$fileName.7z" "$fileName.lzo"
        ;;
    *bz2*)
        echo "Most compression obtained with bzip2, Compressed file is $fileName.bz2"
        rm "$fileName.7z" "$fileName.gz" "$fileName.lzo"
        ;;
    *7z*)
        echo "Most compression obtained with p7zip, Compressed file is $fileName.7z"
        rm "$fileName.bz2" "$fileName.gz" "$fileName.lzo"
        ;;
    *lzo*)
        echo "Most compression obtained with lzop, Compressed file is $fileName.lzo"
        rm "$fileName.7z" "$fileName.bz2" "$fileName.gz"
        ;;
    *)
        echo "original file is the smallest, removing compressed files."
        rm "$fileName.*"
        ;;
esac

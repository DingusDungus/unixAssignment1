#!/bin/bash
# write rm <test file>.* to remove all files again

fileName=$1

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

# get compressed file sizes
originalSize=$(du -s "$fileName" | awk "{print \$1}")
gzipSize=$(du -s "$fileName.gz" | awk "{print \$1.gz}")
bzip2Size=$(du -s "$fileName.bz2" | awk "{print \$1.bz}")
p7zSize=$(du -s "$fileName.7z" | awk "{print \$1.7z}")
lzopSize=$(du -s "$fileName.lzo" | awk "{print \$1.lzo}")

# compare file sizes
if [[ $lzopSize -lt $bzip2Size && $lzopSize -lt $p7zSize && $lzopSize -lt $gzipSize ]];
then
    rm "$fileName.7z" "$fileName.bz2" "$fileName.gz"
    echo "lzop file was smallest, removing the rest!"
elif [[ $bzip2Size -lt $gzipSize && $bzip2Size -lt $p7zSize && $bzip2Size -lt $lzopSize ]];
then
    rm "$fileName.7z" "$fileName.gz" "$fileName.lzo"
    echo "bzip2 file was smallest, removing the rest!"
elif [[ $p7zSize -lt $gzipSize && $p7zSize -lt $bzip2Size && $p7zSize -lt $lzopSize ]];
then
    rm "$fileName.bz2" "$fileName.gz" "$fileName.lzo"
    echo "p7zip file was smallest, removing the rest!"
elif [[ $originalSize -lt $gzipSize && $originalSize -lt $bzip2Size && $originalSize -lt $lzopSize && $originalSize -lt $lzopSize ]];
then
    rm "$fileName.*"
    echo "Original file is smallest, removing all compressed files!"
else
    rm "$fileName.bz2" "$fileName.7z" "$fileName.lzo"
    echo "gzip file was smallest, removing the rest!"
fi

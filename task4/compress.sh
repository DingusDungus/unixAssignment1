#!/bin/bash
# write rm <test file>.* to remove all files again

function gzip_file()
{
    gzip --keep $1
}

function bzip2_file()
{
    bzip2 --keep $1
}

function p7zip_file()
{
    7z a $1 $1 > /dev/null
}

function lzop_file()
{
    lzop -q $1
}

gzip_file $1 &
bzip2_file $1 &
p7zip_file $1 &
lzop_file $1 &

wait

originalSize=$(du -s "$1" | awk "{print \$1}")
gzipSize=$(du -s "$1.gz" | awk "{print \$1.gz}")
bzip2Size=$(du -s "$1.bz2" | awk "{print \$1.bz}")
_7zSize=$(du -s "$1.7z" | awk "{print \$1.7z}")
lzopSize=$(du -s "$1.lzo" | awk "{print \$1.lzo}")

if [[ $(($lzopSize)) -lt $(($bzip2Size)) && $(($lzopSize)) -lt $(($_7zSize)) && $(($lzopSize)) -lt $(($gzipSize)) ]];
then
    rm $1.7z $1.bz2 $1.gz
    echo "lzop file was smallest, removing the rest!"
elif [[ $(($bzip2Size)) -lt $(($gzipSize)) && $(($bzip2Size)) -lt $(($_7zSize)) && $(($bzip2Size)) -lt $(($lzopSize)) ]];
then
    rm $1.7z $1.gz $1.lzo
    echo "bzip2 file was smallest, removing the rest!"
elif [[ $(($_7zSize)) -lt $(($gzipSize)) && $(($_7zSize)) -lt $(($bzip2Size)) && $(($_7zSize)) -lt $(($lzopSize)) ]];
then
    rm $1.bz2 $1.gz $1.lzo
    echo "p7zip file was smallest, removing the rest!"
elif [[ $(($originalSize)) -lt $(($gzipSize)) && $(($originalSize)) -lt $(($bzip2Size)) && $(($originalSize)) -lt $(($lzopSize)) && $(($originalSize)) -lt $(($lzopSize)) ]];
then
    rm $1.*
    echo "Original file is smallest, removing all compressed files!"
else
    rm $1.bz2 $1.7z $1.lzo
    echo "gzip file was smallest, removing the rest!"
fi
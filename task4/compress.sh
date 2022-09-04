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
    7z a $1 $1
}

function lzop_file()
{
    lzop $1
}

gzip_file $1 &
bzip2_file $1 &
p7zip_file $1 &
lzop_file $1 &

wait

gzipSize=`du -s $1.gz`
bzip2Size=`du -s $1.bz2`
7zSize=`du -s $1.7z`
lzopSize=`du -s $1.lz0`

sizeArray=( )
re="^[+-]?[0-9]+([.][0-9]+)?"

foo=$duOutput
for (( i=0; i<${#foo}; i++ )); do
    val=${foo:$i:1};
    if [[ $val =~ $re  ]]; then
        sizeArray+=("$val")
    else
        break
    fi
done
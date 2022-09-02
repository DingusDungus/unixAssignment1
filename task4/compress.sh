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

duOutput=`du -s $1`
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
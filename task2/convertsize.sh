#!/bin/bash

numberArray=( )
sizeArray=( )

declare bytesNumber
declare kbytesNumber
declare mbytesNumber
declare gbytesNumber

re="^[+-]?[0-9]+([.][0-9]+)?"

foo=$1
for (( i=0; i<${#foo}; i++ )); do
    val=${foo:$i:1};
    if [[ $val =~ $re  ]]; then
        numberArray+=("$val")
    else
        sizeArray+=("$val")
    fi
done

IFS='' # set IFS
echo "numberArray with '' IFS: ${numberArray[*]}"
numberString="${numberArray[*]// /}";IFS=$''
sizeString="${sizeArray[*]// /}";IFS=$''
IFS=' ' # reset IFS
echo "numberArray with ' ' IFS: ${numberArray[*]}"
echo "number: ${numberString}"
echo "sizeArray: ${sizeArray[*]}"

if [[ $sizeString == "B" ]]; then
    bytesNumber=$numberString
    number=$numberString
    tempNum=`echo "scale=4; $number/$((2**10))"|bc -l`
    kbytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number/$((2**20))"|bc -l`
    mbytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number/$((2**30))"|bc -l`
    gbytesNumber="$tempNum"
elif [[ $sizeString == "KB" ]]; then
    kbytesNumber=$numberString
    number=$numberString
    tempNum=`echo "scale=4; $number*$((2**10))"|bc -l`
    bytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number/$((2**10))"|bc -l`
    mbytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number/$((2**20))"|bc -l`
    gbytesNumber="$tempNum"
elif [[ $sizeString == "MB" ]]; then
    mbytesNumber=$numberString
    number=$numberString
    tempNum=`echo "scale=4; $number*$((2**20))"|bc -l`
    bytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number*$((2**10))"|bc -l`
    kbytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number/$((2**10))"|bc -l`
    gbytesNumber="$tempNum"
elif [[ $sizeString == "GB" ]]; then
    gbytesNumber=$numberString
    number=$numberString
    tempNum=`echo "scale=4; $number*$((2**30))"|bc -l`
    bytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number*$((2**20))"|bc -l`
    kbytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number*$((2**10))"|bc -l`
    mbytesNumber="$tempNum"
fi

echo Bytes = "$bytesNumber"
echo Kilobytes = "$kbytesNumber"
echo Megabytes = "$mbytesNumber"
echo Gigabytes = "$gbytesNumber"

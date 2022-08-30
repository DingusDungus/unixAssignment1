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
        numberArray+=$val
    else
        sizeArray+=$val
    fi
done

echo $numberArray
echo $sizeArray

if [[ $sizeArray == "B" ]]; then
    bytesNumber=$numberArray
    number=$(( $numberArray ))
    tempNum=`echo "scale=4; $number/$((2**10))"|bc -l`
    kbytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number/$((2**20))"|bc -l`
    mbytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number/$((2**30))"|bc -l`
    gbytesNumber="$tempNum"
elif [[ $sizeArray == "KB" ]]; then
    kbytesNumber=$numberArray
    number=$(( $numberArray ))
    tempNum=`echo "scale=4; $number*$((2**10))"|bc -l`
    bytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number/$((2**10))"|bc -l`
    mbytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number/$((2**20))"|bc -l`
    gbytesNumber="$tempNum"
elif [[ $sizeArray == "MB" ]]; then
    mbytesNumber=$numberArray
    number=$(( $numberArray ))
    tempNum=`echo "scale=4; $number*$((2**20))"|bc -l`
    bytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number*$((2**10))"|bc -l`
    kbytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number/$((2**10))"|bc -l`
    gbytesNumber="$tempNum"
elif [[ $sizeArray == "GB" ]]; then
    gbytesNumber=$numberArray
    number=$(( $numberArray ))
    tempNum=`echo "scale=4; $number*$((2**30))"|bc -l`
    bytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number*$((2**20))"|bc -l`
    kbytesNumber="$tempNum"
    tempNum=`echo "scale=4; $number*$((2**10))"|bc -l`
    mbytesNumber="$tempNum"
fi

echo Bytes = $bytesNumber
echo Kilobytes = $kbytesNumber
echo Megabytes = $mbytesNumber
echo Gigabytes = $gbytesNumber
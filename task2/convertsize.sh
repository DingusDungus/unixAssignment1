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
    bytesNumber=$1
    number=$(( $numberArray ))
    tempNum=`echo $number/1000|bc -l`
    kbytesNumber="$tempNum"KB
    tempNum=`echo $number/1000000|bc -l`
    mbytesNumber="$tempNum"MB
    tempNum=`echo $number/1000000000|bc -l`
    gbytesNumber="$tempNum"GB
elif [[ $sizeArray == "KB" ]]; then
    kbytesNumber=$1
    number=$(( $numberArray ))
    tempNum=`echo $number*1000|bc -l`
    bytesNumber="$tempNum"B
    tempNum=`echo $number/1000|bc -l`
    mbytesNumber="$tempNum"MB
    tempNum=`echo $number/1000000|bc -l`
    gbytesNumber="$tempNum"GB
elif [[ $sizeArray == "MB" ]]; then
    mbytesNumber=$1
    number=$(( $numberArray ))
    tempNum=`echo $number*1000000|bc -l`
    bytesNumber="$tempNum"B
    tempNum=`echo $number*1000|bc -l`
    kbytesNumber="$tempNum"KB
    tempNum=`echo $number/1000|bc -l`
    gbytesNumber="$tempNum"GB
elif [[ $sizeArray == "GB" ]]; then
    gbytesNumber=$1
    number=$(( $numberArray ))
    tempNum=`echo $number*1000000000|bc -l`
    bytesNumber="$tempNum"B
    tempNum=`echo $number*1000000|bc -l`
    kbytesNumber="$tempNum"KB
    tempNum=`echo $number*1000|bc -l`
    mbytesNumber="$tempNum"MB
fi

echo $bytesNumber
echo $kbytesNumber
echo $mbytesNumber
echo $gbytesNumber
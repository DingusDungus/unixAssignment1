#!/bin/bash
 
# if condition is true
if [[ $1 == "hello" ]];
then
    echo "hello equals hello"
fi
 
# if condition is false
if [ "hello" == "bye" ];
then
    echo "hello equals bye"
fi
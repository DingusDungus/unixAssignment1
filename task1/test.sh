#!/bin/bash

# if condition is true
greeting=$1
if [[ $greeting == "hello" ]];
then
    echo "${greeting} equals hello"
fi

# if condition is false
if [ "hello" == "bye" ];
then
    echo "hello equals bye"
fi

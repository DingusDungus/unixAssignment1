#!/bin/bash

re="^[+-]?[0-9]+([.][0-9]+)?"

if [[ !("hello" =~ $re) ]]; then
    echo "It is a number"
else
    echo "it is not a number"
fi
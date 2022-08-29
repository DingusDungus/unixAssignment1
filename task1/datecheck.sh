#!/bin/bash
passed=0;
isLeapYear=0;

if [[ $1 == "1" || $1 == "jan" ]]; then
    if [[ $(($2)) > 0 && $(($2)) < 31 ]]; 
    then
        passed=1;
    fi
elif [[ $1 == "2" || $1 == "feb" ]]; 
then
    if [[ $(($2)) > 0 && $(($2)) < 28 ]]; 
    then
        passed=1;
    elif [[ $(($2)) == 29 ]]
    then
        if [[ $(expr $(($3)) % 4) == 0 ]];
        then
            passed=1;
            isLeapYear=1;
        elif [[ $(expr $(($3)) % 100) == 0 ]];
        then
            if [[ $(expr $(($3)) % 400) == 0 ]];
            then
                passed=1;
                isLeapYear=1;
            fi
        elif [[ $(expr $(($3)) % 400) == 0 ]];
        then
            passed=1;
            isLeapYear=1;
        fi
    fi
elif [[ $1 == "3" || $1 == "mar" ]]; 
then
    if [[ $(($2)) > 0 && $(($2)) < 31 ]]; 
    then
        passed=1;
    fi
elif [[ $1 == "4" || $1 == "apr" ]]; 
then
    if [[ $(($2)) > 0 && $(($2)) < 30 ]]; 
    then
        passed=1;
    fi
elif [[$1 == "5" || $1 == "may"]]; 
then
    if [[ $(($2)) > 0 && $(($2)) < 31 ]]; 
    then
        passed=1;
    fi
elif [[ $1 == "6" || $1 == "jun" ]]; 
then
    if [[ $(($2)) > 0 && $(($2)) < 30 ]]; 
    then
        passed=1;
    fi
elif [[ $1 == "7" || $1 == "jul" ]]; 
then
    if [[ $(($2)) > 0 && $(($2)) < 31 ]]; 
    then
        passed=1;
    fi
elif [[ $1 == "8" || $1 == "aug" ]]; 
then
    if [[ $(($2)) > 0 && $(($2)) < 31 ]]; 
    then
        passed=1;
    fi
elif [[ $1 == "9" || $1 == "sep" ]]; 
then
    if [[ $(($2)) > 0 && $(($2)) < 30 ]]; 
    then
        passed=1;
    fi
elif [[ $1 == "10" || $1 == "okt" ]]; 
then
    if [[ $(($2)) > 0 && $(($2)) < 31 ]]; 
    then
        passed = 1;
    fi
elif [[ $1 == "11" || $1 == "nov" ]]; 
then
    if [[ $(($2)) > 0 && $(($2)) < 30 ]]; 
    then
        passed=1;
    fi
elif [[ $1 == "12" || $1 == "dec" ]]; 
then
    if [[ $(($2)) > 0 && $(($2)) < 31 ]]; 
    then
        passed=1;
    fi
fi

if [[ $passed == 1 ]]; 
then
    echo "It is a valid date"
else
    echo "It is not a valid date"
fi

if [[ $isLeapYear == 1 ]];
then
    echo "It is a leap year"
fi
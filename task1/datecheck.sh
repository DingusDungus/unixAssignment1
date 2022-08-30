#!/bin/bash
passed=0;
isLeapYear=0;

month=$1
day=$2
year=$3

# check dates
case "$month" in
    "1" | "jan")
        if [[ $day -gt 0 && $day -le 31 ]];
        then
            passed=1;
        fi
        ;;
    "2" | "feb") # february (has leap day)
        if [[ $day -gt 0 && $day -le 28 ]];
        then
            passed=1;
        elif [[ $day == 29 ]]
        then
            if [[ $(( year % 4)) == 0 ]]; # step 1
            then
                if [[ $(( year % 100)) == 0 ]]; # step 2
                then
                    if [[ $(( year % 400)) == 0 ]]; # step 3
                    then
                        isLeapYear=1 # step 4
                        passed=1;
                    fi
                else
                    isLeapYear=1 # step 4
                    passed=1;
                fi
            fi # else step 5
        fi
        ;;
    "3" | "mar")
        if [[ $(($2)) -gt 0 && $(($2)) -le 31 ]];
        then
            passed=1;
        fi
        ;;
    "4" | "apr")
        if [[ $(($2)) -gt 0 && $(($2)) -le 30 ]];
        then
            passed=1;
        fi
        ;;
    "5" | "may")
        if [[ $(($2)) -gt 0 && $(($2)) -le 31 ]];
        then
            passed=1;
        fi
        ;;
    "6" | "jun")
        if [[ $(($2)) -gt 0 && $(($2)) -le 30 ]];
        then
            passed=1;
        fi
        ;;
    "7" | "jul")
        if [[ $(($2)) -gt 0 && $(($2)) -le 31 ]];
        then
            passed=1;
        fi
        ;;
    "8" | "aug")
        if [[ $(($2)) -gt 0 && $(($2)) -le 31 ]];
        then
            passed=1;
        fi
        ;;
    "9" | "sep")
        if [[ $(($2)) -gt 0 && $(($2)) -le 30 ]];
        then
            passed=1;
        fi
        ;;
    "10" | "okt")
        if [[ $(($2)) -gt 0 && $(($2)) -le 31 ]];
        then
            passed=1;
        fi
        ;;
    "11" | "nov")
        if [[ $(($2)) -gt 0 && $(($2)) -le 30 ]];
        then
            passed=1;
        fi
        ;;
    "12" | "dec")
        if [[ $(($2)) -gt 0 && $(($2)) -le 31 ]];
        then
            passed=1;
        fi
        ;;
esac

# evaluate results
if [[ $passed == 1 ]];
then
    echo "EXISTS!"
else
    echo "It is not a valid date"
fi

if [[ $isLeapYear == 1 ]];
then
    echo "It is a leap year"
fi

#!/bin/bash
passed=0;
isLeapYear=0;

month=$1
month=${month,,} # make string lowercase
day=$2
year=$3

# check dates
case "$month" in
    "1" | "jan")
        month="Jan"
        if [[ $day -gt 0 && $day -le 31 ]];
        then
            passed=1;
        fi
        ;;
    "2" | "feb") # february (has leap day)
        month="Feb"
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
        month="Mar"
        if [[ $(($2)) -gt 0 && $(($2)) -le 31 ]];
        then
            passed=1;
        fi
        ;;
    "4" | "apr")
        month="Apr"
        if [[ $(($2)) -gt 0 && $(($2)) -le 30 ]];
        then
            passed=1;
        fi
        ;;
    "5" | "may")
        month="May"
        if [[ $(($2)) -gt 0 && $(($2)) -le 31 ]];
        then
            passed=1;
        fi
        ;;
    "6" | "jun")
        month="Jun"
        if [[ $(($2)) -gt 0 && $(($2)) -le 30 ]];
        then
            passed=1;
        fi
        ;;
    "7" | "jul")
        month="Jul"
        if [[ $(($2)) -gt 0 && $(($2)) -le 31 ]];
        then
            passed=1;
        fi
        ;;
    "8" | "aug")
        month="Aug"
        if [[ $(($2)) -gt 0 && $(($2)) -le 31 ]];
        then
            passed=1;
        fi
        ;;
    "9" | "sep")
        month="Sep"
        if [[ $(($2)) -gt 0 && $(($2)) -le 30 ]];
        then
            passed=1;
        fi
        ;;
    "10" | "okt")
        month="Okt"
        if [[ $(($2)) -gt 0 && $(($2)) -le 31 ]];
        then
            passed=1;
        fi
        ;;
    "11" | "nov")
        month="Nov"
        if [[ $(($2)) -gt 0 && $(($2)) -le 30 ]];
        then
            passed=1;
        fi
        ;;
    "12" | "dec")
        month="Dec"
        if [[ $(($2)) -gt 0 && $(($2)) -le 31 ]];
        then
            passed=1;
        fi
        ;;
    *)
        echo "BAD INPUT: Input not recognised."
        exit
        ;;
esac

# evaluate results
case "$month" in
    "Feb")
        if [[ $day == 29 ]];
        then
            if [[ $isLeapYear == 0 ]];
            then
                echo "BAD INPUT: Feb ${year} does not have 29 days: not a leap year."
                exit
            fi
            echo "EXISTS! Feb 29 ${year} is someone's birthday."
            exit
        fi
        if [[ $passed == 0 ]];
        then
            echo "BAD INPUT: Feb does not have ${day} days."
            exit
        fi
        echo "EXISTS! Feb ${day} ${year} is someone's birthday."
        exit
        ;;
    *) # default case
        if [[ $passed == 0 ]];
        then
            echo "BAD INPUT: ${month} does not have ${day} days."
            exit
        fi
        echo "EXISTS! ${month} ${day} ${year} is someone's birthday."
        exit
        ;;
esac

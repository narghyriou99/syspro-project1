#!/bin/bash
echo "I was called with $# parameters"

DUPLICATES=1

if [ $# == 4 ]
then
	echo "No duplicates!"
	DUPLICATES=$4
elif [ $# != 4 ]
then
    echo "Duplicates are allowed!"
fi

#get the file names
VIRUSFILE1=$1
COUNTRYFILE2=$2
NUMLINES=$3

#create the input file
OUTPUT="../source/input.txt"
>$OUTPUT

#other variables
declare -a info_array
declare -a country_array
declare -a virus_array
x=1
country_counter=0
virus_counter=0
#store countries to array
while read line; do
    for word in $line; do
        country_array[country_counter]=$word
        country_counter=$(( $country_counter + 1))
    done
done <$2

#store viruses to array
while read line; do
    for word in $line; do
        virus_array[virus_counter]=$word
        virus_counter=$(( $virus_counter + 1))
    done
done <$1

if [ $DUPLICATES != 0 ] #Duplicates allowed
then
    while [ $x -le $NUMLINES ]
    do
        #id
        ID=$((1 + $RANDOM % 9999))
        
        if [ "${info_array[$ID]}" == "" ]   #Create it for the first time
        then
            #first name and #last name
            #fname length
            LEN=$(( (RANDOM % 10) + 3 ))
            FIRSTNAME=$(cat /dev/urandom | tr -dc 'a-z' | fold -w $LEN | head -n 1)
            
            #lname length
            LEN=$(( (RANDOM % 10) + 3 ))
            LASTNAME=$(cat /dev/urandom | tr -dc 'a-z' | fold -w $LEN | head -n 1)

            #country
            COUNTRY=${country_array[(( (RANDOM % $country_counter)-1))]}

            #age
            AGE=$((1 + $RANDOM % 120))
            
            #Save
            info_array[ID]="$ID $FIRSTNAME $LASTNAME $COUNTRY $AGE"
            INFO=${info_array[ID]}
        else
            INFO=${info_array[ID]}
        fi
        #virus
        VIRUS=${virus_array[(( (RANDOM % $virus_counter)-1))]}

        #isvactinated
        RES=$(( $RANDOM % 2))
        if [ $RES != 0 ]
        then
            ISVACCINATED='NO'
            #printf '%d\n' "$ID">>$OUTPUT
            printf '%s %s %s\n' "$INFO" "$VIRUS" "$ISVACCINATED" >> $OUTPUT
        else
            ISVACCINATED='YES'
            #Date
            #get 3 random numers for day month and year
            #max day is 30
            DAY=$(( (RANDOM % 30) + 1 ))
            #max mon is 12
            MON=$(( (RANDOM % 12) + 1 ))
            #years between 2000 and 2020
            YR=$(( (RANDOM % 25) + 2000 ))
            
            #fix days
            if [ $DAY -lt 10 ]
            then
                DAY=$(echo "0"$DAY"")
            fi

            #fix months
            if [ $MON -lt 10 ]
            then
                MON=$(echo "0"$MON"")	
            fi
            #printf '%d\n' "$ID">>$OUTPUT
            printf '%s %s %s %s-%s-%s\n' "$INFO" "$VIRUS" "$ISVACCINATED" "$DAY" "$MON" "$YR">> $OUTPUT
        fi    
        x=$(( $x + 1))
    done
else    #No duplicates
    if [ $NUMLINES -gt 9999 ]
    then
        echo "NumLines set to 9999!"
        NUMLINES=9999
    fi
    while [ $x -le $NUMLINES ]
    do
        #id
        ID=$((1 + $RANDOM % 9999))
        while [ "${info_array[$ID]}" != "" ]
        do
            ID=$((1 + $RANDOM % 9999))
        done

        #first name and #last name
        #fname length
        LEN=$(( (RANDOM % 10) + 3 ))
        FIRSTNAME=$(cat /dev/urandom | tr -dc 'a-z' | fold -w $LEN | head -n 1)
            
        #lname length
        LEN=$(( (RANDOM % 10) + 3 ))
        LASTNAME=$(cat /dev/urandom | tr -dc 'a-z' | fold -w $LEN | head -n 1)

        #country
        COUNTRY=${country_array[(( (RANDOM % $country_counter)-1))]}

        #age
        AGE=$((1 + $RANDOM % 120))
            
        #Save
        info_array[ID]="$ID $FIRSTNAME $LASTNAME $COUNTRY $AGE"
        INFO=${info_array[ID]}

        #virus
        VIRUS=${virus_array[(( (RANDOM % $virus_counter)-1))]}

        #isvactinated
        RES=$(( $RANDOM % 2))
        if [ $RES != 0 ]
        then
            ISVACCINATED='NO'
            #printf '%d\n' "$ID">>$OUTPUT
            printf '%s %s %s\n' "$INFO" "$VIRUS" "$ISVACCINATED" >> $OUTPUT
        else
            ISVACCINATED='YES'
            #Date
            #get 3 random numers for day month and year
            #max day is 30
            DAY=$(( (RANDOM % 30) + 1 ))
            #max mon is 12
            MON=$(( (RANDOM % 12) + 1 ))
            #years between 2000 and 2020
            YR=$(( (RANDOM % 25) + 2000 ))
            
            #fix days
            if [ $DAY -lt 10 ]
            then
                DAY=$(echo "0"$DAY"")	
            fi

            #fix months
            if [ $MON -lt 10 ]
            then
                MON=$(echo "0"$MON"")	
            fi
            #printf '%d\n' "$ID">>$OUTPUT
            printf '%s %s %s %s-%s-%s\n' "$INFO" "$VIRUS" "$ISVACCINATED" "$DAY" "$MON" "$YR">> $OUTPUT
        fi
        x=$(( $x + 1))
    done
    
fi

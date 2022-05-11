MONTH=$1;
YEAR=$(date +%Y);
#list of months
MONTHS=( "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec" );

#check if month is numeric and if it is convert to MONTHS equivalent
if [ $MONTH type -eq "number" ]; then
    #find the month in the array
    echo "Month is numeric...";
    echo "Converting to text...";
    MONTH=$(echo ${MONTHS[$MONTH]});
    echo "Month is now: $MONTH";
fi

#check if month is in text format and covert it to text format
#yes i know months have different days in the year but i dont care and it won't affect count since the data wouldn't exist 
#(⌐■_■)

#create empty array 
ALL_DAYS=();
SUM=0;
DAYS_USED=0;

for i in {1..31}
do  
    #if i is less than 10, add a 0 to the front
    if [ $i -lt 10 ]; then
        i="0$i";
    fi
    query="$i/$MONTH/$YEAR"
    echo "Querying: $query";
    DATA=$(bash /usr/home/.jbudde/requests.sh $query -d);
    #put the data into a file
    ALL_DAYS+=($DATA);
    echo "$query: $DATA" >> "$YEAR-$MONTH.txt";
done

echo "Calculating Average for $MONTH...";
for i in ${ALL_DAYS[@]}
do
    #if i neq to 0, add it to the sum
    if [ $i -ne 0 ]; then
        SUM=$((SUM+i));
        DAYS_USED=$((DAYS_USED+1));
    fi
done
#divide the SUM by DAYS_USED
AVG=$((SUM/DAYS_USED));

echo "Average: $AVG" >> "$YEAR-$MONTH.txt";

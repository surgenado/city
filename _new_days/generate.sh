#!/bin/bash

TEMPLATE=YYYY-MM-DD-surgenado.md
DATE=date
FORMAT="%Y-%m-%d"
start=`$DATE +$FORMAT -d "2015-11-05"`
end=`$DATE +$FORMAT -d "2015-12-31"`
now=$start
while [[ "$now" < "$end" ]]; do
#  echo $now
  then=`$DATE +$FORMAT -d "$now + 1 week"`
FILE=$then"-surgenado.md"
#  echo $then
# echo $FILE
  cp  -f $TEMPLATE $FILE
  sed -i 's/YYYY-MM-DD/'$then'/g' $FILE
  sed -i 's/YYYY-MM-PP/'$now'/g' $FILE
  mv $FILE ../_posts/$FILE
  now=`$DATE +$FORMAT -d "$now + 1 day"`
done

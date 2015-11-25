#!/bin/bash

interval=15
for hour in `seq 0 23`; do
  declare -i hour
  if [ "$hour" -lt "12" ]; then
  if [ ${#hour} == 1 ]; then
    minutes=00
    while [ $minutes -lt 59 ]; do
      echo $hour":"$minutes "AM"
      echo "0"$hour":"$minutes":00"
      let minutes=$minutes+$interval
    done
  else
    minutes=00
    while [ $minutes -lt 59 ]; do
      echo $hour":"$minutes "AM"
      echo $hour":"$minutes":00"
      let minutes=$minutes+$interval
    done
  fi
else
    declare -i clock
    clock=($hour-12)
    minutes=00
    while [ $minutes -lt 59 ]; do
      echo $clock":"$minutes "PM"
      echo $hour":"$minutes":00"
      let minutes=$minutes+$interval
    done
fi
done

echo end_time
echo clock
echo start_time

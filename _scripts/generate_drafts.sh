#!/bin/bash
set +o noclobber

function dategenerator {
  echo "dategenerator"
DATE=/bin/date
FORMAT="%Y-%m-%d"
start=`$DATE +$FORMAT -d "2015-11-05"`
end=`$DATE +$FORMAT -d "2016-01-31"`
now=$start
while [[ "$now" < "$end" ]]; do
  datestamps+=($now)
  now=`$DATE +$FORMAT -d "$now + 1 day"`
done
}

function timestamp {
  minutes=00
  while [ $minutes -lt 59 ]; do
    time_blocks+=($clock":"$minutes"_$AMPM")
    time_points+=($fullhour":"$minutes":00")
    let minutes=$minutes+$interval
  done
}

function timestampgenerator {
interval=15
for hour in `/usr/bin/seq 4 23`; do
  if [ "$hour" -lt "12" ]; then
    AMPM="AM"
    if [ $hour == 0 ]; then
      clock="12"
    else
      clock=$hour
    fi
  if [ ${#hour} == 1 ]; then
    fullhour="0"$hour
    timestamp
  else
    clock=$hour
    fullhour=$hour
    timestamp
  fi
  else
    declare -i clock
    AMPM="PM"
    if [ $hour == 12 ]; then
      clock=$hour
    else
      clock=$hour-12
    fi
    fullhour=$hour
    timestamp
fi
done
clock="12"
}

function earlytimestampgenerator {
interval=15
for hour in `/usr/bin/seq 0 3`; do
    AMPM="AM"
    if [ $hour == 0 ]; then
      clock="12"
    else
      clock=$hour
    fi
    fullhour="0"$hour
    timestamp
done
}

function datecheck {
  check_time_start=${time_points[$time_block]}
  check_start=${check_time_start:0:3}
  if [[ $check_start == *'00:'* || $check_start == *'01:'* || $check_start == '02:'* || $check_start == *'03:'* ]]; then
  date_start=$day_end
  else
  date_start=$day_start
  fi
  check_time_stop=${time_points[$time_end]}
  check_stop=${check_time_stop:0:3}
  if [[ $check_stop == *'00:'* || $check_stop == *'01:'* || $check_stop == *'02:'* || $check_stop == *'03:'* ]]; then
  date_end=$day_end
  else
  date_end=$day_start
  fi
}

function datetimeblock {
  datecheck
  echo "- time-block: "${time_blocks[$time_block]}
  echo "  date-start: "$date_start
  echo "  date-end: "$date_end
  echo "  time-start: "'"'${time_points[$time_block]}'"'
  echo "  time-end: "'"'${time_points[$time_end]}'"'
}

function dateschedulegenerator {
    date_total=${#time_blocks[@]}
    for time_block in `/usr/bin/seq2 0 $date_total`; do
      declare -i time_stop
      declare -i time_end
      time_stop=$time_block+2
      if [ $time_stop -lt ${#time_blocks[@]} ]; then
        time_end=$time_block+2
        datetimeblock >> $FILE
      elif [ $time_block -lt ${#time_blocks[@]} ]; then
        time_end=$time_stop-${#time_blocks[@]}
        datetimeblock >> $FILE
      fi
    done
}

function header {
  echo  "---"
  echo  "layout: surge2"
  echo  "title: $TITLE"
  echo  "date: $post_day"
  echo  "checkin: $day_start"
  echo  "cal-title: '#SURGENADO'"
  echo  "timezone: $time_zone"
  echo  "timeslots:"
}

function footer {
  echo  "---"
}

function postgenerator {
  echo $FILE
  header > $FILE
  dateschedulegenerator
  footer >> $FILE
}

function dailyschedulegenerator {
  dategenerator
  timestampgenerator
  earlytimestampgenerator
for datestamp in `/usr/bin/seq 0 ${#datestamps[@]}`; do
  declare -i datestamp
  day_start=${datestamps[$datestamp+7]}
  day_end=${datestamps[$datestamp+8]}
  post_day=${datestamps[$datestamp]}
  let datestamp=$datestamp+1
  if [[ -n $day_end ]]; then
  variables
  postgenerator
  fi
done
}

function variables {
TITLE="SURGENADO"
time_zone='"America/Los_Angeles"'
PATH=../_drafts
FILENAME=$post_day-$TITLE".md"
FILE=$PATH/$FILENAME
}

dailyschedulegenerator

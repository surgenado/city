#!/bin/bash

function dategenerator {
DATE=date
FORMAT="%Y-%m-%d"
start=`$DATE +$FORMAT -d "2015-11-23"`
end=`$DATE +$FORMAT -d "2016-01-31"`
now=$start
while [[ "$now" < "$end" ]]; do
  datestamps+=($now)
  now=`$DATE +$FORMAT -d "$now + 1 day"`
done
}

function header {
  echo  "---"
  echo  "layout: surge"
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
  TITLE="SURGENADO"
  time_zone='"America/Los_Angeles"'
  PATH=../_drafts
  FILENAME=$post_day-$TITLE".md"
  FILE=$PATH/$FILENAME
  header > $FILE
  ./create1.sh & $day_start $day_end $FILE
  footer >> $FILE
}

function dailyschedulegenerator {
for datestamp in `/usr/bin/seq 0 ${#datestamps[@]}`; do
  declare -i datestamp
  day_start=${datestamps[$datestamp]}
  day_end=${datestamps[$datestamp+1]}
  post_day=${datestamps[$datestamp-7]}
  let datestamp=$datestamp+1
  echo $day_start
  echo $day_end
  postgenerator
done
}

dategenerator
dailyschedulegenerator

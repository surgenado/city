#!/bin/bash

DATE=date
FORMAT="%Y-%m-%d"
today=`$DATE +$FORMAT`
tomorrow=`$DATE +$FORMAT -d "$now + 1 day"`
yesterday=`$DATE +$FORMAT -d "$now - 1 day"`
last_week=`$DATE +$FORMAT -d "$yesterday - 1 week"`
FILE2ADD=$tomorrow"-SURGENADO.md"
FILE2REMOVE=$last_week"-SURGENADO.md"

mv ../_drafts/$FILE2ADD ../_posts/$FILE2ADD
mv ../_posts/$FILE2REMOVE ../_past/$FILE2REMOVE

echo $FILE2ADD
echo $FILE2REMOVE

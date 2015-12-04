#!/bin/bash

DATE=date
FORMAT="%Y-%m-%d"
today=`$DATE +$FORMAT`
tomorrow=`$DATE +$FORMAT -d "$now + 1 day"`
yesterday=`$DATE +$FORMAT -d "$now - 1 day"`
next_week=`$DATE +$FORMAT -d "$tomorrow + 1 week"`
FILE2ADD=$next_week"-surgenado.md"
FILE2REMOVE=$yesterday"-surgenado.md"

mv ../_drafts/$FILE2ADD ../_posts/$FILE2ADD
rm ../_posts/$FILE2REMOVE

echo $FILE2ADD
echo $FILE2REMOVE

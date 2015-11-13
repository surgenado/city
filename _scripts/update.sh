#!/bin/bash

TEMPLATE=YYYY-MM-DD-surgenado.md
DATE=date
FORMAT="%Y-%m-%d"
today=`$DATE +$FORMAT`
yesterday=`$DATE +$FORMAT -d "$now - 1 day"`
next_week=`$DATE +$FORMAT -d "$now + 1 week"`
FILE2ADD=$next_week"-surgenado.md"
FILE2REMOVE=$yesterday"-surgenado.md"

# mv ../_drafts/$FILE2ADD ../_posts/$FILE2ADD
# rm ../_posts/$FILE2REMOVE

echo $FILE2ADD
echo $FILE2REMOVE

#!/bin/sh
set -e
ERRORS=`python /usr/src/stac_api_validator/validate.py --root ${STAC_URL}  | sed -n '/^errors:$/,$p' | grep -v "1937-01-01" | sed 1,1d > result.txt`
FAILED=`wc -l < result.txt`
echo "Failed test number: "$FAILED
EXPECTED=0 #

if [ "$FAILED" = "$EXPECTED" ]
then
    echo "ALL STAC test succeeded"
else
    echo "Some tests failed:"
    cat result.txt
    exit 1
fi

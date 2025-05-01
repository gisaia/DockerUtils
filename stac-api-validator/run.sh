#!/bin/sh
git apply git.patch
RESULT=`poetry run stac-api-validator --root-url ${STAC_URL} --collection ${STAC_COLLECTION} \
--conformance core \
--conformance features \
--conformance collections \
--conformance item-search \
--conformance item-search#sort \
--conformance features#sort \
--geometry '{"type": "Polygon", "coordinates": [[[-179, 89],[-179,-89 ],[179,-89],[179,89],[-179,89]]]}' > result.txt`
NO_ERROR=`cat result.txt | grep "Errors:"`
EXPECTED="Errors: none"

if [ "$NO_ERROR" = "$EXPECTED" ]
then
    echo "ALL STAC test succeeded"
else
    echo "Some tests failed:"
    cat result.txt
    exit 1
fi
#!/bin/sh
set -e
xmlstarlet edit -L -u "/properties/entry[@key='iut']" -v "${STAC_URL}" test-run-props.xml
java -jar ets-ogcapi-features10.jar -o . test-run-props.xml
TOTAL=$(find testng/* -name 'testng-results.xml' | xargs  xmlstarlet sel -t -v "testng-results/@total")
SKIPPED=$(find testng/* -name 'testng-results.xml' | xargs  xmlstarlet sel -t -v "testng-results/@skipped") 
FAILED=$(find testng/* -name 'testng-results.xml' | xargs  xmlstarlet sel -t -v "testng-results/@failed") 
PASSED=$(find testng/* -name 'testng-results.xml' | xargs  xmlstarlet sel -t -v "testng-results/@passed")

echo "Total test number : "$TOTAL 
echo "Skipped test number : "$SKIPPED 
echo "Failed test number : "$FAILED 
echo "Passed test number : "$PASSED
EXPECTED="1"

if [ "$FAILED" = "$EXPECTED" ]
then 
    echo "ALL STAC test succeeded except 1 as expected"
else
    echo "More than 1 STAC tests failed"
    find testng/* -name 'testng-results.xml' | xargs xmlstarlet fo -t
    exit 1
fi
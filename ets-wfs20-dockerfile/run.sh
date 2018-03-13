#!/bin/sh
set -e
xmlstarlet edit -L -u "/properties/entry[@key='wfs']" -v "${WFS_GETCAPABILITIES_URL}" test-run-props.xml
xmlstarlet edit -L -u "/properties/entry[@key='fid']" -v "${ID}" test-run-props.xml
java -jar ets-wfs20.jar -o . test-run-props.xml 
TOTAL=$(find testng/* -name 'testng-results.xml' | xargs  xmlstarlet sel -t -v "testng-results/@total")
SKIPPED=$(find testng/* -name 'testng-results.xml' | xargs  xmlstarlet sel -t -v "testng-results/@skipped") 
FAILED=$(find testng/* -name 'testng-results.xml' | xargs  xmlstarlet sel -t -v "testng-results/@failed") 
PASSED=$(find testng/* -name 'testng-results.xml' | xargs  xmlstarlet sel -t -v "testng-results/@passed")

echo "Total test number : "$TOTAL 
echo "Skipped test number : "$SKIPPED 
echo "Failed test number : "$FAILED 
echo "Passed test number : "$PASSED
ZERO="0"

if [ "$FAILED" = "$ZERO" ]
then 
    echo "ALL WFS test succes"
else
    echo "A WFS test failed"
    find testng/* -name 'testng-results.xml' | xargs xmlstarlet fo -t
    exit 1
fi
#!/bin/sh
set -e
xmlstarlet edit -L -u "/properties/entry[@key='iut']" -v "${CSW_GETCAPABILITIES_URL}" test-run-props.xml
java -jar ets-cat30.jar -o . test-run-props.xml 
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
    echo "ALL CSW test succes"
else
    echo "A CSW test failed"
    find testng/* -name 'testng-results.xml' | xargs xmlstarlet fo -t
    exit 1
fi
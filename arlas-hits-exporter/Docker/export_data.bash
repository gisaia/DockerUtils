#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

usage(){
	echo "USAGE : ./export_data.bash --search_url=X --include=Y --format=Z --sort_csv=V"
	echo " --search_url            Search request url which result is exported. Put the url between double or simple quotes."
	echo " --include               Comma separated field names/paths to include in the exported file"
	echo " --format                Export format : json | csv"
	echo " --sort_csv              Columns of csv to sort on  : -k1 -k2"
	echo " --output                Folder where exported data is generated"
	exit 1
}

for i in "$@"
do
case "$i" in
    --search_url=*)
    SEARCH_URL="${i#*=}"
    shift # past argument=value
    ;;
    --include=*)
    INCLUDE="${i#*=}"
    shift # past argument=value
    ;;
    --format=*)
    FORMAT="${i#*=}"
    shift # past argument=value
    ;;
    --sort_csv=*)
    SORT_CSV="${i#*=}"
    shift # past argument=value
    ;;
    --output=*)
    OUTPUT="${i#*=}"
    shift # past argument=value
    ;;
    *)
    # unknown option
    ;;
esac
done
if [ ! -v SEARCH_URL ]; then >&2 echo "ERROR : --search_url argument is missing "; usage; else echo "### Your search request is ==> ${SEARCH_URL}"; fi
if [ ! -v INCLUDE ]; then >&2 echo "ERROR : --include argument is missing"; usage; else echo "### Fields to export ==> ${INCLUDE}"; fi
if [ ! -v OUTPUT ]; then OUTPUT=$PWD; echo  "### Output file ==> ${OUTPUT}" else echo "### Output file ==> ${OUTPUT}"; fi
FORMAT="${FORMAT:-json}"
echo "### Export format ==> ${FORMAT}"
if [ "${FORMAT}" != "csv" ] && [ "${FORMAT}" != "json" ]; then
    >&2 echo "ERROR : --format argument must be 'json' or 'csv'"
    exit 1
fi

## CONCATENATE FIELDS TO INCLUDE TO THE URL
SEARCH_URL="${SEARCH_URL}&include=${INCLUDE}"
## LAUNCH THE FIRST REQUEST
curl -X GET "${SEARCH_URL}" -H "accept: application/json;charset=utf-8" > tmp_search_response.txt
nbhits=$(jq '.nbhits' tmp_search_response.txt)
if [ "$nbhits" -ne 0 ]
then 
    ## SELECT `hits.data` IN tmp_search_response.txt
    jq '.hits[] | .data' tmp_search_response.txt > tmp.txt
    if [ "${FORMAT}" == "csv" ]; then
        ## CREATE CSV FILE CONTAINING THE FIRST RESPONSE BLOC
        json2csv -i tmp.txt -d ';' -o exported_data.csv -f ${INCLUDE}
        echo >> exported_data.csv
    else
        ## CREATE JSON FILE CONTAINING THE FIRST RESPONSE BLOC
        cat tmp.txt > non_formatted_data.json
    fi
    ## GET THE FOLLOWING REQUEST FROM 'links.next.href'
    T=$(jq .links.next.href tmp_search_response.txt)
    while [ "${T}" != "null" ]
        do
            curl -X GET ${T//\"} -H "accept: application/json;charset=utf-8" > tmp_search_response.txt
            nbhits=$(jq '.nbhits' tmp_search_response.txt)
            if [ "$nbhits" -eq 0 ]
            then 
                break
            fi
            jq '.hits[] | .data' tmp_search_response.txt > tmp.txt
            if [ "${FORMAT}" == "csv" ]; then
                ## APPEND THE RESPONSE TO THE EXISTING CSV FILE
                json2csv -i tmp.txt -d ';' -f ${INCLUDE} -H >> exported_data.csv
                echo >> exported_data.csv
            else
                ## APPEND THE RESPONSE TO THE EXISTING JSON FILE
                cat tmp.txt >> non_formatted_data.json
            fi
            T=$(jq .links.next.href tmp_search_response.txt)

        done
    if [ "${FORMAT}" == "csv" ]; then
        if [ -v SORT_CSV ]; then
            ## SORT CSV
            echo "### Sorting CSV"
            (head -n1 exported_data.csv && sort -t ';' ${SORT_CSV} <(tail -n+2 exported_data.csv))>sorted_exported_data.csv
            mv sorted_exported_data.csv exported_data.csv
            echo "==> CSV sorted"

        fi
        mv exported_data.csv "${OUTPUT}/exported_data.csv"
        echo "### Successfull CSV export"
    else
        ## FORMAT JSON FILE
        jq -s '.' non_formatted_data.json > exported_data.json
        rm non_formatted_data.json
        mv exported_data.json "${OUTPUT}/exported_data.json"
        echo "### Successfull JSON export"
    fi
    
else
    touch tmp.txt
    if [ "${FORMAT}" == "csv" ]; then
        json2csv -i tmp.txt -d ';' -o exported_data.csv -f ${INCLUDE}
        mv exported_data.csv "${OUTPUT}/exported_data.csv"
        echo "### Successfull CSV export"
    else
        echo '[]' > exported_data.json
        mv exported_data.json "${OUTPUT}/exported_data.json"
        echo "### Successfull JSON export"
    fi
fi
rm -f tmp.txt tmp_search_response.txt

#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

usage(){
	echo "USAGE : ./export_data.bash --search_url=X --include=Y --format=Z --auth=token --token=T"
	echo " --search_url            Search request url which result is exported. Put the url between double or simple quotes."
	echo " --include               Comma separated field names/paths to include in the exported file"
	echo " --format                Export format : json | csv"
	echo " --output                Folder where exported data is generated"
	echo " --auth                  Type of authentication to ARLAS-server. Availabe options: 'basic' and 'token'"
	echo " --token                 Token to pass to the request if --auth=token"
	exit 1
}
for i in "$@"
do
case "$i" in
    --help)
    usage
    shift # past argument=value
    ;;
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
    --auth=*)
    AUTH="${i#*=}"
    shift # past argument=value
    ;;
    --token=*)
    TOKEN="${i#*=}"
    shift # past argument=value
    ;;
    *)
    # unknown option
    ;;
esac
done
echo ""
if [ ! -v SEARCH_URL ]; then >&2 echo "ERROR : --search_url argument is missing "; usage; else echo "- Your search request is ==> ${SEARCH_URL}"; fi
echo ""
if [ ! -v INCLUDE ]; then >&2 echo "ERROR : --include argument is missing"; usage; else echo "- Fields to export ==> ${INCLUDE}"; fi
echo ""
if [ ! -v OUTPUT ]; then OUTPUT=$PWD; echo  "- Output file      ==> ${OUTPUT}"; else echo "- Output file ==> ${OUTPUT}"; fi
echo ""
FORMAT="${FORMAT:-json}"
echo "- Export format    ==> ${FORMAT}"
echo ""
if [ "${FORMAT}" != "csv" ] && [ "${FORMAT}" != "json" ]; then
    >&2 echo "ERROR : --format argument must be 'json' or 'csv'"
    exit 1
fi
login=""
password=""
if [ -v AUTH ]; then
    if [ "${AUTH}" == "basic" ]; then
			echo "- Set credentials to connect to ARLAS-server (press enter to skip if no credentials needed)   ==>"
			echo -n Login:
			read login
			echo -n Password:
			read -s password
			echo
    else if [ "${AUTH}" == "token" ]; then
			if [ ! -v TOKEN ]; then >&2 echo "ERROR : --token argument is missing "; usage; 
            fi
		else
			>&2 echo "ERROR : unknown authentication type '$AUTH'. Abort..."
			usage
			exit 1
        fi
    fi
fi

# Run Command
## CONCATENATE FIELDS TO INCLUDE TO THE URL
SEARCH_URL="${SEARCH_URL}&include=${INCLUDE}"
## LAUNCH THE FIRST REQUEST
http_response_code=$(curl -k -X GET "${SEARCH_URL}" -w "%{http_code}" -H "accept: application/json;charset=utf-8" -o tmp_search_response.txt)
if [ -v AUTH ]; then
    if [ "${AUTH}" == "basic" ]; then
        http_response_code=$(curl -k -X GET "${SEARCH_URL}" -u "${login}:${password}" -w "%{http_code}" -H "accept: application/json;charset=utf-8" -o tmp_search_response.txt)
    else if [ "${AUTH}" == "token" ]; then
			if [ ! -v TOKEN ]; then >&2 echo "ERROR : --token argument is missing "; usage; fi
			http_response_code=$(curl -k -X GET "${SEARCH_URL}"  -w "%{http_code}" -H "authorization: Basic ${TOKEN}" -H "accept: application/json;charset=utf-8" -o tmp_search_response.txt)
		else
			>&2 echo "ERROR : unknown authentication type '$AUTH'. Abort..."
			usage
			exit 1
        fi
    fi
fi
if [ $http_response_code == "200" ]; then
    nbhits=$(jq '.nbhits' tmp_search_response.txt)
else
    echo
    echo "Failed to parse data: "
    echo
    cat tmp_search_response.txt
fi
if [ -v nbhits ] && [ "$nbhits" -ne 0 ]
then
    ## SELECT `hits.data` IN tmp_search_response.txt
    jq '.hits[] | .data' tmp_search_response.txt > tmp.txt
    if [ "${FORMAT}" == "csv" ]; then
        ## CREATE CSV FILE CONTAINING THE FIRST RESPONSE BLOC
        json2csv -i tmp.txt -d ';' -o csv_exported_data.csv -f ${INCLUDE}
        echo >> csv_exported_data.csv
    else
        ## CREATE JSON FILE CONTAINING THE FIRST RESPONSE BLOC
        cat tmp.txt > non_formatted_data.json
    fi
    ## GET THE FOLLOWING REQUEST FROM 'links.next.href'
    T=$(jq .links.next.href tmp_search_response.txt)
    while [ "${T}" != "null" ]
        do
            if [ -v AUTH ]; then
                if [ "${AUTH}" == "basic" ]; then
                        curl -k -X  GET ${T//\"} -u ${login}:${password} -H "accept: application/json;charset=utf-8"  -o tmp_search_response.txt
                 else if [ "${AUTH}" == "token" ]; then
			            if [ ! -v TOKEN ]; then >&2 echo "ERROR : --token argument is missing "; usage; fi
                        curl -k -X  GET ${T//\"}  -H "accept: application/json;charset=utf-8"  -H "authorization: Basic ${TOKEN}" -o tmp_search_response.txt
		                else
			                >&2 echo "ERROR : unknown authentication type '$AUTH'. Abort..."
			                usage
			                exit 1
                        fi
                fi
            else 
                curl -k -X  GET ${T//\"}  -H "accept: application/json;charset=utf-8"  -o tmp_search_response.txt
            fi
            nbhits=$(jq '.nbhits' tmp_search_response.txt)
            if [ "$nbhits" -eq 0 ]
            then
                break
            fi
            jq '.hits[] | .data' tmp_search_response.txt > tmp.txt
            if [ "${FORMAT}" == "csv" ]; then
                ## APPEND THE RESPONSE TO THE EXISTING CSV FILE
                json2csv -i tmp.txt -d ';' -f ${INCLUDE} -H >> csv_exported_data.csv
                echo >> csv_exported_data.csv
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
            (head -n1 csv_exported_data.csv && sort -t ';' ${SORT_CSV} <(tail -n+2 exported_data.csv))>sorted_exported_data.csv
            mv sorted_exported_data.csv csv_exported_data.csv
            echo "==> CSV sorted"
        else
            mv csv_exported_data.csv "${OUTPUT}/exported_data.csv"
        fi
        echo "### Successfull CSV export"
    else
        ## FORMAT JSON FILE
        jq -s '.' non_formatted_data.json > exported_data.json
        rm non_formatted_data.json
        mv exported_data.json "${OUTPUT}/exported_data.json"
        echo "### Successfull JSON export"
    fi

else
    if [ ! -v nbhits ]; then
        echo "No data exported"
    else
        touch tmp.txt
        if [ "${FORMAT}" == "csv" ]; then
            json2csv -i tmp.txt -d ';' -o csv_exported_data.csv -f ${INCLUDE}
            mv csv_exported_data.csv "${OUTPUT}/exported_data.csv"
            echo "### Successfull CSV export"
        else
            echo '[]' > json_exported_data.json
            mv json_exported_data.json "${OUTPUT}/exported_data.json"
            echo "### Successfull JSON export"
        fi
    fi
fi
rm -f tmp.txt tmp_search_response.txt

#!/bin/bash


###########################################
#---) Establish Operating Variables (-----#
###########################################

HOST="1"
WRITEABLE="1"
PROBLEMS=""
TARGETFILE=""
OUTPUT=""
VERBOSE=0
HELP="$(base64 -d <<< ICAgICAgICAgICAgICAgICAgICAgIC4gICAgICAgICAgICAgICAgIAosLS4gLC0uICwtLiAsLS4gLC0uICwtfCAuICwgLC0uICwtLiAsLS4gCnwgICB8LScgfCAgIHwgfCB8ICAgfCB8IHwvICB8LScgfC0nIHwgfCAKJyAgIGAtJyBgLScgYC0nICcgICBgLScgfFwgIGAtJyBgLScgfC0nIAogICAgICAgICAgICAgICAgICAgICAgICAnIGAgICAgICAgICB8ICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICcgICAKCg==)
This tool uses 'host -A' to retrieve any and all DNS records belonging to target hosts.

	  Use -h To show this message.
	  Use -o To specify the file to write to.
	  Use -t To specify the file containing the target FQDNs. Delimited by line.

If some FQDNs, which you are certain have associated DNS records, do not return anything, try changing your router's DNS server to a static and reliable one. I recommend 1.1.1.1 (Cloudflare) and 8.8.8.8 (Google).\n"
OPTIND=1

###########################################
#--------) Establish Problems (-----------#
###########################################
# --) Host command exists?
# --) Writeable forlder?

if ! [ -x "$(command -v host)" ]; then
	HOST=""
	PROBLEMS="$PROBLEMS Host command not found."
fi

if ! [ -w "$(pwd)" ]; then
	WRITEABLE=""
	PROBLEMS="$PROBLEMS Current directory not writeable."
fi

###########################################
#--------) Ingest CLI Arguments (---------#
###########################################
# --) Targets file
# --) If problems, exit.

while getopts "h?t:o:v" opt; do
	case "$opt" in 
	h|\?) printf "$HELP"; exit 0;;
	t)	TARGETFILE=$OPTARG;;
	o)	OUTPUT=$OPTARG;;
	v)	VERBOSE=1;;
	esac
done

if [ "$PROBLEMS" ]; then
	echo "$PROBLEMS"
	exit 0
fi

###########################################
#-----------) Perform Lookup (------------#
###########################################

if ! [ $OUTPUT ]; then

while IFS="" read -r domain || [ -n "$domain" ]; do

	if [ $VERBOSE ]; then
		printf "[+] Performing lookup on $domain \n"
	fi
	
	host -A $domain | awk '{ if (!a && $0~/ANSWER SECTION/) {a=1;next;} } a' | grep $domain | awk '{ printf $4 "\t" $1 "\t" $5 "\t" $6 "\n"}'
done < $TARGETFILE
fi

if [ $OUTPUT ]; then

while IFS="" read -r domain || [ -n "$domain" ]; do

	if [ $VERBOSE ]; then
		printf "[+] Performing lookup on $domain \n"
	fi

	host -A $domain | awk '{ if (!a && $0~/ANSWER SECTION/) {a=1;next;} } a' | grep $domain | awk '{ printf $4 "\t" $1 "\t" $5 "\t" $6 "\n"}' >> $OUTPUT
done < $TARGETFILE
fi
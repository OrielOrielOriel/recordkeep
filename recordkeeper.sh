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
HELP="Help screen\n"
OPTIND=1

###########################################
#--------) Establish Problems (-----------#
###########################################
# --) Host command exists?
# --) Writeable forlder?

if ! [ -x "$(command -v host)" ]; then
	HOST=""
	PROBLEMS="$PROBLEMS\
	Host command not found."
fi

if ! [ -w "$(pwd)" ]; then
	WRITEABLE=""
	PROBLEMS="$PROBLEMS\
	Current directory not writeable."
fi

###########################################
#--------) Ingest CLI Arguments (---------#
###########################################
# --) Targets file

while getopts "h?t:o:v" opt; do
	case "$opt" in 
	h|\?) printf "$HELP"; exit 0;;
	t)	TARGETFILE=$OPTARG;;
	o)	OUTPUT=$OPTARG;;
	v)	VERBOSE=1;;
	esac
done

###########################################
#-----------) Perform Lookup (------------#
###########################################

if ! [ $OUTPUT ]; then

while IFS="" read -r domain || [ -n "$domain" ]; do

	if [ $VERBOSE ]; then
		printf "[+] Performing lookup on $domain \n"
	fi
	
	host -a $domain | awk '{ if (!a && $0~/ANSWER SECTION/) {a=1;next;} } a' | grep $domain | awk '{ printf $4 "\t" $1 "\t" $5 "\t" $6 "\n"}'

done < $TARGETFILE
fi

if [ $OUTPUT ]; then

while IFS="" read -r domain || [ -n "$domain" ]; do

	if [ $VERBOSE ]; then
		printf "[+] Performing lookup on $domain \n"
	fi

	host -a $domain | awk '{ if (!a && $0~/ANSWER SECTION/) {a=1;next;} } a' | grep $domain | awk '{ printf $4 "\t" $1 "\t" $5 "\t" $6 "\n"}' >> $OUTPUT
done < $TARGETFILE
fi
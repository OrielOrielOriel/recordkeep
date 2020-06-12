#!/bin/bash


###########################################
#---) Establish Operating Variables (-----#
###########################################

HOST="1"
WRITEABLE="1"
PROBLEMS=""
TARGETFILE=""
OUTPUT=""
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

while getopts "h?t:" opt; do
	case "$opt" in 
	h|\?) printf "$HELP"; exit 0;;
	t)	TARGETFILE=$OPTARG;;
	o)	OUTPUT=$OPTARG;;
	esac
done


while IFS="" read -r domain || [ -n "$domain" ]; do
  host -a $domain | awk '{ if (!a && $0~/ANSWER SECTION/) {a=1;next;} } a' | grep $domain | awk 
done < $TARGETFILE
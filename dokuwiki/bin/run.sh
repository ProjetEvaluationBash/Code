#!/bin/bash

[ -z "$HOME" ] && export HOME=/home/info

set -a
. $HOME/Code/.evalrc
set +a

# Suppression des fichiers temporaires à la fin du script
# Motif : /tmp/*-$$.tmp ($$ = pid du processus)

trap  "rm -f /tmp/*-$$.tmp" 0

log() {
	echo "$(date) $@" >> $LOG_FILE
}

auth() {
	DokuUser=$(cookie DokuUser)
	local DokuToken=$(cookie DokuToken)
	local dbHash=$(grep "$DokuUser" $DB_FILE | cut -d ' ' -f 2)

	#echo "DokuUser=$DokuUser."
	#echo "DokuToken=$DokuToken."
	#echo "dbHash=$dbHash."
	

	if ! php -r "if (password_verify('$DokuToken', '$dbHash')) { exit(0); } else { exit(1); }"; then
        	echo "Bad authentification !"
        	log "from $REMOTE_ADDR :  bad authentification ($DokuUser)"
        	exit 1
	fi
}

userIsProf() {
	echo "$PROFS" | egrep -q '\<'$DokuUser'\>' 
}


cgiHeader() {
        echo Content-type: text/html
        echo 
}

redirect() {

        cat << EOF
<html>
<head>
<title></title>
<meta http-equiv="refresh" content="0; URL=$DOKU_URL?id=$1">
</head>
<body>
</body>
 
</html>
EOF

}


# main

. $DOKU_EVAL/bin/bashlib

if [ -z "$RUN_BIN" ]; then
	echo "Error : init : variable RUN_BIN is empty !" >&2
	exit 1
fi

auth

export PATH="$PATH:$RUN_BIN"

request=$(param action)

if [ -e $DOKU_EVAL/bin/requests/$request.sh ]; then
	. $DOKU_EVAL/bin/requests/$request.sh
else
	. $DOKU_EVAL/bin/requests/debug.sh
fi

runRequest


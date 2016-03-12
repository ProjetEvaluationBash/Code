#!/bin/bash

runRequest() {
	local out=$DOKU_USERS_DIR/$DokuUser/modules.txt
	local list=$(ls $DB_MODULES_DIR)

        cat << EOF > $out
====== Choix du module ======
EOF

	for m in $list; do

  		echo "  * [[https://fraise.u-clermont1.fr/info/cgi-bin/run.sh?module=$m&action=mainModule|$m]]" >> $out
	done


	cgiHeader
	redirect users:$DokuUser:modules
}



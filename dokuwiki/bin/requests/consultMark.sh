#!/bin/bash

runRequest() {
        cat << EOF > $DOKU_USERS_DIR/$DokuUser/all_notes.txt
===== Consultation des notes =====

<html>
<h3>Consulter les notes de $DokuUser:</h3>
<br>
</html>
EOF

	cgiHeader
	redirect users:$DokuUser:all_notes
}


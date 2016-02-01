#!/bin/bash

runRequest() {
        cat << EOF > $DOKU_USERS_DIR/$DokuUser/all_notes.txt
===== Execution avec retour dans une iframe (module $(param module)) =====

<html>
<h3>Consulter les notes de $DokuUser:</h3>
<br>
<br>
<iframe name="output1" width="90%" height="250" frameborder="1"></iframe>
</html>
EOF

	cgiHeader
	redirect users:$DokuUser:consult_mark
}


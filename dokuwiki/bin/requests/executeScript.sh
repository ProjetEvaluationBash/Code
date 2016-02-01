#!/bin/bash

runRequest() {
        cat << EOF > $DOKU_USERS_DIR/$DokuUser/execute_script.txt
===== Execution avec retour dans une iframe (module $(param module)) =====

<html>
<form name="myForm" action="https://fraise.u-clermont1.fr/info/cgi-bin/run.sh" method="POST" target="output1">
<input type="hidden" name="module" value="$module">
<input type="hidden" name="action" value="script">
<textarea cols="80" rows="10" name="script"></textarea>
<br>
<input type="submit" value="Ok">
</form>
<br>
<br>
<iframe name="output1" width="90%" height="250" frameborder="1"></iframe>
</html>
EOF

	cgiHeader
	redirect users:$DokuUser:execute_script
}


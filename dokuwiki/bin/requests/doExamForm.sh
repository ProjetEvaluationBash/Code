#!/bin/bash

runRequest(){
	
	local dokuName=do_exam_form
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)

        cat << EOF > $out
====== Générer un test a propros du module $module =====
<html>
<form name="myForm" action="$DOKU_CGI" method="POST">
<input type="hidden" name="module" value="$module">
<input type="hidden" name="action" value="doExam">
<p>
Nom de l'examen:
<input type="text" name="name" value="">
<p>
</br>
<p>
<input type="submit" value="Faire l'examen">
</form>
</html>

EOF

	cgiHeader
        redirect users:$DokuUser:$dokuName 

}

#!/bin/bash

runRequest() {
	local dokuName=mv_exam_form
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local exam=$(param exam)

	if userIsProf; then
		dokuError "Désolé, fonction réservée aux enseignants !"
	fi

	cat << EOF > $out
====== Renommage d'un examen (module $module) ======

<html>

Renommage de l'examen $exam (module $module).

<form name="myForm" action="$DOKU_CGI" method="POST">
<input type="hidden" name="module" value="$module">
<input type="hidden" name="examSrc" value="$exam">
<input type="hidden" name="action" value="mvExamTest">
<p>
Nouveau nom de l'examem: $DokuUser-
<input type="text" name="examDst" value="">
<p>
<input type="submit" value="Renommer">
</form>
</html>

EOF
        redirect users:$DokuUser:$dokuName
}

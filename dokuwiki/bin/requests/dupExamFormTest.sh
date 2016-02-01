#!/bin/bash

runRequest() {
	local dokuName=dup_exam_form
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local exam=$(param exam)

	if userIsProf; then
		dokuError "Désolé, fonction réservée aux enseignants !"
	fi

	cat << EOF > $out
====== Duplication d'un examen (module $module) ======

<html>

Duplication de l'examen $exam (module $module).

<form name="myForm" action="$DOKU_CGI" method="POST">
<input type="hidden" name="module" value="$module">
<input type="hidden" name="examSrc" value="$exam">
<input type="hidden" name="action" value="dupExamTest">
<p>
Nom de la copie de l'examem: $DokuUser-
<input type="text" name="examDst" value="">
<p>
<input type="submit" value="Créer">
</form>
</html>

EOF
        redirect users:$DokuUser:$dokuName
}

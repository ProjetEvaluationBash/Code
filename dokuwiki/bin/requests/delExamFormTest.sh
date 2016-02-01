#!/bin/bash

runRequest() {
	local dokuName=del_exam_form
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local exam=$(param exam)

	if userIsProf; then
		dokuError "Désolé, fonction réservée aux enseignants !"
	fi

	cat << EOF > $out
====== Suppression d'un examen (module $module) ======

<html>
Confirmez la supression de l'examen $exam du module $module !
<form name="myForm1" action="$DOKU_CGI" method="POST">
<input type="hidden" name="module" value="$module">
<input type="hidden" name="exam" value="$exam">
<input type="hidden" name="action" value="delExamTest">
<input type="submit" value="Suppression">
</form>
<form name="myForm1" action="$DOKU_CGI" method="POST">
<input type="hidden" name="module" value="$module">
<input type="hidden" name="action" value="manageExamTest">
<input type="submit" value="Annuler">
</form>

</html>

EOF
        redirect users:$DokuUser:$dokuName
}

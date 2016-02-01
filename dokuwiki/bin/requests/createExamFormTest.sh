#!/bin/bash

runRequest() {
	local dokuName=create_exam_form
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)

	if userIsProf; then
		dokuError "Désolé, fonction réservée aux enseignants !"
	fi

	cat << EOF > $out
====== Création d'un nouvel examen (module $module) ======

<html>
<form name="myForm" action="$DOKU_CGI" method="POST">
<input type="hidden" name="module" value="$module">
<input type="hidden" name="action" value="createExamTest">
<p>
Nom de l'examem: $DokuUser-
<input type="text" name="name" value="">
<p>
</br></br>
Liste des questions :
<input type="text" name="list" value="">
<p>
<input type="submit" value="Créer">
</form>
</html>

EOF
        redirect users:$DokuUser:$dokuName
}

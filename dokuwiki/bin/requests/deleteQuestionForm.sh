#!/bin/bash

runRequest() {
	local dokuName=delete_question_form
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)

	if userIsProf;tjen
		dokuError "Désolé, fonction réservée aux enseignants !"
	fi

	cat << EOF > $out

======= Supression de questions de la base de données (module $module) ======

<html>
<form name="myForm" action="$DOKU_CGI" method="POST">
<input type="hidden" name="module" value="$module">
<input type="hidden" name="action" value="deleteQuestion">
<p>
Question à supprimer :
<input type="test" name="list" value="">
<p>
<input type="submit" value="Valider la suppression des questions">
</form>
</html>

EOF
	redirect users:$DokuUser:$dokuName
}

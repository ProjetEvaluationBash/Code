#!/bin/bash

runRequest() {
	local dokuName=mod_exam_form
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local exam=$(param exam)

	local examsDir=$DB_USERS_DIR/$DokuUser/$module/exams

	if userIsProf; then
		dokuError "Désolé, fonction réservée aux enseignants !"
	fi

        if [ ! -e $examsDir/$exam ]; then
                dokuError "L'examen $exam n'existe pas !"
                return 1
        fi

	list="$(cat $examsDir/$exam/list)"

	cat << EOF > $out
====== Modification d'un examen (module $module) ======

Examen $exam :

<note warning>
La validation provoquera l'importation des dernières version des questions !
Et cela que la liste soit changée ou non.
</note>

<html>
<form name="myForm" action="$DOKU_CGI" method="POST">
<input type="hidden" name="module" value="$module">
<input type="hidden" name="name" value="$exam">
<input type="hidden" name="action" value="modExamTest">
<p>
Liste des questions :
<input type="text" name="list" value="$list">
<p>
<input type="submit" value="Modifier">
</form>
</html>

EOF
        redirect users:$DokuUser:$dokuName
}

#!/bin/bash

runRequest() {
	local dokuName=find_question_by_keywords_form
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)

	if userIsProf;then
		dokuError "Désolé, fonction réservée aux enseignants !"
	fi

	cat << EOF > $out

======= Recherche des questions par rapport aux mots clés recherchés (module $module) ======

<html>
<form name="myForm" action="$DOKU_CGI" method="POST">
<iinput type="hidden" name="module" value="$module">
<input type="hidden" name="action" value="findQuestionByKeywords">
<p>
Mot clé recherché :
<input type="test" name="list" value="">
<p>
<input type="submit" value="Rechercher">
</form>
</html>

EOF
	redirect users:$DokuUser:$dokuName
}

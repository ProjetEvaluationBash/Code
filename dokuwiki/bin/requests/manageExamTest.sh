#!/bin/bash

showExamItem() {
	cat << EOF >> $out
  * [[$DOKU_CGI?module=$module&exam=$1&action=showExamTest|$1]] ([[$DOKU_CGI?module=$module&exam=$1&action=modExamFormTest|modifier]] - [[$DOKU_CGI?module=$module&exam=$1&action=dupExamFormTest|dupliquer]] - [[$DOKU_CGI?module=$module&exam=$1&action=mvExamFormTest|renommer]] - [[$DOKU_CGI?module=$module&exam=$1&action=delExamFormTest|supprimer]])
EOF
}

runRequest() {
	local dokuName=manage_exam
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)

	if userIsProf; then
		dokuError "Désolé, fonction réservée aux enseignants !"
	fi

	cat << EOF > $out
====== Gestion des examens du module ($module) ======

  * [[$DOKU_CGI?module=$module&action=listExamQuestionsTest|Liste des questions d'examens]]
  * [[$DOKU_CGI?module=$module&action=createExamFormTest|Créer un nouvel examen]]

===== Liste des examens =====

EOF

	local list="$(ls $DB_USERS_DIR/$DokuUser/$module/exams)"
	

	if [ -z "$list" ]; then
		echo "Aucun examen encore défini !" >> $out
	else
		for i in $list; do
			showExamItem $i
		done
	fi

        redirect users:$DokuUser:$dokuName
}

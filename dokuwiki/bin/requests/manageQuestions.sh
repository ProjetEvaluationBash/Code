#!/bin/bash

function runRequest() {
	local dokuName=manage_questions
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
        local module=$(param module)

	# Verifier que l'utilisateur est un professeur
	if userIsProf; then
		dokuError "Désolé, fonction réservée aux enseignants !"
	fi


	# Definir où sont stockés les questions
	QUESTIONPATH=$DB_MODULES_DIR/$module/questions

        cat << EOF > $out
	
====== Gestion des questions ======

[[$DOKU_CGI?module=$module&action=addQuestionForm|Ajouter une question]]

===== Questions =====

EOF

	# Inclure Question.sh
	source "$CODE_DIR/Question.sh"

	# Parcours de toutes les questions du module
	for i in $(cd $QUESTIONPATH; ls *.txt | sed -re 's/\.txt$//' | sort -n); do
		# Indiquer l'id de la question
		QUESTIONID=$i

		# Charger la question
		mainLoadQuestion

		cat << EOF >> $out
=== Question #$i ===

  * Type: $TYPE
  * Question: $QUESTION

[[$DOKU_CGI?module=$module&action=modifyQuestion&id=$ID|Modifier]]
[[$DOKU_CGI?module=$module&action=deleteQuestion&id=$ID|Supprimer]]
EOF
		
	done

	redirect users:$DokuUser:$dokuName		
}

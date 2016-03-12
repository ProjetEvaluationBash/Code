#!/bin/bash

# addQuestion.sh
# Appelé lorsque le formulaire d'ajout de question est soumis

runRequest() {
    local dokuName=add_question
    local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
    local module=$(param module)

    # Est ce que l'utilisateur est professeur ?
	userIsProf
    
    if test $? -ne 0; then
    	dokuError "Vous n'êtes pas professeur"
    	exit 1
    fi

    source "$CODE_DIR/Question.sh"

    result=`mainDokuwikiAddQuestion`

    if test $? -ne 0; then
    	# Erreur rencontrée lors de l'ajout de la question
    
        dokuError $result
        exit 1
    fi

    cat << EOF > $out
====== Ajouter une question ======

Question #$result ajoutée au module !

[[$DOKU_CGI?module=$module&action=manageQuestions|Retourner à la gestion des questions]]

EOF

    redirect users:$DokuUser:$dokuName
}

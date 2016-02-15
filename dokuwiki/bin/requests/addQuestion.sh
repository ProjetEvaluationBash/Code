#!/bin/bash

# addQuestion.sh
# Appelé lorsque le formulaire d'ajout de question est soumis

runRequest() {
    local dokuName=add_question
    local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
    local module=$(param module)

    #if userIsProf; then
    #    dokuError "Désolé, fonction réservée aux enseignants !"
    #fi

    source "$CODE_DIR/Question.sh"

    mainDokuwikiAddQuestion

    if test $? -ne 0; then
        dokuError $ERROR_MESSAGE
        return 1
    fi

    cat << EOF > $out
====== Ajouter une question ======

Question ajoutée !

<code>
ID: $ID
</code>  

EOF

    redirect users:$DokuUser:$dokuName
}

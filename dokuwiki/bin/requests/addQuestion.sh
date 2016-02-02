#!/bin/bash

# addQuestion.sh
# Appelé lorsque le formulaire d'ajout de question est soumis

runRequest() {
    local dokuName=add_question_form
    local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
    local module=$(param module)

    if userIsProf; then
        dokuError "Désolé, fonction réservée aux enseignants !"
    fi

    local question=$(param question)
    local duration=$(param duration)
    local difficulty=$(param difficulty)
    local visibility=$(param difficulty)
    local type=$(param type)

    cat << EOF > $out
====== addQuestionForm Debug ======

Question: $question
Duration: $duration
Difficulty: $difficulty
Visibility: $visibility
Type: $type

EOF
}
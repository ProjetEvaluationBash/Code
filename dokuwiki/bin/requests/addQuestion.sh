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
    local visibility=$(param visibility)
    local type=$(param type)

    if test ! includeSubType $type; then
        dokuError "Type de question invalide !"
    fi

    if test "$question" = ""; then
        dokuError "Le champ question est vide."
    fi

    if test $difficulty -lt 1 -o $difficulty -gt 3; then
        dokuError "Difficulté invalide."
    fi

    if test "$visibility" != "hidden" -a "$visibility" != "training" -a "$visibility" != "exam"; then
        dokuError "Visibilité invalide."
    fi

    if test $duration -lt 0 -o $duration -gt 120; then
        dokuError "Durée invalide."
    fi

    cat << EOF > $out
====== addQuestionForm Debug ======

Question: $question
Duration: $duration
Difficulty: $difficulty
Visibility: $visibility
Type: $type

EOF
}

function includeSubType() {
    case $1 in
                'mcq')
                    source "$CODE_DIR/MCQ.sh"
                    ;;
                'commandname')
                    source "$CODE_DIR/CommandName.sh"
                    ;;
                'compoundcommand')
                    source "$CODE_DIR/CompoundCommand.sh"
                    ;;
                'freequestion')
                    source "$CODE_DIR/FreeQuestion.sh"
                    ;;
                'script')
                    source "$CODE_DIR/Script.sh"
                    ;;
                *)
                    return 1
                    ;;
        esac

    return 0
}
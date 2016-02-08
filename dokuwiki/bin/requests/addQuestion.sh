#!/bin/bash

# addQuestion.sh
# Appelé lorsque le formulaire d'ajout de question est soumis

runRequest() {
    local dokuName=add_question
    local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
    local module=$(param module)

    if userIsProf; then
        dokuError "Désolé, fonction réservée aux enseignants !"
    fi

    source "$CODE_DIR/Question.sh"

    mainDokuwikiAddQuestion

    cat << EOF > $out
====== addQuestionForm Debug ======

Id: $ID  
Question: $QUESTION  
Duration: $DURATION  
Difficulty: $DIFFICULTY  
Visibility: $VISIBILITY  
Type: $TYPE  


isMcqCalled: $ISMCQCALLED  
availableAnswers: $AVAILABLEANSWERS  
availableAnswersTrue: $AVAILABLEANSWERSTRUE  

EOF

    redirect users:$DokuUser:$dokuName
}

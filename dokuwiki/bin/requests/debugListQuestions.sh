#!/bin/bash

runRequest() {
	local dokuName=debug_list_questions
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
    local module=$(param module)

	local dbQuestionsDir=$DB_MODULES_DIR/$module/questions
	local dokuUserQuestionsDir=$DOKU_USERS_DIR/$DokuUser/questions

    if userIsProf; then
        dokuError "Désolé, fonction réservée aux enseignants !"
    fi
    
    echo "====== Debug - Liste de questions =====" > $out
    
    source "$CODE_DIR/Question.sh"
    
    QUESTIONPATH=$dokuUserQuestionsDir
    
    for i in $(cd $dokuUserQuestionsDir; ls *.txt | sed -re 's/\.txt$//' | sort -n); do	
		QUESTIONID=$i
		
		# Charger la question
		mainLoadQuestion
		
		echo "===== Question #$i =====" >> $out
		
		mainToString >> $out
    done
    
    redirect users:$DokuUser:$dokuName
}

#!/bin/bash

runRequest() {
	local dokuName=debug_list_questions
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)

	local dbQuestionsDir=$DB_MODULES_DIR/$module/questions

	userIsProf

	if test $? -ne 0; then
		dokuError "Reservé aux professeurs."
		exit 1
	fi

    echo "====== Debug - Liste de questions =====" > $out
    
    source "$CODE_DIR/Question.sh"
    
    QUESTIONPATH=$dbQuestionsDir
    
    for i in $(cd $QUESTIONPATH; ls *.txt | sed -re 's/\.txt$//' | sort -n); do	
		QUESTIONID=$i
		
		# Charger la question
		mainLoadQuestion
		
		echo "===== Question #$i =====" >> $out
		
		mainToString >> $out
    done
    
    redirect users:$DokuUser:$dokuName
}

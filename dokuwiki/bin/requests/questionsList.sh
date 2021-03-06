#!/bin/bash

runRequest() {
	local dokuName=questions_list
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
    local module=$(param module)

	local dbQuestionsDir=$DB_MODULES_DIR/$module/questions
	local dokuUserQuestionsDir=$DOKU_USERS_DIR/$DokuUser/questions

    if userIsProf; then
        dokuError "Désolé, fonction réservée aux enseignants !"
    fi

	echo "====== Liste des questions du module $module ======" > $out
	
	# Inclure Question.sh
	source "$CODE_DIR/Question.sh"
	
    # Importe les questions (liens symboliques)

    rm -Rf $dokuUserQuestionsDir
    mkdir $dokuUserQuestionsDir
    for i in $(cd $dbQuestionsDir; ls *.txt); do
            ln -sf $dbQuestionsDir/$i $dokuUserQuestionsDir/$i
    done

	QUESTIONPATH=$dokuUserQuestionsDir

	j=1

    for i in $(cd $dokuUserQuestionsDir; ls *.txt | sed -re 's/\.txt$//' | sort -n); do	
		QUESTIONID=$i
		
		echo "=== Question #$j ===" >> $out
		mainLoadQuestion
		mainShowQuestion >> $out
		j=$(($j + 1))
    done

	redirect users:$DokuUser:$dokuName
}


#!/bin/bash

runRequest() {
	local dokuName=questions_list
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
        local module=$(param module)

	local dbQuestionsDir=$DB_MODULES_DIR/$module/questions
	local dokuUserQuestionsDir=$DOKU_USERS_DIR/$DokuUser/questions

        if ! userIsProf; then
                cgiHeader
                redirect users:$DokuUser:permissionDenied
                return 1
        fi

        cat << EOF > $out
====== Liste des questions du module $module ======
EOF

	. $HOME/Code/Question.sh
        # Importe les questions (liens symboliques)

        rm -Rf $dokuUserQuestionsDir
        mkdir $dokuUserQuestionsDir
        for i in $(cd $dbQuestionsDir; ls *.txt); do
                ln -sf $dbQuestionsDir/$i $dokuUserQuestionsDir/$i
        done

	QUESTIONPATH=$dokuUserQuestionsDir

        for i in $(cd $dokuUserQuestionsDir; ls *.txt | sed -re 's/\.txt$//' | sort -n); do	
		QUESTIONID=$i
		
		mainLoadQuestion
		mainShowQuestion >> $out
                #showQuestionItem $dokuUserQuestionsDir/$i.txt
        done

        cgiHeader
	redirect users:$DokuUser:$dokuName

}


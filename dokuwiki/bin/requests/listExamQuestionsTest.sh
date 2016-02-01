#!/bin/bash


runRequest() {
	local dokuName=list_exam_questions
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)

        local dbQuestionsDir=$DB_MODULES_DIR/$module/questions
        local dokuUserQuestionsDir=$DOKU_USERS_DIR/$DokuUser/questions

	if userIsProf; then
		dokuError "Désolé, fonction réservée aux enseignants !"
	fi

	cat << EOF > $out
====== Liste des questions d'examens du module ($module) ======
EOF

	# Importe les questions (liens symboliques)

	rm -Rf $dokuUserQuestionsDir
	mkdir $dokuUserQuestionsDir
	for i in $(cd $dbQuestionsDir; ls *.txt); do
		ln -sf $dbQuestionsDir/$i $dokuUserQuestionsDir/$i
	done

	for i in $(cd $dokuUserQuestionsDir; ls *.txt | sed -re 's/\.txt$//' | sort -n); do
		local visibility=$(getQuestionElement $dokuUserQuestionsDir/$i.txt visibility)
		if [ "$visibility" = "exam" ]; then
			showQuestionItem $dokuUserQuestionsDir/$i.txt
		fi
	done

        redirect users:$DokuUser:$dokuName
}

#!/bin/bash


runRequest() {
	local dokuName=show_exam
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local exam=$(param exam)

        #local dbQuestionsDir=$DB_MODULES_DIR/$module/questions
        #local dokuUserQuestionsDir=$DOKU_USERS_DIR/$DokuUser/questions

	local examsDir=$DB_USERS_DIR/$DokuUser/$module/exams/$exam

	if userIsProf; then
		dokuError "Désolé, fonction réservée aux enseignants !"
	fi

	list=$(cat $examsDir/list)

	cat << EOF > $out
====== Examen $exam du module $module ======

EOF

	for i in $list; do
		showQuestionItem $DB_USERS_DIR/$DokuUser/$module/exams/$exam/questions/$i.txt
	done

	# Importe les questions (liens symboliques)

	#rm -Rf $dokuUserQuestionsDir
	#mkdir $dokuUserQuestionsDir
	#for i in $(cd $dbQuestionsDir; ls *.txt); do
	#	ln -sf $dbQuestionsDir/$i $dokuUserQuestionsDir/$i
	#done

	#for i in $(cd $dokuUserQuestionsDir; ls *.txt | sed -re 's/\.txt$//' | sort -n); do
	#	local visibility=$(getQuestionElement $dokuUserQuestionsDir/$i.txt visibility)
	#	if [ "$visibility" = "exam" ]; then
	#		showQuestionItem $i
	#	fi
	#done

        redirect users:$DokuUser:$dokuName
}

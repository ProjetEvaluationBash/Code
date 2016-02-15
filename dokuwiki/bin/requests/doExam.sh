#!/bin/bash 

runRequest(){

	local dokuName=do_exam_form
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
        local module=$(param module)
	local name=$(param name)

	local examsDir=$DB_USERS_DIR/$DokuUser/$module/exams
	local profsDir=$HOME/db-users

	local profs="`cd $profsDir; ls | grep prof`"

	for prof in $profs; do
		curentProfExamDir=$profsDir/$prof/$module/exams
		listExams="`cd $curentProfExamDir; ls -d */`"
		for exam in $listExams; do
			if [ "$exam" == "$name" ]; then
				cp $currentProfExamDir/$exam  $examsDir
				$listExams=""
				$profs=""
			fi
		done
	done

		
	



}

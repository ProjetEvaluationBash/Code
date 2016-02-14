#!/bin/bash 

runRequest(){

	local dokuName=do_exam_form
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
        local module=$(param module)
	local name=$(param name)

	local profsDir=$HOME/db-users

	local profs="`cd $profsDir; ls | grep prof`"

	for prof in $profs; do
		curentProfExamDir=$profsDir/$profs/$module/exams
		listExams="`cd $curentProfExamDir; ls -d */`"
		for exam in $listExams; do
			if [ "$exam" == "$name" ]; then

			fi
		done
	done

		
	



}

#!/bin/bash 

runRequest(){

	
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
        local module=$(param module)
	local name=$(param name)

	local examsDir=$DB_USERS_DIR/$DokuUser/$module/exams
	local profsDir=$HOME/db-users

	local profs="`cd $profsDir; ls | grep prof`"

	for prof in $profs; do
		if [ -e $profsDir/$prof/$module/exams ]; then	
			curentProfExamDir=$profsDir/$prof/$module/exams

			if [ -e $curentProfExamDir/$name ];then
				cp -r  $curentProfExamDir/$exam $examsDir
				break
			fi
		fi
	done
	
	if [ ! -e $examsDir/$name ]; then
		dokuError "L'examen $name n'existe pas"
		return 1	
	fi
	
	cgiHeader
        run "$DOKU_CGI?module=$module&exam=$name&action=displayExamForm"
	



}

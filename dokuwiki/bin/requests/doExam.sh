#!/bin/bash 

runRequest(){

	local dokuName=do_exam
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
        local module=$(param module)
	local name=$(param name)

	local examsDir=$DB_USERS_DIR/$DokuUser/$module/exams
	local profsDir=$HOME/db-users

	local profs="`cd $profsDir; ls | grep prof`"

	for prof in $profs; do
		if [ -e $profsDir/$prof/$module/exams ]; then	
			curentProfExamDir=$profsDir/$prof/$module/exams
			listExams="`cd $curentProfExamDir; ls -d */`"
			tmpName="$name/"
			for exam in $listExams; do
				if [ "$exam" == "$tmpName" ]; then
					cp -r  $curentProfExamDir/$exam $examsDir
				fi
			done
		fi
	done

	
cat << EOF > $out

====== Examen du module : $module ======

exam : $exam
name : $name
tmpname : $tmpName
profs :$profs
list exam : $listExams
current prof exam dir : $curentProfExamDir
EOF


        cgiHeader
        run "$DOKU_CGI?module=$module&exam=$name&action=displayExamForm"
	



}

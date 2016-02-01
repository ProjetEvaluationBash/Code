#! /bin/bash

#

runRequest(){
	local dokuName=create_exam
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
        local module=$(param module)
        local name=$(param name)
        local list=$(param list)

	local testsDir=$DB_USERS_DIR/$DokuUser/$module/tests

	name="$DokuUser-$name"

	listQ="`./$DB_USERS_DIR/$DokuUser/other/FindQuestionRandom.sh`"

	cat << EOF > $out

====== Création d'un entraînement du module $module ======

EOF
	for question in $listeQ; do

        	showQuestionItem $DB_USERS_DIR/$DokuUser/$module/exams/$exam/questions/$question.txt

	done
}
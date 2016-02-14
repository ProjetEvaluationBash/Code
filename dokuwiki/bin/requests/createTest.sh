#! /bin/bash


runRequest(){
	local dokuName=create_exam
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
        local module=$(param module)
	local name=$(param name)

	local testsDir=$DB_USERS_DIR/$DokuUser/$module/tests

	export MODULE="$module"
	
	if [ -e $testsDir/$name ]; then
                dokuError "L'entraînement $name existe déjà !"
                return 1
        fi
	
	listQ="`findQuestionRandom`"	


	mkdir -p $testsDir/$name
	echo "$listQ" > $testsDir/$name/list
	mkdir $testsDir/$name/questions
	mkdir $testsDir/$name/answers
	for i in $listQ; do

		cp $DB_MODULES_DIR/$module/questions/$i.txt $testsDir/$name/questions
	done

	

	cat << EOF > $out

====== Création d'un entraînement du module $module ======

EOF


	cgiHeader
	run "$DOKU_CGI?module=$module&exam=$name&action=displayTrainingForm"
}



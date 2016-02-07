#!/bin/bash

runRequest() {
	local dokuName=display_testing_form
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local test=$(param exam)

	local testDir=$DB_USERS_DIR/$DokuUser/$module/tests
	local dokuUserQuestionsDir=$DOKU_USERS_DIR/$DokuUser/questions

    if [ ! -e $testDir/$test ]; then
            dokuError "L'examen $exam n'existe pas !"
            return 1
    fi

	list="$(cat $testDir/$test/list)"

	cat << EOF > $out
====== Affichage d un examen (module $module) ======
<html>
Liste des question de l entrainement $test:
</html>
EOF

	source "$CODE_DIR/Question.sh"
	#QUESTIONPATH=$testDir

	
    #rm -Rf $dokuUserQuestionsDir
    #mkdir $dokuUserQuestionsDir


	#for i in $list; do		
	#	$questionPath="$i.txt"
	#	ln -sf $testDir/$i $dokuUserQuestionsDir/$questionPath
	#	QUESTIONID=$i
	#	mainLoadQuestion
	#	mainShowQuestion >> $out
	#done


	cgiheader
	redirect users:$DokuUser:$dokuName
}

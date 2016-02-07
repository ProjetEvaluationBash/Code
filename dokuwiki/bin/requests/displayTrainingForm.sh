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
====== Entrainement: $test (module $module) ======
<html>
	
</html>
EOF

	source "$CODE_DIR/Question.sh"
	QUESTIONPATH="$testDir/questions"

	for i in $list; do
		QUESTIONID=$i
		echo "$QUESTIONPATH/$QUESTIONID.txt" >> $out
		echo >> $out
		mainLoadQuestion
		mainShowQuestion >> $out
	done


	cgiheader
	redirect users:$DokuUser:$dokuName
}

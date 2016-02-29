#/bin/bash

runRequest() {
	local dokuName=validate_testing_form
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local test=$(param exam)

	local answerDir=$DB_USERS_DIR/$DokuUser/$module/answer
	local dokuUserQuestionsDir=$DOKU_USERS_DIR/$DokuUser/questions

 	if [ ! -e $testDir/$test ]; then
		    dokuError "L'entrainement $test n'existe pas !"
		    return 1
	fi
	
	list="$(cat $testDir/$test/list)"

	QUESTIONPATH="$testDir/$test/questions"
	
	redirect users:$DokuUser:$dokuName
}

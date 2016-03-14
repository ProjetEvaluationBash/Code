#/bin/bash

runRequest() {
	local dokuName=display_answertest_form
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local test=$(param testid)

	local testDir=$DB_USERS_DIR/$DokuUser/$module/tests
	local dokuUserQuestionsDir=$DOKU_USERS_DIR/$DokuUser/questions

 	if [ ! -e $testDir/$test ]; then
		    dokuError "L'entrainement $test n'existe pas !"
		    exit 1
	fi
	list="$(cat $testDir/$test/list)"
cat << EOF > $out
====== Resultat de l'entrainement: $test (module $module) ======
EOF
	
	source "$CODE_DIR/Question.sh"
	QUESTIONPATH="$testDir/$test/questions"
	ANSWERPATH="$testDir/$test/answers"	
	local j=0
	echo "$list" >> $out
	for i in $list; do
		j=$(($j + 1))
		echo "=== Question $j ===" >> $out
		QUESTIONID=$i
		mainLoadQuestion
		echo "<p>$QUESTION (difficulté: $DIFFICULTY): `cat $ANSWERPATH/$i.txt`<br><br></p>" >> $out
	done
	redirect users:$DokuUser:$dokuName
}

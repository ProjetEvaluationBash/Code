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
	QUESTIONPATH="$testDir/$test/questions"
	local j=1
	for i in $list; do
		echo "=== Question $j ===" >> $out
		j=$(($j + 1))
		QUESTIONID=$i
		mainLoadQuestion
		mainShowQuestion >> $out
	done

cat << EOF >> $out
<html>
<center>
<form name="myForm" action="$DOKU_CGI" method="POST">
<input type="submit" value="Valider mon test">
</form>
</center>
</html>
EOF
	redirect users:$DokuUser:$dokuName
}

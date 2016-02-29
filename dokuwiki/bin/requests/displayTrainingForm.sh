#/bin/bash

runRequest() {
	local dokuName=display_testing_form
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local test=$(param exam)

	local testDir=$DB_USERS_DIR/$DokuUser/$module/tests
	local dokuUserQuestionsDir=$DOKU_USERS_DIR/$DokuUser/questions

 	if [ ! -e $testDir/$test ]; then
		    dokuError "L'entrainement $test n'existe pas !"
		    return 1
	fi
	list="$(cat $testDir/$test/list)"

	tempdir=`mktemp`
cat << EOF > $out
====== Entrainement: $test (module $module) ======

<html>
<form name="TrainingFormulaire" action="$DOKU_CGI" method="POST">
<input type="hidden" name="tempNameTest" value="$tempdir"></input>

EOF
	
	source "$CODE_DIR/Question.sh"
	QUESTIONPATH="$testDir/$test/questions"
	
	local j=0
	for i in $list; do
		j=$(($j + 1))
		echo "=== Question $j ===" >> $out
		QUESTIONID=$i

		mainLoadQuestion
		
		echo "$j:$QUESTIONID" >> $tempdir
		mainShowQuestion >> $out
	done

cat << EOF >> $out
<center>
<input type="submit" value="Valider mon test">
</center>
</form>
</html>
EOF
	redirect users:$DokuUser:$dokuName
}

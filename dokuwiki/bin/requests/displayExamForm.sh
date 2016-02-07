#!/bin/bash

runRequest() {
	local dokuName=displayExamForm
    local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local exam=$(param exam)

	local examsDir=$DB_USERS_DIR/$DokuUser/$module/exams

    if [ ! -e $examsDir/$exam ]; then
            dokuError "L'examen $exam n'existe pas !"
            return 1
    fi

	list="$(cat $examsDir/$exam/list)"

	cat << EOF > $out
====== Examen: $exam (module $module) ======
<html>
</html>
	
EOF

	source "$CODE_DIR/Question.sh"
	QUESTIONPATH="$examsDir/$exam/questions"

	for i in $list; do
		QUESTIONID=$i
		mainLoadQuestion
		mainShowQuestion >> $out
	done
	
	cgiheader
	redirect users:$DokuUser:$dokuName
}


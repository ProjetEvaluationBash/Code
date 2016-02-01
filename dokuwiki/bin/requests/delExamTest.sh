#!/bin/bash

runRequest() {
	local dokuName=del_exam
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local name=$(param name)
	local exam=$(param exam)

	local examsDir=$DB_USERS_DIR/$DokuUser/$module/exams

        if userIsProf; then
                dokuError "Désolé, fonction réservée aux enseignants !"
        fi

	if [ ! -e $examsDir/$exam ]; then
		dokuError "L'examen $exam n'existe pas !"
		return 1
	fi

	rm -Rf $examsDir/$exam

#	cat << EOF > $out
#====== Supression examen (module $module) ======
#
#  * dir=$examsDir/$name
#  * Examen : $exam
#
#EOF

	#redirect users:$DokuUser:$dokuName
	run "$DOKU_CGI?module=$module&action=manageExamTest"
}

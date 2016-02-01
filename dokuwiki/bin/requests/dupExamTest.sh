#!/bin/bash

runRequest() {
	local dokuName=dup_exam
        local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local examSrc=$(param examSrc)
	local examDst=$(param examDst)

	local examsDir=$DB_USERS_DIR/$DokuUser/$module/exams

        if userIsProf; then
                dokuError "Désolé, fonction réservée aux enseignants !"
        fi

	examDst="$DokuUser-$examDst"

        if [ ! -e $examsDir/$examSrc ]; then
                dokuError "L'examen $examSrc n'existe pas !"
                return 1
        fi

	if [ -e $examsDir/$examDst ]; then
		dokuError "L'examen $examDst existe déjà !"
		return 1
	fi

	cp -a $examsDir/$examSrc $examsDir/$examDst

#	cat << EOF > $out
#====== Duplication d'examen (module $module) ======
#
#  * dir=$examsDir
#  * Examen src : $examSrc
#  * Examen dst : $examDst
#
#EOF

	#redirect users:$DokuUser:$dokuName
	run "$DOKU_CGI?module=$module&action=manageExamTest"
}

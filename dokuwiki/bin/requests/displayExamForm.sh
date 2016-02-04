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
====== Affichage d'un examen (module $module) ======
		<html>
		Liste des question de l entrainement $exam:
		for i in list; do
			echo i;
		done
		test
		</html>

		EOF
		        redirect users:$DokuUser:$dokuName
}

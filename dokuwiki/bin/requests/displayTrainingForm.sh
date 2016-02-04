#!/bin/bash

runRequest() {
	local dokuName=displayTrainingForm
    local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local train=$(param exam)

	local trainsDir=$DB_USERS_DIR/$DokuUser/$module/tests
    if [ ! -e $trainsDir/$train ]; then
            dokuError "L'examen $exam n'existe pas !"
            return 1
    fi

	list="$(cat $trainsDir/$train/list)"

	cat << EOF > $out
====== Affichage d'un examen (module $module) ======

<html>
Liste des question de l entrainement $exam:


</html>

EOF
	redirect users:$DokuUser:$dokuName
}

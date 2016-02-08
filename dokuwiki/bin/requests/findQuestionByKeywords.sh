#/bin/bash

runRequest() {
	local dokuName=delete_question
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local name=$(param name)
	local list=$(param list)

	if userIsProf;then
		dokuError"Désolé, fonction réservée aux enseignants !"
	fi

	name=$DokuUser-$name
	
	for i in $list; do
				

	
	done
	
	cat << EOF > $out	


======= Suppression de questions (module $module) ======

EOF
	redirect users:$DokuUser:modules
}

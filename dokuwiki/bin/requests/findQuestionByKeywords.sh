#/bin/bash

runRequest() {
	local dokuName=find_question_by_keywords
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local name=$(param name)
	local list=$(param list)
	local keyword=$(param keyword)

	if userIsProf;then
		dokuError"Désolé, fonction réservée aux enseignants !"
	fi

	name=$DokuUser-$name
	
	
	for i in $list; do 
		local keywords=$(getQuestionElement $DB_MODULES_DIR/$module/questions$i.txt keywords)
		if ["$keywords" == $keyword ]
			echo $DB_MODULES_DIR/$module/questions/$i.txt
		fi
	done
			
	
	cat << EOF > $out	


======= Suppression de questions (module $module) ======

EOF
	redirect users:$DokuUser:modules
}

#/bin/bash

runRequest() {
	local dokuName=find_question_by_keywords
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local name=$(param name)
	local list=$(param list)
	local keyword=$(param keyword)
	local tab=$(param tab)	

	if userIsProf;then
		dokuError"Désolé, fonction réservée aux enseignants !"
	fi

	name=$DokuUser-$name
	
	
	for i in $list; do 
		local keywords=$(getQuestionElement $DB_MODULES_DIR/$module/questions$i.txt keywords)
		if ["$keywords" == $keyword ]
			tab[i] = $DB_MODULES_DIR/$module/questions/$i.txt
		fi
	done
			
	
	cat << EOF > $out	


======= Recherche de questions (module $module) ======

EOF
	* Mots clés : $tab
	redirect users:$DokuUser:modules
}

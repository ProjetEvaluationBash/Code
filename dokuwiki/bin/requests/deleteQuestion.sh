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
	
	local notFoundQuestions=""
	for i in $list; do
		if [ ! -e $DB_MODULES_DIR/$module/questions/$i.txt ]; then
			notFoundQuestions="$notFoundQuestions $i"
		fi
		i =$(getQuestionElement $DB_MODULES_DIR/$module/questions/$i.txt id)
		nbquest=`cd $DB_MODULES_DIR/$module/questions; ls -l | grep .txt  | wc -l`
		mv $DB_MODULES_DIR/$module/questions/$nbquest.txt $DB_MODULES_DIR/$module/questions/$i.txt
	done

	if [ -n "$notFoundQuestions" ]; then
		dokuError "Les questions suivantes n'existent pas : $notFoundQuestions !"
		return 1
	fi

	
	
	cat << EOF > $out	


======= Suppression de questions (module $module) ======

EOF
	redirect users:$DokuUser:modules
}


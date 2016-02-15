#/bin/bash

runRequest() {
	local dokuName=find_question_by_keywords
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local list=$(param list)
	local examsDir=$DB_USERS_DIR/$DokuUser/$module/questionsFind
	local name=$(param name)
	local keyword=$(param keyword)



	if userIsProf; then
		dokuError"Désolé, fonction réservée aux enseignants !"
	fi

	name="$DokuUser-$name"
	
	
 	mkdir -p $examsDir/$name/questionsFind	
	
	for i in $list; do 
		local keywords=$(getQuestionElement $DB_MODULES_DIR/$module/questions$i.txt keywords)
		if test "$keywords" == "$keyword"; then
			cp $DB_MODULES_DIR/$module/questions/$i.txt $examsDir/$name/questionsFind
		fi
	done
			
	
	cat << EOF > $out	


======= Questions trouvées (module $module) =======

EOF

	local list="$(ls $examsDir/$name/questionsFind)"
	if test -z "$list"; then
		echo "Aucunes questions trouvées !" >> $out
	else
		for i in $list; do
			showQuestionItem $examsDir/$name/questionsFind/$i.txt >> $out 
		done
	fi		
	redirect users:$DokuUser:$dokuName
}

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
	
	
	mkdir -p $examsDir/$name
	mkdir $examsDir/$name/questionsFind	
	for i in $list; do 
		local keywords=$(getQuestionElement $DB_MODULES_DIR/$module/questions$i.txt keywords)
		if ["$keywords" == $keyword ]
			cp $DB_MODULES_DIR/$module/questions/$i.txt $examsDir/$name/questionsFind
		fi
	done
			
	
	cat << EOF > $out	


======= Recherche de questions (module $module) ======

EOF

	local list="$(ls $examsDir/$name/questionsFind)"
	if [ -z "$list" ]; then
		echo "Aucunes questions trouvées !" >> $out
	else
		for i in $list; do
			echo $examsDir/$name/questionsFind 
		done
	fi		
	redirect users:$DokuUser:$dokuName
}

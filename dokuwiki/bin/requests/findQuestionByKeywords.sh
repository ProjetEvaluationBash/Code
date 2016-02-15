#/bin/bash

runRequest() {
	local dokuName=find_question_by_keywords
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local list=$(param list)
	local examsDir=$DB_USERS_DIR/$DokuUser/$module/questionsFound



	if userIsProf; then
		dokuError"Désolé, fonction réservée aux enseignants !"
	fi

	name="$DokuUser-$name"
	
	
 	mkdir -p $examsDir/questionsFound	
	
	nbQuestions = cd $DB_MODULES_DIR/$module/questions/ | wc -l *.txt | tail -n 1 | cut -d " " -f 2

	
	for i in $nbQuestions; do
		#Parcours des mots clés recherchés
		for j in $list; do 
			local keywords=$(getQuestionElement $DB_MODULES_DIR/$module/questions$i.txt keywords)
			if test "$keywords" == "$j"; then
				cp $DB_MODULES_DIR/$module/questions/$i.txt $examsDir/questionsFound
			fi
		done
	done
			
	
	cat << EOF > $out	


======= Questions trouvées (module $module) =======

EOF

	local list="$(ls $examsDir/$name/questionsFound)"
	if test -z "$list"; then
		echo "Aucunes questions trouvées !" >> $out
	else
		for l in $list; do
			showQuestionItem $examsDir/questionsFound/$l.txt >> $out 
		done
	fi		
	redirect users:$DokuUser:$dokuName
}

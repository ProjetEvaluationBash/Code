#/bin/bash

runRequest() {
	local dokuName=find_question_by_keywords
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local keywordSearch=$(param keywordSearch)
	local dokuUserQuestionsDir=$DOKU_USERS_DIR/$DokuUser/questions



	if userIsProf; then
		dokuError"Désolé, fonction réservée aux enseignants !"
	fi

	name="$DokuUser-$name"

	
	# Inclure Question.sh
	source "$CODE_DIR/Question.sh"	

	
 	#mkdir -p $examsDir/questionsFound/

	
#	echo "==== test ===" > $out
	
#	i=$(getQuestionElement $DB_MODULES_DIR/$module/questions/10.txt duration)
#        echo $i >> $out

#	list="aaa bbb ccc"
#	for q in $list; do
#		echo "  * $q" >> $out
#	done
#	echo $list >> $out
	

#	echo " test blabla" >> $out		
    
    	QUESTIONPATH=$dokuUserQuestionsDir
    
    	for i in $(cd $dokuUserQuestionsDir; ls *.txt | sed -re 's/\.txt$//' | sort -n); do	
		QUESTIONID=$i
		
		# Charger la question
		mainLoadQuestion
		
		local temporaryKeywords=`getElement "$questionFileContents" keywords`
	
		for keyword in $KEYWORDS; do
				if test "$keyword" = "$keywordSearch"
					echo "===== Question #$i =====" >> $out
				fi
		done
   	done	
	
#	cat << EOF >> $out	


#======= Questions trouvées (module $module) =======

#EOF

#	local list="$(ls $examsDir/$name/questionsFound)"
#	if test -z "$list"; then
#		echo "Aucunes questions trouvées !" >> $out
#	else
#		for l in $list; do
#			showQuestionItem $examsDir/questionsFound/$l.txt >> $out 
#		done
#	fi		
	redirect users:$DokuUser:$dokuName
}

#/bin/bash

runRequest() {
	local dokuName=find_question_by_keywords
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)
	local keywordSearch=$(param keywordSearch)
	local dokuUserQuestionsDir=$DOKU_USERS_DIR/$DokuUser/questions

	local dbQuestionsDir=$DB_MODULES_DIR/$module/questions

	userIsProf

	if test $? -ne 0; then
		dokuError "Reservé aux professeurs."
		exit 1
	fi

	name="$DokuUser-$name"

	echo "===== Questions trouvées =====" > $out
	
	# Inclure Question.sh
	source "$CODE_DIR/Question.sh"	

    	QUESTIONPATH=$dbQuestionsDir
    
    	for i in $(cd $QUESTIONPATH; ls *.txt | sed -re 's/\.txt$//' | sort -n); do	
		QUESTIONID=$i
		
		# Charger la question
		mainLoadQuestion
		
		for keyword in $KEYWORDS; do
			if test "$keyword" = "$keywordSearch"; then
				echo "*   $i  " >> $out
			fi
		done
		
   	done

	redirect users:$DokuUser:$dokuName
}

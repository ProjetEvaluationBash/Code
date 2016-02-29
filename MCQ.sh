#!/bin/bash

# AVAILABLEANSWERS (string[])

# ANSWER (integer)

function dokuwikiAddQuestion() {
	# Declarer un tableau de reponses possibles
	declare -A AVAILABLEANSWERS
	
	i=1

	while test $i -lt 10; do
		local availableAnswer=`param mcq_availableAnswer$i`

		# Est ce que la chaine de la reponse possible est vide
		if test -z $availableAnswer; then
			# Mettre fin à la boucle, on a lu toutes les reponses possibles
			break
		fi
		
		# Validation de la reponse possible
		validateAvailableAnswer $availableAnswer
		
		if test $? -ne 0; then
			return 2
		fi
		
		# Mettre la reponse possible dans le tableau des reponses possibles
		AVAILABLEANSWERS[$i]=`urlDecode $availableAnswer`
		
		# Incrementer i
		i=$(($i + 1))
	done
	
	# Est ce que le QCM a au moins deux reponses possible
	if test ${#AVAILABLEANSWERS[@]} -lt 2; then
		ERROR_MESSAGE="Un QCM doit avoir au moins deux reponses possibles."
		return 3
	fi
	
	# Recuperer la reponse vraie selectionnée
	ANSWER=$(param mcq_answer)
	
	# Est ce que une reponse vraie a été selectionnée
	if test -z $ANSWER; then
		ERROR_MESSAGE="Aucune reponse vraie fournie."
		return 1
	fi
	
	# Est ce que la reponse selectionnée vraie se trouve entre 1 et le nombre de questions total
	if test $ANSWER -lt 1 -o $ANSWER -gt $i; then
		ERROR_MESSAGE="Reponse vraie invalide"
		return 2
	fi

	echo "=== availableAnswers ==="
	
	for j in "${AVAILABLEANSWERS[@]}"; do
		echo "  - $j"
	done
	
	echo ""
	echo "=== answer ==="
	echo "$ANSWER"
	
	return 0
}

# Necessite QUESTIONPATH et QUESTIONID
function loadQuestion() {
	ANSWER=`getElement "$questionFileContents" answer`
	AVAILABLEANSWERS=()

	local tempAvailableAnswers=`getElement "$questionFileContents" availableAnswers`
	
	while read line; do
		line=`echo $line | cut -c 3-`
		
		AVAILABLEANSWERS+=("$line")
	done <<< "$tempAvailableAnswers"
}

#Fonction permettant d'évaluer la réponse à une question du type QCM

function dokuwikiEvaluateAnswer() {
	if test $# -ne 1; then
		echo "Usage: MCQ : EvalAnswer ANSWER" >&2
		return 1
	fi

	local userAnswer=$1
	
	if test $userAnswer -eq $ANSWER; then
		# Reponse vraie
		return 0
	fi
	
	# Reponse fausse
	return 1
}

# EvalAnswer QUESTIONID
function evaluateAnswer() {
	
	if test $# -ne 1; then
		echo "Usage: MCQ : EvalAnswer ANSWER" >&2
		return 1
	fi

	# Saisie de la réponse
	
	echo "Veuillez rentrer une réponse"
	read answer
	
	# Récuperation de la bonne réponse
	
	rightAnswer=`parseQuestionFile "answer" $1`
	
	if test $? -ne 0; then
		echo "Erreur ParseQuestionFile" >&2
		exit 1
	fi
	
	# Comparaison entre les deux réponses
	if test $answer -eq $rightAnswer; then
		echo "Bonne réponse !"
		
	else 	echo " Mauvaise réponse "
	fi
		
	return 0	
}

# Permet de récuperé la réponse à une question MCQ lors de l'ajout

function cliAddQuestion() {
	nbAnswers=0;
	
	# Ajouter les reponses possibles
	while test 1; do
		# Saisie d'une reponse possible
		echo ""
		echo "Saisir une reponse possible"
		read answers[$nbAnswers]

		while test not validateAvailableAnswer $answers[$nbAnswers]; do
			echo "[ERREUR] Response possible invalide."
			echo "Saisir une reponse possible: "
			read answers[$nbAnswers]
		done
				
		# Incrementer le nombre de reponses possibles
		nbAnswers=$(($nbAnswers + 1))
		
		# Demander si il y a d'autres reponses possibles à ajouter
		if test $nbAnswers -gt 1; then 
			echo ""
			echo -n "Ajouter une autre reponse ? [O/n]: "
			read -s -n 1 key
			if test $key = "n" -a  $key != "o" -a $key != "O"; then
				break
			fi
		fi
	done
}

# Retourne 1 quand la reponse est vide
# Retoure 2 quand la reponse est trop courte / longue

function validateAvailableAnswer() {
	local availableAnswer=$1

	if test "${#availableAnswer}" -lt 3; then
		ERROR_MESSAGE="Reponse trop courte."
		return 1
	fi
	
	if test "${#availableAnswer}" -gt 255; then
		ERROR_MESSAGE="Reponse trop longue."
		return 2
	fi

	return 0
}

function showQuestion() {
	i=1

	for answer in "${AVAILABLEANSWERS[@]}"; do
		echo "<input type=\"radio\" name=\"answer$j\" value=\"$i\"> $answer<br>"
		i=$(($i + 1))
	done
}

function toString() {
	cat << EOF

<strong>AVAILABLEANSWERS: </strong><br>
<ol>
EOF
	
	for answer in "${AVAILABLEANSWERS[@]}"; do
		echo "<li>$answer</li>"
	done


cat << EOF
</ol>
<strong>ANSWER: </strong> $ANSWER
EOF

}

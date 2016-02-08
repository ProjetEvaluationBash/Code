#!/bin/bash

PROGNAME=$(basename $0)
PROGDIR=$(readlink -m $(dirname $0))

# AVAILABLEANSWERS (string[])

# ANSWER (integer)

function dokuwikiAddQuestion() {
	ISMCQCALLED="YES"

	declare -A AVAILABLEANSWERS
	ANSWER=""
	
	i=1
	
	ERROR_MESSAGE="TEST MCQ"
	return 0
	
	while true; do
		availableAnswer=$(param "mcq_availableAnswer$1")
		
		if test -z $availableAnswer; then
			break
		fi
		
		validateAvailableAnswer $availableAnswer
		
		if test $? -ne 0; then
			return 1
		fi
		
		AVAILABLEANSWERS[$i]=$availableAnswer
		
		if test $(param "mcq_availableAnswerTrue$i") -eq "on"; then
			ANSWER="$ANSWER $i"
		fi
		
		i=$(($i + 1))
	done
	
	if test ${#AVAILABLEANSWERS[@]} -lt 2; then
		ERROR_MESSAGE="Un QCM doit avoir au moins deux reponses possibles."
		return 2
	fi
	
	if test -z $ANSWER; then
		ERROR_MESSAGE="Aucune reponse vraie fournie."
		return 3
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
	local i=1
	
	while read line; do
		line=`echo $line | cut -c 3-`
		
		AVAILABLEANSWERS+=("$i. $line")
		i=$(($i + 1))	
	done <<< "$tempAvailableAnswers"
}

#Fonction permettant d'évaluer la réponse à une question de type QCM

# EvalAnswer QUESTIONID

function evaluateAnswer() {

	# $1
	# Verification des paramêtres
	
	if test $# -ne 1; then
		echo "Usage: MCQ : EvalAnswer QUESTIONID" >&2
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

	echo "<html>"
	echo "<form name=\"userAnswer\"  method=\"POST\">"
	echo "<p>"
	echo "Cocher la bonne réponse : <br>"
	for answer in "${AVAILABLEANSWERS[@]}"; do
		echo "<input type=\"radio\" name=\"selectedAnswer\" value=\"$i\"> $answer<br>"
		i=$(($i + 1))
	done
	echo "</p>"
	echo "</form>"
	echo "</html>"

	return 0	
}

function toString() {
	echo "availableAnswers:"
	
	for answer in "${AVAILABLEANSWERS[@]}"; do
		echo $answer
	done

	echo "answer: $ANSWER"

	return 0
}

#!/bin/bash

. other/EvalLib.sh

# Fonction permettant l'évaluation d'une réponse à une question de type SimpleCommand
#EvalAnswer QUESTION ID


function loadQuestion() {
	ANSWER=`getElement "$questionFileContents" answer`
	return 0
}

function EvaluateAnswer() {
	
	# Vérif des paramêtres
	
	if test $# -ne 1; then
		echo "Usage : SimpleCommand : EvalAnswer QUESTION ID" >&2
		return 1
	fi
	
	# saisie de la réponse
	
	echo "Veuillez rentrer une réponse"
	read answer
	
	# Récupération de la bonne réponse
	
	rightAnswer=`parseQuestionFile "answer" $1`
	
	# Comparaison entre les deux réponses
	if test "$answer" = "$rightAnswer"; then
		echo "Bonne réponse !"
		
	else 	echo " Mauvaise réponse "
	fi
		
	return 0
	
}

function dokuwikiAddQuestion() {
	local answer=$(param simplecommand_answer)

	validateAnswer $answer
	returnCode=$?
	
	if test $returnCode -eq 1; then
		dokuError "Reponse vide."
	fi
	
	if test $returnCode -eq 2; then
		dokuError "Reponse trop longue."
	fi

	echo "=== answer ==="
	echo "$answer"

	return 0
}

function validateAnswer() {
	local answer=$1

	if test "${#answer}" -eq 0; then
		# Reponse vide
		return 1
	fi

	if test "${#answer}" -gt 255; then
		# Reponse trop longue
		return 2
	fi

	return 0
}

# Appelé par la fonction "AddQuestion" de Question.sh
# Permet de récuperé la réponse à une question SimpleCommand lors de l'ajout
# cliAddQuestion()
function cliAddQuestion() {
	
	#Saisie de la réponse
	
	echo "Saisir la bonne réponse"
	read answer
	
	while test "${#answer}" -lt 1 -o "${#answer}" -gt 512; do
		echo "Usage : Answer : taille inferieur à 512 caractères"
		read answer
	done
	
	echo answer
	
        return 0
}

function showQuestion() {

	echo "<html>"
	echo "<form name=\"userAnswer\"  method=\"POST\">"
	echo "<p>"
	echo "Votre réponse : <br>"
	echo "<input type="text" value=""><br>"
	echo "</p>"
	echo "</form>"
	echo "</html>"
	
	return 0
}

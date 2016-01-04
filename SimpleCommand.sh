#!/bin/bash

. other/EvalLib.sh

# Fonction permettant l'évaluation d'une réponse à une question de type SimpleCommand
#EvalAnswer QUESTION ID


#set -x
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

# Appelé par la fonction "AddQuestion" de Question.sh
# Permet de récuperé la réponse à une question SimpleCommand lors de l'ajout
# addQuestion()
function addQuestion() {
	
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

EvaluateAnswer 29

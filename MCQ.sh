#!/bin/bash

source Question.sh
source other/EvalLib.sh

# AVAILABLEANSWERS (string[])
AVAILABLEANSWERS=""

# ANSWER (integer)
ANSWER=""

# Necessite QUESTIONPATH et QUESTIONID
function loadQuestion() {
	
}

#Fonction permettant d'évaluer la réponse à une question de type QCM

# EvalAnswer QUESTIONID

set -x
<<<<<<< HEAD
function EvaluateAnswer() {
=======
function evaluateAnswer() {
>>>>>>> 64a4c59507712ca994fece343cba766f7acf5cd3

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

function addQuestion() {
	nbAnswers=0;
	
	# Ajouter les reponses possibles
	while test 1; do
		# Saisie d'une reponse possible
		echo ""
		echo "Saisir une reponse possible"
		read answers[nbAnswers]
		
		# Validation de la reponse possible saisie
		while test "${#question}" -lt 1 -o "${#question}" -gt 512; do
			echo "Reponse invalide. Resaisir la reponse:"
			read question
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
<<<<<<< HEAD

addQuestion 
EvaluateAnswer 1
=======
>>>>>>> 64a4c59507712ca994fece343cba766f7acf5cd3

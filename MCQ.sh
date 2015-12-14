#!/bin/bash

source other/EvalLib.sh

#Fonction permettant d'évaluer la réponse à une question de type QCM

# EvalAnswer QUESTIONID

function EvalAnswer() {

	# $1
	
	if test $# -ne 1; then
		echo "Usage: EvalAnswer QUESTIONID" >&2
		return 1
	fi

	echo "Veuillez rentrer une réponse"
	read answer
	
	rightAnswer=`parseQuestionFile "answer" $1`
	
	if test $? -ne 0; then
		echo "Erreur ParseQuestionFile" >&2
		exit 1
	fi
	
	
	if test $answer -eq $rightAnswer; then
		echo "Bonne réponse !"
		
	else 	echo " Mauvaise réponse "
	fi
		
	return 0	
}

function addQuestion() {
	nbAnswers=0

	# Saisir la question
	echo "Question:"
	read question
	
	# Validation de la question
	while test "${#question}" -lt 5 -o "${#question}" -gt 512; do
		echo "Question invalide. Resaisir la question:"
		read question
	done
	
	# Ajouter les reponses possibles
	while test 1; do
		# Saisie d'une reponse possible
		echo "Saisir une reponse possible"
		read answers[nbAnswers]
		
		# Validation de la reponse possible saisie
		# A FAIRE
		
		# Incrementer le nombre de reponses possibles
		nbAnswers=$(($nbAnswers + 1))
		
		# Demander si il y a d'autres reponses possibles à ajouter
		echo -n "Ajouter une autre reponse ? [O/n]: "
		read -s -n 1 key
		
		if test "$key" = "\n" -a "$key" != "o" -a "$key" != "O"; then
			break
		fi
	done
}

# TEST

EvalAnswer 1
	

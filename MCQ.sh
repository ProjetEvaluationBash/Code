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
	
	if test $answer -e $1; then
		echo "Bonne réponse !"
	fi
		
	return 0	
}

# TEST

EvalAnswer 1
	

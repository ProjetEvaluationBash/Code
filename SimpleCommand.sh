#!/bin/bash

. other/EvalLib.sh

# addQuestion()
function addQuestion {

	# Saisie de la question à ajouter
	
	echo "Saisir la question"
	read question
	
	while test "${#question}" -lt 15 -o "${#question}" -gt 512; do
		echo "Usage : Question : taille comprise entre 15 et 512 caractères"
		read question
	done
	
	#Saisie de la réponse
	
	echo "Saisir la bonne réponse"
	read answer
	
	while test "${#answer}" -lt 1 -o "${#answer}" -gt 512; do
		echo "Usage : Answer : taille inferieur à 512 caractères"
		read answer
	done
	
	
        return 0
}


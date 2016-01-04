#!/bin/bash

. other/EvalLib.sh

# addQuestion()
function addQuestion {
	
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


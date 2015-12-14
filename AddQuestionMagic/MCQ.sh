#!/bin/bash

addQuestion() {
	nbAnswers=1
	i=0

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
		if test $nbAnswers -gt 2; then 
			echo ""
			echo -n "Ajouter une autre reponse ? [O/n]: "
			read -s -n 1 key
			if test $key = "n" -a  $key != "o" -a $key != "O"; then
				break
			fi
		fi
	done
}

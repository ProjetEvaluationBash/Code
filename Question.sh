#!/bin/bash

function addQuestion() {
	# Lister les types de questions possibles
	
	echo "Type de question:"
	select questionType in 'MCQ' 'CommandName' 'SimpleCommand' 'CompoundCommand' 'Script' 'FreeQuestion'; do
		case $questionType in
			'MCQ')
				source MCQ.sh
				addQuestion
				break;;
			'CommandName')

				break;;
			'SimpleCommand')
				
				break;;
			'CompoundCommand')
				
				break;;
			'Script')
				
				break;;
			'FreeQuestion')
							
				break;;
			*)
				# Saisie invalide
				
				echo "Saisie invalide."
				;;
		esac
	done

	# Saisie de la difficulté de la question
	
	echo "Difficultés possible:"
	echo "1. Debutant"
	echo "2. Intermediaire"
	echo "3. Expert"

	echo "Choisir la difficulté de la question: "
	read difficulty

	# Validation de la difficulté

	while test $difficulty -lt 1 -o $difficulty -gt 3; do
		echo "Difficulté invalide." >&2
		read difficulty	
	done

	# On indique si la question est une question d'examen ou pas

	echo "La question est-elle une question d'examen ? [o/N]"

	read -r response
	response=${response,,} # Mettre la reponse en minuscule
	
	if test $response =~ ^(oui|o)$; then
		isExamQuestion="true"
	else
		isExamQuestion="false"
	fi

	# Test	
	echo "isExamQuestion: $isExamQuestion"	
}

addQuestion

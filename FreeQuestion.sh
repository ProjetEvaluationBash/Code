#!/bin/bash

source other/EvalLib.sh

#Fonction permettant d'evaluer la reponse à une question de type FreeQuestion

set -x
function evaluateAnswer(){
	#Verification des paramètres
	if test $# -ne 1; then
		echo "Usage: EvalAnswer QUESTIONID" >&2
		return 1
	fi

	#Saisie de la réponse
	echo "Veuillez rentrer une réponse"
	read answer

	# Récuperation des mots clés 


#Fonction permettant l'ajout du'une question de type FreeQuestion

function addQuestion {
	nbKeywords=1	

	# Saisir la question
	echo "Question:"
	read question
	
	# Validation de la question
	while test"${#question}" -lt 5 -o "${#question}" -gt 512; do
		echo "Question invalide. Resaisir la question:"
		read question
	done


	#Ajouter les mots clés permettant de corriger automatiquement
	while test 1; do
		echo""
		echo "Saisir le premier mot clé attendu dans la réponse"
		read keywords[nbKeywords]        
		
		#Validation du mot clé possible saisi
		while test "${#question}" -lt 1 -o "${#question}" -gt 512; do
			echo "Mot clé invalide. Resaisir le mot clé:"
			read question
		done

		# Incrementer le nombre de reponses possibles
		nbKeywords=$(($nbAnswers + 1))

		# Demander si il y a d'autres mots clés attendus
		if test $nbKeywords -gt 2; then
			echo ""
			echo -n "Ajouter un autre mot clé ? [O/n]: "
			read -s -n 1 key
			if test $key = "n" -a $key != "o" -a $key != "O"; then 
				break
			fi
		fi
	done
}

# fonction generant un formulaire qui permet à l'utilisateur de répondre à une free question
function showQuestion() {
	echo"<html>"
	echo"<form name=\"userAnswer\"  method=\"POST\">"
	echo"<p>"
	echo"Votre réponse : <br>"
	echo"<textarea></textarea><br>"
	echo"</p>"
	echo"</form>"
	echo"</html>"

	return 0
}	

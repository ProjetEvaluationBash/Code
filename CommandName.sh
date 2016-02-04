#!/bin/bash

function addQuestion() {
	# Saisir la question
	echo "Question:"
	read question

	# Validation de la question
	while test "${#question}" -lt 5 -o "${#question}" -gt 512; do
		echo "Question invalide. Resaisir la question:"
		read question
	done

	# Saisir la reponse
	echo "Reponse:"
	read answer

	# Validation de la reponse
        while test "${#question}" -lt 5 -o "${#question}" -gt 512; do
                echo "Question invalide. Resaisir la question:"
                read question
        done

	echo "$question\n$answer"
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

#!/bin/bash

function dokuwikiAddQuestion() {
	local answer=$(param commandname_answer)

	validateAnswer $answer
	returnCode=$?

	if test $returnCode -eq 1; then
		dokuError "Reponse vide"
		exit 1
	fi

	if test $returnCode -eq 2; then
		dokuError "Reponse trop longue"
		exit 1
	fi

	echo "=== answer ==="
	echo "$answer"

	return 0
}

function validateAnswer() {
	local answer=$1

	if test "${#answer}" -eq 0; then
		# Reponse vide
		return 1
	fi

	if test "${#answer}" -gt 30; then
		# Reponse trop longue
		return 2
	fi

	return 0
}

function cliAddQuestion() {
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

function loadQuestion() {
	ANSWER=`getElement "$questionFileContents" answer`
	
	return 0
}

function showQuestion() {

	echo "<html>"
	echo "<form name=\"userAnswer\"  method=\"POST\">"
	echo "<p>"
	echo "Votre réponse : <br>"
	echo "<input type=\"text\" value=\"\"><br>"
	echo "</p>"
	echo "</form>"
	echo "</html>"
	
	return 0
}

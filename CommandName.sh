#!/bin/bash

function dokuwikiAddQuestion() {
	local answer=$(param commandname_answer)

	validateAnswer $answer
	
	if test $? -ne 0; then
		return 1
	fi

	echo "=== answer ==="
	echo "$answer"

	return 0
}

# Fonction permettant l'évaluation à une question du type CommandName

function dokuwikiEvaluateAnswer() {

	if test $# -ne 1; then
                echo "Usage: CommandName : EvalAnswer ANSWER" >&2
                return 1
        fi

	local userAnswer=$1

        if test $userAnswer -eq $ANSWER; then
                # Reponse vraie
                return 0
        fi

        # Reponse fausse
        return 1


}


function validateAnswer() {
	local answer=$1

	if test "${#answer}" -eq 0; then
		ERROR_MESSAGE="Reponse vide."
		return 1
	fi

	if test "${#answer}" -gt 30; then
		ERROR_MESSAGE="Reponse trop longue."
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
cat << EOF >> $out
<p>
Votre réponse : <br>
<input type="answer$j" value=""><br>
</p>
EOF
	return 0
}

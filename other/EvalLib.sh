#!/bin/bash

# Biblotheque de fonctions

# parseQuestionFile(element, questionId)

# error(message, returnCode = 1)

# fatalError(message, exitCode)
# fatalError(exitCode)

function fatalError {
	if test $# -eq 2; then
		exitCode=$2
	else
		exitCode=$1
	fi

	echo "$1" >&2
	exit $returnCode
}


# getCourseKeywords(number)

function getCourseKeyword {
	
	#On verifie si la fonction a bien été appellée avec 1 argument
	if test $# -ne 1; then
		echo "Usage : getCourseKeywords NUMBER" >&2
		return 1
	fi
	
	#On verifie si le COURSESPATH est un dossier
	if test ! -d $COURSESPATH; then
		echo "getCourseKeywords : COURSESPATH inconnu" >&2
		return 2
	fi

	# On vérifie que $COURSESFILE est un fichier
	if test ! -f "$COURSESPATH/$COURSESFILE.txt"; then
		echo "getCourseKeywords : COURSESFILE inconnu" >&2
	fi

	# On extrait les données souhaitées
	`awk  -F ":" '{ print $0}' $COURSESPATH/$COURSESFILE.txt`
}



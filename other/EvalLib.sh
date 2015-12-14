#!/bin/bash

# Biblotheque de fonctions

# parseQuestionFile(element, questionId)

function parseQuestionFile {
	# On verifie si la fonction a bien été appellée avec 2 arguments
	if test $# -ne 2; then
		echo "Usage: parseQuestionFile ELEMENT QUESTIONID" >&2
		return 1
	fi
	
	# On vérifie que QUESTIONPATH est initialisé
	if test -z $QUESTIONPATH; then 
		echo "parseQuestionFile : QUESTIONPATH inconnu" >&2
	fi 

	# On verifie si le fichier existe et si c'est un fichier ordinaire
	if test ! -f "$QUESTIONPATH/$2.txt"; then
                echo "parseQuestionFile: Fichier non trouvé / n'est pas un fichier ordinaire." >&2
                return 2
        fi

	# On verifie si le fichier est lisible par l'utilisateur courant
	if test ! -r "$QUESTIONPATH/$2.txt"; then
		echo "parseQuestionFile: Fichier non lisible" >&2
		return 3
	fi

	# On extrait les données souhaitées
	elementData=`cat "$QUESTIONPATH/$2.txt" | gawk '
	BEGIN {
		show=0
	}

	/=== / {
		show=0
	}

	'"/=== $1/"' {
		show=1
	}

	{
		if (show==1) 
			print
	}
	' | tail -n +2`

	echo "$elementData"
	return 0
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

getCourseKeyword 3

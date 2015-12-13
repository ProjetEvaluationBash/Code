#!/bin/bash

# Biblotheque de fonctions

# parseQuestionFile(element, questionId)

function parseQuestionFile {
	# On verifie si la fonction a bien été appellée avec 2 arguments
	if test $# -ne 2; then
		echo "Usage: parseQuestionFile ELEMENT QUESTIONID" >&2
		return 1
	fi

	# On verifie si le fichier existe et si c'est un fichier ordinaire
	if test ! -f "$QUESTIONPATH/$2"; then
                echo "parseQuestionFile: Fichier non trouvé / n'est pas un fichier ordinaire." >&2
                return 2
        fi

	# On verifie si le fichier est lisible par l'utilisateur courant
	if test ! -r "$QUESTIONPATH/$2"; then
		echo "parseQuestionFile: Fichier non lisible" >&2
		return 3
	fi

	# On extrait les données souhaitées
	elementData=`cat "$QUESTIONPATH/$2" | gawk '
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

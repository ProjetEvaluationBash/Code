#!/bin/bash

source EvalLib.sh

# Si la variable d'environnement "QUESTIONPATH" n'est pas definie

if test -z $QUESTIONPATH; then
	echo "ShowQuestion: QUESTIONPATH non definie !" >&2
	exit 1
fi

# Si la variable d'environnement "QUESTIONID" n'est pas definie

if test -z $QUESTIONID; then
	echo "ShowQuestion: QUESTIONID non definie !" >&2
	exit 2
fi

# La variable d'environnement "QUESTIONID" est definie
# Lire le fichier de la question

questionData=`cat $QUESTIONPATH/$QUESTIONID.txt`

# Si le fichier de la question n'existe pas

if test $? -ne 0; then
	echo "ShowQuestion: Le fichier de la question $QUESTIONID n'existe pas" >&2
	exit 3
fi

# Le fichier de la question existe

# On retrouve le type de la question

type=`parseQuestionFile "type" $QUESTIONID`

if test $? -ne 0; then
	echo "ShowQuestion: parseQuestionFile: erreur rencontrée" >&2
	exit 4
fi

# On retrouve la question

question=`parseQuestionFile "question" $QUESTIONID`

if test $? -ne 0; then
        echo "ShowQuestion: parseQuestionFile: erreur rencontrée" >&2
        exit 4
fi

# On affiche la question

echo "Question:"
echo "$question"

# Si la question est de type QCM

if test "$type" = "mcq"; then
	# Retrouver et afficher les reponses possibles
	
	availableAnswers=`parseQuestionFile "availableAnswers" $QUESTIONID`

	if test $? -ne 0; then
		echo "ShowQuestion: parseQuestionFile: erreur rencontrée" >&2
		exit 4
	fi
	
	echo
	echo "Reponses possibles:"
	echo "$availableAnswers" | gawk '
		BEGIN {
			counter=1
		}

		{
			gsub(/  - /, "", $0)
			print counter ".", $0
			counter++
		}
	'
fi

exit 0

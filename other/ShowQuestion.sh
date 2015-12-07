#!/bin/bash

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

echo $questionData

exit 0

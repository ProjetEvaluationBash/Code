#!/bin/bash

source Code/other/EvalLib.sh

# ID (integer)
ID=""

# QUESTION (string)
QUESTION=""

# DIFFICULTY (integer)
DIFFICULTY=""

# ISEXAMQUESTION (boolean)
ISEXAMQUESTION=""

# DURATION (float)
DURATION=""

# TYPE (string)
TYPE=""

function addQuestion() {
	# Lister les types de questions possibles
	
	echo "Type de question:"
	select questionType in 'MCQ' 'CommandName' 'SimpleCommand' 'CompoundCommand' 'Script' 'FreeQuestion'; do
		case $questionType in
			'MCQ')
				source Code/MCQ.sh
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

	if [[ $response =~ ^(oui|o)$ ]]; then
		isExamQuestion="true"
	else
		isExamQuestion="false"
	fi

	# Saisie de la durée de la question

	echo "Saisir la durée de la question (en minutes) (float): "
	read duration

	#if test $duration -lt 0	

	# Test	
	echo "isExamQuestion: $isExamQuestion"	
}

# getElement(questionFileContents, element)
function getElement() {
	elementData=`echo "$1" | gawk '
        BEGIN {
                show=0
        }

        /=== / {
                show=0
        }

        '"/=== $2/"' {
                show=1
        }

        {
                if (show==1) 
                        print
        }
        ' | tail -n +2`

        echo "$elementData"

}

# loadQuestion(questionId)
# necessite QUESTIONPATH et QUESTIONID
function loadQuestion() {
	# Si la variable d'environnement "QUESTIONPATH" n'est pas definie

        if test -z $QUESTIONPATH; then
		fatalError "loadQuestion: QUESTIONPATH non definie !" 1
        fi

	# Si la variable d'environnement "QUESTIONID" n'est pas definie

        if test -z $QUESTIONID; then
        	fatalError "loadQuestion: QUESTIONID non definie !" 2
	fi 

	# On verifie si le fichier existe et si c'est un fichier ordinaire
        if test ! -f "$QUESTIONPATH/$QUESTIONID.txt"; then
        	fatalError "loadQuestion: Le fichier de la question n'existe pas !" 3
	fi

	# On verifie si le fichier est lisible par l'utilisateur courant
        if test ! -r "$QUESTIONPATH/$QUESTIONID.txt"; then
        	fatalError "loadQuestion: Fichier illisible (droits de fichier) !" 4
	fi

	# Lecture du fichier de la question
	questionFileContents=`cat $QUESTIONPATH/$QUESTIONID.txt`

	# Lecture de la question
	ID=$QUESTIONID
	QUESTION=`getElement "$questionFileContents" question`
	DIFFICULTY=`getElement "$questionFileContents" difficulty`
	ISEXAMQUESTION=`getElement "$questionFileContents" isExamQuestion`
	DURATION=`getElement "$questionFileContents" duration`		
	TYPE=`getElement "$questionFileContents" type`
}

function showQuestion() {
	
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
}

function getId() {
	echo "$ID"
}

function getQuestion() {
	echo "$QUESTION"
}

function getDifficulty() {
	echo "$DIFFICULTY"
}

function isExamQuestion() {
	echo "$ISEXAMQUESTION"
}

function getDuration() {
	echo "$DURATION"
}

function getType() {
	echo "$TYPE"
}
function toString() {
	echo "id: $ID"
	echo "question: $QUESTION"
	echo "difficulty: $DIFFICULTY"
	echo "isExamQuestion: $ISEXAMQUESTION"
	echo "duration: $DURATION"
	echo "type: $TYPE"
}

#!/bin/bash

source "$CODEROOT/other/EvalLib.sh"

# ID (integer)

# QUESTION (string)

# DIFFICULTY (integer)

# ISEXAMQUESTION (boolean)

# DURATION (float)

# TYPE (string)

function dokuwikiAddQuestion() {
	# Extraire parametres POST avec param

	# TEST=
	# QUESTION=
	# VISIBILITY=
	# DURATION=

	return 0	
}

function mainAddQuestion() {
	# Lister les types de questions possibles
	
	echo "Type de question:"
	select TYPE in 'mcq' 'commandname' 'simplecommand' 'compoundcommand' 'script' 'freequestion'; do
		if test includeSubType; then
			break
		fi	
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

# mainLoadQuestion(questionId)
# necessite QUESTIONPATH et QUESTIONID
function mainLoadQuestion() {
	# Si la variable d'environnement "QUESTIONPATH" n'est pas definie

        if test -z $QUESTIONPATH; then
		fatalError "mainLoadQuestion: QUESTIONPATH non definie !" 1
        fi

	# Si la variable d'environnement "QUESTIONID" n'est pas definie

        if test -z $QUESTIONID; then
        	fatalError "mainLoadQuestion: QUESTIONID non definie !" 2
	fi 

	# On verifie si le fichier existe et si c'est un fichier ordinaire
        if test ! -f "$QUESTIONPATH/$QUESTIONID.txt"; then
        	fatalError "mainLoadQuestion: Le fichier de la question n'existe pas !" 3
	fi

	# On verifie si le fichier est lisible par l'utilisateur courant
        if test ! -r "$QUESTIONPATH/$QUESTIONID.txt"; then
        	fatalError "mainLoadQuestion: Fichier illisible (droits de fichier) !" 4
	fi

	# Lecture du fichier de la question
	questionFileContents=`cat $QUESTIONPATH/$QUESTIONID.txt`

	# Lecture de la question
	ID=$QUESTIONID
	QUESTION=`getElement "$questionFileContents" question`
	DIFFICULTY=`getElement "$questionFileContents" difficulty`
	VISIBILITY=`getElement "$questionFileContents" visibility`
	DURATION=`getElement "$questionFileContents" duration`		
	TYPE=`getElement "$questionFileContents" type`

	includeSubType

	# On appelle la fonction loadQuestion du type de la question
	loadQuestion

	return 0
}

function mainShowQuestion() {
	echo "Question: $QUESTION"

	includeSubType
	showQuestion	
}

# Inclut "la classe" du type de question
# Necessite $TYPE

function includeSubType() {
	case $TYPE in
                'mcq')
                        source "$CODEROOT/MCQ.sh"
                        ;;
                'commandname')
                        source "$CODEROOT/CommandName.sh"
                        ;;
                'compoundcommand')
                        source "$CODEROOT/CompoundCommand.sh"
                        ;;
                'freequestion')
                        source "$CODEROOT/FreeQuestion.sh"
                        ;;
                'script')
                        source "$CODEROOT/Script.sh"
                        ;;
                *)
			fatalError "includeSubType: Incorrect question type." 1
			;;
        esac

	return 0
}

function mainToString() {
	echo "id: $ID"
	echo "question: $QUESTION"
	echo "difficulty: $DIFFICULTY"
	echo "isExamQuestion: $ISEXAMQUESTION"
	echo "duration: $DURATION"
	echo "type: $TYPE"

	includeSubType
	toString
}


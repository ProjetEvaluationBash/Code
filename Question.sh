#!/bin/bash

source "$CODEROOT/other/EvalLib.sh"

# ID (integer)

# QUESTION (string)

# DIFFICULTY (integer)

# ISEXAMQUESTION (boolean)

# DURATION (float)

# TYPE (string)

# Appelé après la saisie du formulaire d'ajout d'une question sur Dokuwiki
function mainDokuwikiAddQuestion() {
    local question=$(param question)
    local duration=$(param duration)
    local difficulty=$(param difficulty)
    local visibility=$(param visibility)
    local type=$(param type)

    if test ! validateType $type; then
        dokuError $ERROR_MESSAGE
    fi

    if test ! validateQuestion $question; then
        dokuError $ERROR_MESSAGE
    fi

    if test ! validateDifficulty $difficulty; then
        dokuError $ERROR_MESSAGE
    fi

    if test ! validateVisibility $visibility; then
        dokuError $ERROR_MESSAGE
    fi

    if test ! validateDuration $duration; then
        dokuError $ERROR_MESSAGE
    fi

    TYPE=$type

    ISQUESTIONCALLED="YES3"
    return 0

    # Inclure le sous-type en question et appeller la methode correspondante
    includeSubType
    dokuwikiAddQuestion

    ID=$RANDOM
    QUESTION=$question
    DIFFICULTY=$difficulty
    DURATION=$duration
    VISIBILITY=$visibility
    

    return 0
}

# Permet d'ajouter une question en ligne de commande
function mainCliAddQuestion() {
    # Choix du type de la question

    echo "Type de question:"

    select type in 'mcq' 'commandname' 'simplecommand' 'compoundcommand' 'script' 'freequestion'; do
        if test validateType $type; then
            break
        else
            echo "[ERREUR] $ERROR_MESSAGE" >&2
        fi
    done

    # Choix de la difficulté

    echo "Difficultés possible:"
    echo "1. Debutant"
    echo "2. Intermediaire"
    echo "3. Expert"

    echo "Choisir la difficulté de la question: "
    read difficulty

    while test ! validateDifficulty $difficulty; do
        echo "[ERREUR] $ERROR_MESSAGE" >&2
        echo "Choisir la difficulté de la question: "
        read difficulty 
    done

    # Choix de la visibilité

    echo "Visibilité de la question:"

    select visibility in 'hidden' 'exam' 'training'; do
        if test validateVisibility $visibility; then
            break
        else
            echo "[ERREUR] $ERROR_MESSAGE" >&2
        fi
    done

    # Choix de la durée

    echo "Saisir la durée de la question (en minutes) (float): "
    read duration

    while test ! validateDuration $duration; do
        echo "[ERREUR] $ERROR_MESSAGE" >&2
        echo "Saisir la durée de la question (en minutes) (float): "
        read duration
    done
}

# Verifie que le type de la question est correct
function validateType() {
    local type=$1

    if test "$type" != "mcq" -a "$type" != "commandname" -a "$type" != "simplecommand" -a "$type" != "compoundcommand" -a "$type" != "script" -a "$type" != "freequestion"; then
        ERROR_MESSAGE="Type invalide."
        return 1
    fi
}

# Verifie la longueur de la question
function validateQuestion() {
    local question=$1

    if test ${#question} -le 5; then
        ERROR_MESSAGE="Question trop court."
        return 1
    fi

    return 0
}

# Verifie que la difficulté de la question est valide
function validateDifficulty() {
    local difficulty=$1

    if test $difficulty -lt 1 -o $difficulty -gt 3; then
        ERROR_MESSAGE="Difficulté invalide."
        return 1
    fi

    return 0
}

# Verifie que la visibilité de la question est valide
function validateVisibility() {
    local visibility=$1

    if test "$visibility" != "hidden" -a "$visibility" != "training" -a "$visibility" != "exam"; then
        ERROR_MESSAGE="Visibilité invalide."
        return 1
    fi

    return 0
}

# Verifie que la durée de la question est valide
function validateDuration() {
    local duration=$1

    if test $duration -lt 0 -o $duration -gt 120; then
        ERROR_MESSAGE="Durée invalide."
        return 1
    fi

    return 0
}

function mainAddQuestion() {
    # TODO
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
	echo "=== Question ==="
	echo "$QUESTION"

	includeSubType
	showQuestion	
}

# Inclut "la classe" du type de question
# Necessite $TYPE

function includeSubType() {
	case $TYPE in
        'mcq')
            source "$CODE_DIR/MCQ.sh"
            ;;
        'commandname')
            source "$CODE_DIR/CommandName.sh"
            ;;
        'compoundcommand')
            source "$CODE_DIR/CompoundCommand.sh"
            ;;
        'freequestion')
            source "$CODE_DIR/FreeQuestion.sh"
            ;;
        'script')
            source "$CODE_DIR/Script.sh"
            ;;
        *)
	       dokuError "TYPE invalide: $TYPE"
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


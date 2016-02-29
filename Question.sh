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
	local module=$(param module)
    local question=$(param question)
    local duration=$(param duration)
    local difficulty=$(param difficulty)
    local visibility=$(param visibility)
    local type=$(param type)

    if test ! validateType $type; then
        return 1
    fi

    if test ! validateQuestion $question; then
        return 1
    fi

    if test ! validateDifficulty $difficulty; then
        return 1
    fi

    if test ! validateVisibility $visibility; then
        return 1
    fi

    if test ! validateDuration $duration; then
        return 1
    fi

    # Inclure le sous-type en question et appeller la methode correspondante
    source "$CODE_DIR/$type.sh"

    EXTRA_DATA=`dokuwikiAddQuestion`
    returnCode=$?

    if test $returnCode -ne 0; then
       	ERROR_MESSAGE=$returnCode
        return 1
    fi

    TYPE=$type
    ID=`getNextId $module`
    QUESTION=`urlDecode $question`
    DIFFICULTY=$difficulty
    DURATION=$duration
    VISIBILITY=$visibility

    saveQuestionToFile $module
}

function getNextId() {
	local module=$1
	local id=$RANDOM
	
	local questionsDir="$DB_MODULES_DIR/$module/questions"
	
	while test -e "$questionsDir/$id.txt"; do
		id=$RANDOM
	done
	
	echo $id
}

function saveQuestionToFile() {
    local module=$1

    local moduleDir="$DB_MODULES_DIR/$module"
    local questionFile="$moduleDir/questions/$ID.txt"

    # Est-ce que le module existe bien ?
    if test ! -d $moduleDir; then
        dokuError "Module inexistant."
    fi

    cat << EOF > $questionFile
=== type ===
$TYPE

=== difficulty ===
$DIFFICULTY

=== visibility ===
$VISIBILITY

=== duration ===
$DURATION
    
=== question ===
$QUESTION

$EXTRA_DATA
EOF

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

    if test "$type" != "MCQ" -a "$type" != "CommandName" -a "$type" != "SimpleCommand" -a "$type" != "CompoundCommand" -a "$type" != "Script" -a "$type" != "FreeQuestion"; then
        ERROR_MESSAGE="Type invalide."
        return 1
    fi

    return 0
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
    	ERROR_MESSAGE="mainLoadQuestion: QUESTIONPATH non definie !"
		return 1
    fi

	# Si la variable d'environnement "QUESTIONID" n'est pas definie

    if test -z $QUESTIONID; then
    	ERROR_MESSAGE="mainLoadQuestion: QUESTIONID non definie !"
		return 1
	fi 
	
	# On verifie si le fichier existe et si c'est un fichier ordinaire
    if test ! -f "$QUESTIONPATH/$QUESTIONID.txt"; then
    	ERROR_MESSAGE="mainLoadQuestion: Le fichier de la question n'existe pas !"
		return 1
	fi

	# On verifie si le fichier est lisible par l'utilisateur courant
    if test ! -r "$QUESTIONPATH/$QUESTIONID.txt"; then
    	ERROR_MESSAGE="mainLoadQuestion: Fichier illisible (droits de fichier) !"
		return 1
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
	
	if test ! -f "$CODE_DIR/$TYPE.sh"; then
		ERROR_MESSAGE="mainLoadQuestion: Type incorrect !"
		return 1
	fi
	
	source "$CODE_DIR/$TYPE.sh"
	loadQuestion
}

function mainShowQuestion() {
	#echo "$QUESTION"

	source "$CODE_DIR/$TYPE.sh"
	showQuestion
	
	return 0
}

function mainToString() {
	echo "id: $ID"
	echo "question: $QUESTION"
	echo "difficulty: $DIFFICULTY"
	echo "isExamQuestion: $ISEXAMQUESTION"
	echo "duration: $DURATION"
	echo "type: $TYPE"

	source "$CODE_DIR/$TYPE.sh"
	toString
}


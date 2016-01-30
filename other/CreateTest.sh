#! /bin/bash

. EvalLib.sh

# Si le module n'est pas défini

if test -z $MODULE; then
	echo "CreateTest : Module inconnu" >&2
	exit 1
fi

#export QUESTIONPATH="$PWD/../Modules/$MODULE/questions"
echo $QUESTIONPATH
listQ="`./FindQuestionRandom.sh`"

for question in $listeQ; do
	
	echo `parseQuestionFile 1 $question`
		
done	

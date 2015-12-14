#! /bin/bash

source EvalLib.sh

# Si le module n'existe pas
if test -z $MODULE; then 
	echo "FindQuestion : Module inconnu" >&2
	exit 1
fi

# Si le cours ou les cours n'existe pas
if test -z $COURSES; then
	echo "Cours inconnu" >&2
	exit 2
fi

#Si la variable environnement "KEYWORDS" n'est pas définie

if test -z $KEYWORDS; then
	echo "FindQuestion : KEYWORDS non definie !" >&2
	exit 3
fi


#Variables env definies: MODULE , COURSES et KEYWORDS

#Pour chaque mot clé dans KEYWORDS
for keyword  in $KEYWORDS; do

	echo $keyword
	#Pour chaque question présente dans le dossier question
	for question in `ls $QUESTIONPATH`; do

		#Si question est un fichier
		if [ -f "$QUESTIONPATH/$question" ]; then

			#Récupère les mot clés de la question
			questionId=`echo $question|cut -d . -f 1`
  			QKeywords=`parseQuestionFile "keywords" $questionId`
			#Pour chaque mot clé de la question
			for Qkeyword in $QKeywords; do

				#Si QKeyword est égal au mot clé recherché
				if [ $Qkeyword = $keyword ] ; then
					echo $question
					echo $Qkeyword
				fi 
			done 
   		fi
		
	done
done




#! /bin/bash

# Si le module n'existe pas
if test -z $MODULE then 
	echo "Module inconnu" >&2
	exit 1
fi

# Si le cours ou les cours n'existe pas
if test -z $COURSES then
	echo "Cours inconnu" >&2
	exit 2
fi

#Variables env definies: Module et Courses

while read 



#courseData=`cat $COURSESPATH/$.txt`
#
#
#if test $? -ne 0; then
#        echo "ShowQuestion: Le fichier de la question $QUESTIONID n'existe pas" >&2
#        exit 3
#fi



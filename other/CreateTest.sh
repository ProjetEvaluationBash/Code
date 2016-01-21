#! /bin/bash

. EvalLib.sh

# Si le module n'est pas défini

if test -z $MODULE; then
	echo "CreateTest : Module inconnu" >&2
	exit 1
fi

echo "veuillez donner les numéros de cours sur lesquels vous voulez génerer un test :"
read COURSES
for course in $COURSES; do
	if [ "$(echo $var | grep "^[ [:digit:] ]*$")"]; then
		echo "c'est un chiffre"
	fi
done 

export COURSES



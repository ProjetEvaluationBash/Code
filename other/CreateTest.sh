#! /bin/bash

. EvalLib.sh

# Si le module n'est pas défini

if test -z $MODULE; then
	echo "CreateTest : Module inconnu" >&2
	exit 1
fi

echo "veuillez donner les numéros de cours sur lesquels vous voulez génerer un test :"
read courses

for course in $courses 
	if



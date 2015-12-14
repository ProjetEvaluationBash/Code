#! /bin/bash

source EvalLib.sh

#Si le module n'est pas définie
if test -z $MODULE; then
	echo "CreateTest : Module inconnu" >&2
	exit 1
fi

echo "veuillez donner les numéros de cours sur lesquels vous voulez génerer un test :"
read courses

for course in $courses 
	if



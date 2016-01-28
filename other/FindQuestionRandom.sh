#! /bin/bash

PROGNAME=$(basename $(readlink -f $0))

. EvalLib.sh

#Si le module n'existe pas

nbQS=10
i=0

if test -z $MODULE; then
	echo $PROGNAME": Module non défini" >&2
	exit 1
fi

nbDoss=`cd ../questions; ls -l | grep .txt  | wc -l`


while [ $i -lt $nbQS ]
do
	value=$((RANDOM % $nbDoss + 1))
	listeQ+=" "
	for question in $listeQ; do
		if [ $question = $value ]; then
			i=$(($i-1))
			change="o"	
		fi
	done
	if [[ "$change" == "n" ]] ; then
		listeQ+=$value
	fi	
	i=$(($i + 1))
	change="n"
done

echo $listeQ

#!/bin/bash

echo "Quelle est la question que vous voulez supprimer ?"
read nbr

nbDoss=`cd ../Modules/$MODULE/questions; ls -l | grep .txt  | wc -l`

if nbr > nbDoss ; then
	echo "Cette question n'existe pas"
	exit (1)
fi

system("rm nbr.txt")



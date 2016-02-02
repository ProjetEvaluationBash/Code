#! /bin/bash

#Fonction qui permet de sélectionner le numéro des questions a donner à l'utilisateur de manière aléatoire
#Précondition : Le module doit être renseigné en variable env "MODULE"
#Necessite 0 ou 1 argument
#L'argument 1 permet de spécifier le nombre de questions souhaité
#S'il n'est pas spécifié, le nombre de questions par défaut est fixé a 10

PROGNAME=$(basename $(readlink -f $0))





#Permet de fixé le nombre de question souhaité
if [ "$1" == "" ] ; then
	nbQS=10
else 
	nbQS=$1
fi
i=0


#Si le module n'est pas spécifié ==> erreur
if test -z $MODULE; then
	echo $PROGNAME": Module non défini" >&2
	exit 1
fi

if test -z $HOME; then
	echo $PROGNAME": Home non défini" >&2
	exit 1	
fi

#Calcule le nombre de questions présentent dans le dossier questions
nbDoss=`cd $HOME/Code/Modules/$MODULE/questions; ls -l | grep .txt  | wc -l`


#Boucle permettant l'ajout dans la liste
while [ $(($i-1)) -lt $nbQS ]
do
	#Tire un numéro de questio au hasard
	value=$((RANDOM % $nbDoss + 1))
	listeQ+=" "
	for question in $listeQ; do
		#Si le numéro est déjà dans la liste
		if [ $question = $value ]; then
			i=$(($i-1))
			change="o"	
		fi
	done
	#Si la valeur est correcte on l'ajoute dans la liste
	if [[ "$change" == "n" ]] ; then
		listeQ+=$value
	fi	
	i=$(($i + 1))

	change="n"
done

echo $listeQ

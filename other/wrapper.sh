#!/bin/bash

# Detail du script: WRAPPER
# Script permettant d'ajouter une ou plusieurs variable d'environnement 
# et execute un script associer
#

## Fonction: err_arg()
## Detail: Fonction permettant d'afficher une erreur  concernant le nombre d'argument survenue au lancement du programme
## Argument: aucun
## Retour: Quitte le programme si erreur et afficher sur la sortie d'erreur
err_nbarg(){
	echo "Error: Probleme d'argument (nombre d'argument non valide)">&2
	exit 1;
}


while [ $# -gt 1 ]; do
	eval "export $1" || err_nbarg
	shift
done

$1




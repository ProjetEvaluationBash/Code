#!/bin/bash

# Décode le script de la requête
# $1 : le nom du fichier à générer
scriptDecode() {
        cat /tmp/query-$$.tmp | sed -re 's/^.*&script=//' | \
                php -r 'echo urldecode(fgets(STDIN));' | tr -d '\r' > $1
}


# $1 : suffixe des fichiers : script, params, stdin, stdout, stderr et return
# $2 : fichier du script
# Les autres paramètres sont passés au script

# En retour :
# De nombreux fichiers dans /tmp décrivant l'exécution :
# /tmp/script-$suffixe : le script exécuté : le script exécuté
# /tmp/params-$suffixe : les paramètres passés au script.
# /tmp/stdin-$suffixe  : l'entrée standard passée au script.
# /tmp/stdout-$suffixe : la sortie standard du script.
# /tmp/stderr-$suffixe : la sortie d'erreur du script.
# /tmp/return-$suffixe : la valeur de retour du script.

# Remarques : 
#    * pour créer un script à partir de l'entrée script d'un formulaire
#      utiliser scriptDecode().
#
#    * un suffixe classique est le pid du processus courant ($$)

executeScriptSshRaw() {
	local suffixe=$1
	local scriptFile=$2
	shift 2

	echo -n "$@" > /tmp/params-$suffixe

	# Copie du script	
	scp-guest $scriptFile guest@localhost:/tmp/script-$suffixe

	# Exécution du script
	ssh-guest guest@localhost " 
		chmod 700 /tmp/script-$suffixe;
                tee /tmp/stdin-$suffixe | /tmp/script-$suffixe $@> /tmp/stdout-$suffixe 2> /tmp/stderr-$suffixe; 
                echo \$? > /tmp/return-$suffixe; 
                "

	# Récupération des fichiers
	for i in /tmp/stdin-$suffixe /tmp/stdout-$suffixe /tmp/stderr-$suffixe /tmp/return-$suffixe; do
		scp-guest guest@localhost:$i /tmp
	done

	# Supression des fichiers
	ssh-guest guest@localhost rm -f /tmp/script-$suffixe /tmp/stdin-$suffixe \
                /tmp/stdout-$suffixe /tmp/stderr-$suffixe /tmp/return-$suffixe
}

# Supprime les fichiers temporaires locaux relatifs à l'exécution d'un script
# $1 : le suffixe
cleanScriptSsh() {
	local suffixe=$1
	rm -f /tmp/script-$suffixe /tmp/params-$suffixe /tmp/stdin-$suffixe \
		/tmp/stdout-$suffixe /tmp/stderr-$suffixe /tmp/return-$suffixe
}


# Affiche le rapport d'exécution du script
# $1 : le suffixe associé au script

reportScriptSsh() {
	local suffixe=$1
	echo "PARAMS :"
	cat /tmp/params-$suffixe
	echo "STDIN  :"
	cat /tmp/stdin-$suffixe
    echo "STDOUT :"
	cat /tmp/stdout-$suffixe
	echo "STDERR :"
	cat /tmp/stderr-$suffixe
	echo "RETURN :"
	cat /tmp/return-$suffixe
}

executeScriptSsh() {
        echo "<html><title></title><body><pre>"
        echo "Points : 1/1"

        tmpScript=/tmp/script-$$
        scriptDecode $tmpScript

	executeScriptSshRaw $$ $tmpScript	

	reportScriptSsh $$

	
}

runRequest() {
	cgiHeader
	executeScriptSsh
}

evaluateScript() {
	echo $1 >> /tmp/query-$$	
	cgiHeader
	executeScriptSsh
		
}


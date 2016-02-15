#!/bin/bash

lockFile="/tmp/commitAndPush.lock"
pid=`$$`

# setGitConfig(name, email)

function setGitConfig() {
	local credentialsFile="/home/info/.git-credentials-$3"

	git config user.name "$1"
	git config user.email "$2"
	git config credential.username "$3"
	
	if test -f $credentialsFile; then
		# Le fichier existe, l'utilisateur a déjà autorisé le stockage du token OAuth
		git config credential.helper "store --file=$credentialsFile"
	else
		# Le fichier n'existe pas, demander l'autorisation de l'utilisateur
		echo "Souhaitez-vous stocker votre token OAuth sur info@fraise ? [o/N] "
		read -n 1 -r
		echo ""	

		if [[ $REPLY =~ ^[Oo]$ ]]; then
			# L'utilisateur souhaite stocker son token OAuth
			git config credential.helper "store --file=$credentialsFile"
		else
			# S'assurer qu'aucun helper stock le mot de passe de l'utilisateur
			git config --unset-all credential.helper
		fi
	fi
}

function deleteLockFile() {
	rm $lockFile

	if test $? -ne 0; then
		echo "[ERROR] Problème rencontré lors de la suppression du fichier lock"
		exit 1
	fi
}

# Est ce que le fichier lock existe ?
if test -f $lockFile; then
	# Extraire le PID du processus derrière le lock
	lockPid=`cat $lockFile`
	
	# Est ce que ce PID est encore en cours d'execution ?
	kill -0 $lockPid > /dev/null 2>&1

	if test $? -eq 0; then
		# Processus toujours en cours d'execution
		echo "[ERROR] CommitAndPush est en cours d'utilisation (PID: $lockPid)" >&2
		exit 1
	fi

	# Processus arrêté, on supprime le lock
	deleteLockFile
fi

# Mettre le PID du processus actuel dans le lockfile
echo $pid > $lockFile

if test $# -eq 0; then
	echo "[ERROR] Aucun nom d'utilisateur fourni." >&2
	exit 1
fi

username=$1

case $username in
	'lijack')
		setGitConfig "Liam JACK" "liam.jack@etu.udamail.fr" "cuonic"		
		;;
	'pipic1')
		setGitConfig "Pierre PIC" "pierre.pic@etu.udamail.fr" "pipic1"
		;;
	'flmousse')
		setGitConfig "Florian MOUSSE" "florian.mousse@etu.udamail.fr" "Mouuss"
		;;
	'mamoulin11')
		setGitConfig "Mario MOULIN" "mario.moulin@etu.udamail.fr" "oiraMm"
		;;
	'jegrand5')
		setGitConfig "Jean-Baptiste GRAND" "jean-baptiste.grand@etu.udamail.fr" "jbProjet"
		;;
	'gudavala')
		setGitConfig "Guénal DAVALAN" "guenal.davalan@udamail.fr" "gd-test"
		;;
	*)
		echo "[ERROR] Nom d'utilisateur inconnu." >&2
		exit 2
esac

# Commit
git commit

if test $? -ne 0; then
	exit 1
fi

# Pull les modifications exterieures
git pull origin master

if test $? -ne 0; then
	exit 2
fi

# Push les modifications
git push origin master

# Supprimer le fichier de lock
deleteLockFile
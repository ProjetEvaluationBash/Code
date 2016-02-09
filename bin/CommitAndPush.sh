#!/bin/bash

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

		if test $REPLY =~ ^[Oo]$; then
			# L'utilisateur souhaite stocker son token OAuth
			git config credential.helper "store --file=$credentialsFile"
		else
			# S'assurer qu'aucun helper stock le mot de passe de l'utilisateur
			git config credential.helper ""
		fi
	fi
}

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
	'mamoulin')
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

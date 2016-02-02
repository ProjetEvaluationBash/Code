#!/bin/bash

# setGitConfig(name, email)

function setGitConfig() {
	git config user.name "$1"
	git config user.email "$2"
}

if test $# -eq 0; then
	echo "[ERROR] Aucun nom d'utilisateur fourni." >&2
	exit 1
fi

username=$1

case $username in
	'lijack')
		setGitConfig "Liam JACK" "liam.jack@etu.udamail.fr"		
		;;
	'pipic1')
		setGitConfig "Pierre PIC" "pierre.pic@etu.udamail.fr"
		;;
	'flmousse')
		setGitConfig "Florian MOUSSE" "florian.mousse@etu.udamail.fr"
		;;
	'mamoulin')
		setGitConfig "Mario MOULIN" "mario.moulin@etu.udamail.fr"
		;;
	'jegrand5')
		setGitConfig "Jean-Baptiste GRAND" "jean-baptiste.grand@etu.udamail.fr"
		;;
	'gudavala')
		setGitConfig "Guénal DAVALAN" "guenal.davalan@udamail.fr"
		;;
	*)
		echo "[ERROR] Nom d'utilisateur inconnu." >&2
		exit 2
esac

# Commit
git commit

# Pull les modifications exterieures
git pull origin master

# Push les modifications
git push origin master

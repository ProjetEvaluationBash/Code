#!/bin/bash

usernameok="false"

echo -n "Nom d'utilisateur: "
read username

while test "$usernameok" == "false"; do
	while test "${#username}" -lt 5 -o "${#username}" -gt 30; do
		echo "[ERREUR] Nom d'utilisateur invalide."
		echo -n "Nom d'utilisateur: "
		read username
	done

	result=`cat utilisateurs.txt | grep $username`

	if test $? -eq 0; then
		usernameok="true"
	fi

	echo -n "Mot de passe: "
	read -s password

	echo

	if test "$usernameok" == "false"; then
		echo "[ERREUR] Nom d'utilisateur / mot de passe incorrect."
		exit 1
	fi

	password=`echo $password | openssl passwd -crypt -salt $username -stdin`
	userpassword=`echo $result | cut -d "|" -f 2`

	if test "$password" == "$userpassword"; then
		echo "[SUCCES] Vous êtes desormais connectés."
		exit 0
	else
		echo "[ERREUR] Nom d'utilisateur / mot de passe incorrect."
		exit 1
	fi
done
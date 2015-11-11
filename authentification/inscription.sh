#!/bin/bash

usernameok="false"
passwordok="false"

echo -n "Nom d'utilisateur: "
read username

while test "$usernameok" == "false"; do
	while test "${#username}" -lt 5 -o "${#username}" -gt 30; do
		echo "[ERREUR] Nom d'utilisateur invalide."
		echo -n "Nom d'utilisateur: "
		read username
	done

	result=`cat utilisateurs.txt | grep $username`

	if test $? -ne 0; then
		usernameok="true"
	else
		echo "[ERREUR] Nom d'utilisateur déjà utilisé."
		echo -n "Nom d'utilisateur: "
		read username
	fi
done

# Le nom d'utilisateur est valide et n'est pas déjà pris

echo -n "Mot de passe: "
read -s password
while test "$passwordok" == "false"; do
	while test "${#password}" -lt 8; do
		echo
		echo "[ERREUR] Mot de passe trop court."
		echo -n "Mot de passe: "
		read -s password
	done

	echo
	echo -n "Confirmation du mot de passe: "
	read -s repeatpassword

	if test "$repeatpassword" == "$password"; then
		passwordok="true"
		unset repeatpassword
	else
		echo
		echo "[ERREUR] Les mots de passe ne correspondent pas."
		echo -n "Mot de passe: "
		read -s password
	fi
done

# Le mot de passe est valide

# Hashage du mot de passe
password=`echo $password | openssl passwd -crypt -salt $username -stdin`

echo "$username|$password" >> utilisateurs.txt
echo

if test $? -eq 0; then
	echo "[SUCCES] Utilisateur ajouté."
	exit 0
else
	echo "[ERREUR] Problème rencontré lors de l'ajout de l'utilisateur."
	exit 1
fi
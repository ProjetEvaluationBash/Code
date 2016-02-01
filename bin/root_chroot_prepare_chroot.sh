#!/bin/bash

# A lancer par root.
# nécessite la présence de clés ssh sur le compte accueillant le chroot
#
# Prépare l'environnement chroot mais également le serveur ssh dans 
# l'environnement chroot (port 2222).
#
# Crée et configure le compte CHROOT_USER de l'environnement chroot.

set -e # arrêt à la moindre erreur
set -u # arrêt dès que variable non initialisée utilisée

# Utilisateur hébergeant le chroot
CHROOT_OWNER=info

# Répertoire du chroot
CHROOT_DIR=~info/chroot

# Système du chroot
CHROOT_DISTRIB=jessie

# Utilisateur chroot
CHROOT_USER=guest


usage() {
	echo "$($basename $0) : cf. README.txt" >&2
	exit 1 
}

# main

[ $LOGNAME != root ] && { echo "root only !">&2; exit 1; }

f=/home/$CHROOT_OWNER/.ssh/id_rsa.pub
[ ! -e $f ] && { 
	echo "User $CHROOT_OWNER need $f (ssh-keygen -t rsa ?)" >&2
	exit 1
}

first=0

# débootstrap

[ -d $CHROOT_DIR ] || { debootstrap $CHROOT_DISTRIB $CHROOT_DIR; first=1; }

# mounte les répertoires
f=$CHROOT_DIR/proc; mount | grep -q $f || mount --bind /proc $f
f=$CHROOT_DIR/dev/pts; mount | grep -q $f || mount -t devpts devpts $f
f=$CHROOT_DIR/sys; mount | grep -q $f || mount --bind /sys $f

[ $first = 0 ] || {
	chroot $CHROOT_DIR bash -c "export DEBIAN_FRONTEND=noninteractive; apt-get -y install perl-modules locales"
	cp /etc/locale.gen $CHROOT_DIR/etc/locale.gen
	chroot $CHROOT_DIR locale-gen

	# installe ssh

	chroot $CHROOT_DIR bash -c "export DEBIAN_FRONTEND=noninteractive; apt-get -y install ssh"
	sed -rie 's/Port 22/Port 2222/' $CHROOT_DIR/etc/ssh/sshd_config
}

# création du compte

f=$CHROOT_DIR/home/$CHROOT_USER
[ -d $f ] || {
	chroot $CHROOT_DIR useradd -m -s '/bin/bash' -p $(openssl rand -base64 32) guest
}

# Enregistrement de la clé ssh dans ~$CHROOT_USER/.ssh/authorized_keys
[ -e $f/.ssh/authorized_keys ] || {
	[ -d $f/.ssh ] || {
		chroot $CHROOT_DIR su - -c "mkdir .ssh" guest
		chroot $CHROOT_DIR su - -c "chmod 700 .ssh" guest
	}
	cat /home/$CHROOT_OWNER/.ssh/id_rsa.pub |
		chroot $CHROOT_DIR su - -c "cat >> .ssh/authorized_keys" guest

	chroot $CHROOT_DIR su - -c "chmod 600 .ssh/authorized_keys" guest
}



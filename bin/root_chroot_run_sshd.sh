#!/bin/bash

# A lancer par root.
# nécessite la présence de clés ssh sur le compte accueillant le chroot

# Répertoire du chroot
CHROOT_DIR=/home/info/chroot

set -e # arrêt à la moindre erreur
set -u # arrêt dès que variable non initialisée utilisée


usage() {
	echo "$($basename $0) : cf. README.txt" >&2
	exit 1 
}

# main
[ $LOGNAME != root ] && { echo "root only !">&2; exit 1; }


# mounte les répertoires
f=$CHROOT_DIR/proc; mount | grep -q $f || mount --bind /proc $f
f=$CHROOT_DIR/dev/pts; mount | grep -q $f || mount -t devpts devpts $f
f=$CHROOT_DIR/sys; mount | grep -q $f || mount --bind /sys $f

/usr/sbin/chroot $CHROOT_DIR /etc/init.d/ssh start


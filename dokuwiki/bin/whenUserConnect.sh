#!/bin/bash

. $HOME/Code/.evalrc

lockdir=/tmp/lockdb
#dbfile="$HOME/db"
dbfile="$DB_FILE"
user=$1
hash=$(cat $2)

while ! mkdir $lockdir; do sleep 1; done

[ ! -e $dbfile ] && {
	touch $dbfile
	chmod 600 $dbfile
}

tmp=$(mktemp)
chmod 600 $tmp
grep -v "$user " $dbfile >> $tmp
echo "$user $hash" >> $tmp
mv $tmp $dbfile

if [ ! -d $DOKU_USERS_DIR/$user ]; then
	mkdir -p $DOKU_USERS_DIR/$user

	tmp=$(mktemp)
	chmod 600 $tmp
	file="$DOKU_CONF_DIR/acl.auth.php"
	grep -v "users:$user " $file >> $tmp
	echo "users:$user:* @ALL 0" >> $tmp
	echo "users:$user:* $user 1" >> $tmp
	mv $tmp $file
fi

rmdir $lockdir

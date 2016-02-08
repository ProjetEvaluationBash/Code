#! /bin/bash

showTestItem() {
        cat << EOF >> $out
  * [[$DOKU_CGI?module=$module&exam=$1&action=displayTrainingForm|$1]] ([[$DOKU_CGI?module=$module&test=$1&action=delTest|supprimer]])   
EOF
}



runRequest() {
	local dokuName=manage_training
	local out=$DOKU_USERS_DIR/$DokuUser/$dokuName.txt
	local module=$(param module)

	cat << EOF > $out
====== Générer un test a propros du module $module =====
<html>
<form name="myForm" action="$DOKU_CGI" method="POST">
<input type="hidden" name="module" value="$module">
<input type="hidden" name="action" value="createTest">
<p>
Nom de l'entrainement:
<input type="text" name="name" value="">
<p>
</br>
<p>
<input type="submit" value="Générer mon test">
</form>
</html>




====== Liste des entraînements en cours ======

EOF

	local list="$(ls $DB_USERS_DIR/$DokuUser/$module/tests)"


        if [ -z "$list" ]; then
                echo "Aucun test encore défini !" >> $out
        else
                for i in $list; do
                        showTestItem $i
                done
        fi


	cgiHeader		
	redirect users:$DokuUser:$dokuName

}

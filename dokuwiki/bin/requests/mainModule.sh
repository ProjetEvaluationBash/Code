#!/bin/bash

runRequest() {
	local out=$DOKU_USERS_DIR/$DokuUser/main_module.txt
        local module=$(param module)

        cat << EOF > $out
====== Module ($module) ======
  * Faire un entrainement
  * Faire un examen
EOF

if userIsProf; then
        cat << EOF >> $out

Opérations réservées :

  * Ajouter des questions
  * Consulter les notes
  * Créer un examen

Tests :

  * [[https://fraise.u-clermont1.fr/info/cgi-bin/run.sh?module=$module&action=questionsList|Lister les questions]]
  * [[https://fraise.u-clermont1.fr/info/cgi-bin/run.sh?module=$module&action=executeCommand|Executer une commande]]
  * [[https://fraise.u-clermont1.fr/info/cgi-bin/run.sh?module=$module&action=executeScript|Executer un script]]

EOF

fi

        cgiHeader
        redirect users:$DokuUser:main_module
}

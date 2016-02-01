#!/bin/bash

runRequest() {
	local out=$DOKU_USERS_DIR/$DokuUser/main_module.txt
        local module=$(param module)

        cat << EOF > $out
====== Module ($module) ======
  * [[$DOKU_CGI?module=$module&action=manageTrainingTest|Faire un entrainement]]
  * Faire un examen
EOF

if userIsProf; then
        cat << EOF >> $out

Opérations réservées :

  * Ajouter des questions
  * Consulter les notes
  * Créer un examen

Tests :

  * [[$DOKU_CGI?module=$module&action=questionsList|Lister les questions]]
  * [[$DOKU_CGI?module=$module&action=executeCommand|Executer une commande]]
  * [[$DOKU_CGI?module=$module&action=executeScript|Executer un script]]

  * [[$DOKU_CGI?module=$module&action=manageExamTest|Gérer les examens]]
 
EOF

fi

        cgiHeader
        redirect users:$DokuUser:main_module
}
